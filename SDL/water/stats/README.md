# Статистика задания 2 для app_water

Динамическая трасса использования IR-инструкций `User <- Operand` моего
приложения [`../app_water.c`](../app_water.c), собранная инструментирующим
проходом из задания 1 ([llvm-ir-use-trace](https://github.com/Artemusss/llvm-ir-use-trace),
`TraceUsePass.cpp`), и частоты паттернов длины 1–5. На этой статистике
построена ISA задания 4 — [`../asm/ISA.md`](../asm/ISA.md).

## Как получено

- IR: `clang -O2` (только логический модуль `app_water.c`), затем
  `opt -passes=trace-use` (User = не-`phi`, операнд-`phi` разворачивается в
  его входы — задание со звёздочкой).
- Запуск: 2 кадра без ограничения длины трассы (`TRACE_MAX=0 SIM_FRAMES=2`) —
  покрывает все функции: `drop` (начальная капля и капля при `t = 0`,
  с `simRand`), `step`, `render` → `shade` → `drawBlock`, `simFlush`.
- Итого **18 494 471** use-записей, **58** различных рёбер.
- n-граммы окон 1–5: `analyze_fast.py` (numpy-версия `analyze.py` из
  задания 2 с тем же форматом вывода — штатный на 18 млн записей медленный).

```bash
# в каталоге llvm-ir-use-trace, после ./build.sh
clang -O2 -emit-llvm -S -I app app_water.c -o build/app_water.O2.ll
opt -load-pass-plugin build/libTraceUsePass.so -passes=trace-use \
    build/app_water.O2.ll -S -o build/app_water.traced.ll
clang -O2 build/app_water.traced.ll app/sim_stub.c app/start.c runtime/trace_rt.c \
    -o build/water_traced
TRACE_MAX=0 SIM_FRAMES=2 TRACE_FILE=build/trace.log ./build/water_traced
python3 analyze_fast.py build/trace.log -o stats -k 20 -n 5
```

## Файлы

| файл | что |
|---|---|
| `patterns.txt` | топ-20 паттернов для окон 1..5 |
| `patterns_n1.csv` … `patterns_n5.csv` | полные таблицы частот |
| `trace_sample.log` | первые 3000 записей трассы (полная — 240 МБ, не коммитится) |
| `analyze_fast.py` | скрипт анализа |

## Главное (окно 1, доля от всех use-записей)

| User-опкод | доля | | Ребро | доля |
|---|---|---|---|---|
| `call` | 32.60% | | `call <- add` | 18.43% |
| `add` | 18.28% | | `call <- mul` | 8.50% |
| `or` | 10.11% | | `load <- getelementptr` | 6.07% |
| `getelementptr` | 7.01% | | `add <- mul` | 5.67% |
| `load` | 6.07% | | `add <- add` | 3.74% |
| `ashr` | 4.98% | | `sub <- load` | 3.20% |
| `sub` | 4.29% | | `icmp <- add` | 3.01% |
| `and` | 4.25% | | `or <- and` | 2.84% |
| `icmp` | 3.01% | | `add <- ashr` | 2.83% |
| `shl` | 2.84% | | `or <- or` | 2.83% |
| `br` | 1.59% | | `call <- trunc` | 2.83% |
| `mul` | 1.42% | | `br <- icmp` | 1.59% |

Почти треть трассы — аргументы `simPutPixel` в `drawBlock` (блок 3×3 на
клетку): окна 3–5 целиком состоят из `call <- add/mul` подряд.
