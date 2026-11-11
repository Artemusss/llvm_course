# app_water на своей ISA: симулятор и ASM2IR (задание 4)

| Пункт задания | Где |
|---|---|
| 1. Свой набор инструкций по статистике задания 2 и IR приложения | [`ISA.md`](ISA.md), таблица [`include/ISA.h`](include/ISA.h); статистика — [`../stats/`](../stats/README.md) |
| 2. Приложение на своём ASM | [`app_water.myasm`](app_water.myasm) |
| 3. ASM2IR с вызовами эмулирующих функций (кроме потока управления) + ExecutionEngine | режим 2, [`extIR.cpp`](extIR.cpp) |
| 4. ASM2IR с IR-эквивалентами всех инструкций + ExecutionEngine | режим 3, [`fullIR.cpp`](fullIR.cpp); выгруженный IR — [`app_water.gen.ll`](app_water.gen.ll) |
| 5*. Симуляция без IR, только эмулирующие функции | режим 1, [`cpu.cpp`](cpu.cpp) |

Устроено как продвинутый пример курса [`Sim/`](../../../Sim): одна X-macro
таблица `ISA_(...)` даёт для каждой инструкции разбор ASM, эмулирующую функцию
`CPU::do_<Name>` (её тело — `Execute`) и генерацию IR (`IRGenExecute`).

- **Режим 1** — цикл выборки: для каждой инструкции вызывается `do_<Name>`,
  переходы — через `NextPC`.
- **Режим 2** — IR, где каждая не-управляющая инструкция = `call @do_<Name>(R1, R2, R3Imm)`,
  а `JMP/BNZ/BZ/HALT` — нативные `br`/`ret`; условие берётся из `@regFile`,
  отображённого на регистры CPU (`addGlobalMapping`). Эмулирующие функции
  подставляет `InstallLazyFunctionCreator`.
- **Режим 3** — только IR: регистры в `alloca [32 x i32]`, память — глобальный
  `@mem [262144 x i32]`, графика — прямые `call @simPutPixel/@simFlush/@simRand`.

## ОС и зависимости

Ubuntu 22.04/24.04 (проверено на 24.04, LLVM 18.1.3). Windows — через WSL2.

```bash
sudo apt update
sudo apt install -y clang-18 llvm-18 llvm-18-dev libsdl2-dev
```
`clang`, `clang++`, `llvm-config`, `opt` должны быть одной версии
(`llvm-config --version`).

## Запуск

```bash
cd SDL/water/asm

# окно SDL (как обычные приложения курса)
SIM=../../sim.c ./build.sh
./run.sh 1        # режим 1: симуляция (п.5*)
./run.sh 2        # режим 2: IR + эмулирующие функции + ExecutionEngine (п.3)
./run.sh 3        # режим 3: полный IR + ExecutionEngine (п.4)
# закрыть окно — выход

# выгрузить IR режима 3 и собрать из него обычный бинарь
./run.sh 3 app_water.gen.ll
clang -O2 app_water.gen.ll ../../start.c ../../sim.c -I ../.. -lSDL2 -o app_water_asm
./app_water_asm
```

Флаг `-v` печатает дизассемблер и сгенерированный IR: `./asmsim app_water.myasm 2 -v`.

## Проверка корректности (без окна)

```bash
./run.sh check    # сам соберёт headless-бинарь asmsim_check (app/sim_stub.c вместо SDL)
```
Заглушка считает хэш всех нарисованных пикселей `(x, y, argb)` за 20 кадров
(капли от `simRand` падают на кадрах 0 и 16). Исходный `app_water.c`, все три
режима и выгруженный IR дают один хэш:

```
app_water.c (эталон):      hash=12b31ce98530d97e
app_water.myasm, режим 1:  hash=12b31ce98530d97e
app_water.myasm, режим 2:  hash=12b31ce98530d97e
app_water.myasm, режим 3:  hash=12b31ce98530d97e
выгруженный IR (clang):    hash=12b31ce98530d97e
```
Число кадров меняется переменной `SIM_FRAMES` (на 40 кадрах — тоже совпадает).

## Файлы

```
ISA.md              описание ISA и её связь со статистикой          [п.1]
app_water.myasm     приложение на своём ASM                         [п.2]
include/ISA.h       X-macro таблица инструкций
extIR.cpp           режим 2: IR + вызовы эмулирующих функций        [п.3]
fullIR.cpp          режим 3: полный IR                              [п.4]
cpu.cpp             режим 1: симуляция                              [п.5*]
bin.cpp instr.cpp   разбор/печать ASM, словари опкодов
main.cpp            выбор режима
app_water.gen.ll    сгенерированный IR режима 3
app/sim_stub.c      headless-графика с хэшем (для проверки)
app/start.c         main() для headless-проверки
build.sh run.sh     сборка и запуск
```
