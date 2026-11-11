# ISA для app_water (задание 4, пункт 1)

Набор инструкций составлен по **статистике задания 2 для моего приложения
`app_water.c`** ([`../stats/`](../stats/README.md), 18.5 млн use-записей) и по
его `-O2` LLVM IR ([`../app_water-opt.ll`](../app_water-opt.ll)).
Машинное описание — X-macro таблица [`include/ISA.h`](include/ISA.h): из неё
генерируются парсер ASM, симулятор и оба ASM2IR-генератора.
Приложение на этой ISA — [`app_water.myasm`](app_water.myasm).

## Модель машины

- **Регистры:** `r0..r31`, 32 бита (знаковость задаёт инструкция).
- **Память:** словная (`i32`), `Mem[0 .. 262144)`. Два буфера высот сетки
  512×256: `buf1 = Mem[0..131072)`, `buf2 = Mem[131072..262144)`, обнулены
  при старте (как `int buf[N] = {}` в C).
- **Программа:** поток инструкций с метками; метка — любой токен, не
  являющийся мнемоникой. Формат `OP arg1 arg2 arg3`, аргумент — `rN`,
  знаковое число или метка. Комментарии `;` или `//`.
- **Графика:** `simPutPixel`, `simFlush`, `simRand` из `sim.h`.

## Откуда взялась каждая группа инструкций

Доли — из [`../stats/patterns.txt`](../stats/patterns.txt) (окно 1; для
опкодов — сумма рёбер, где он User).

| Что видно в статистике / IR | Доля | Решение в ISA |
|---|---|---|
| `call <- add` 18.43%, `call <- mul` 8.50%, `call <- trunc` 2.83%; окна 3–5 — сплошные `call<-add/mul` | `call` 32.6% | **`PUTBLK`** — одна инструкция на весь `drawBlock` (9 вызовов `simPutPixel` для блока 3×3) |
| `load <- getelementptr` 6.07%, `getelementptr <- getelementptr` 1.62%; доступ `src[c±1]`, `src[c±W]` | `load` 6.1%, GEP 7.0% | **`LD rd, rb, imm` / `ST`** — адрес = база + смещение, GEP слит в инструкцию памяти |
| `add <- add` 3.74%, `icmp <- add` 3.01%, `br <- icmp` 1.59%; окно 3: `add<-add , icmp<-add , br<-icmp` | | **`INC_NE` + `BNZ`** — счётчик цикла: инкремент и сравнение одной инструкцией |
| `add` 18.3%, `sub` 4.3% (сумма соседей, `− dst[c]`, `slope`) | | **`ADD`, `SUB`, `ADDI`** |
| `ashr` 4.98%: `>>1`, `>>DAMP`, `h>>3`, `slope>>1`, `lum>>3` | | **`SHRI`** (арифметический сдвиг) |
| `or` 10.1%, `shl` 2.8%, `and` 4.3%: упаковка цвета `0xFF000000 \| r<<16 \| g<<8 \| b`, `t % 16`, `& 0x3FFFFFFF` | | **`OR`, `ORI`, `SHLI`, `AND`, `ANDI`** |
| `mul` 1.42%: `lum * 5`, `gx * SCALE` | | **`MULI`** (умножение на константу) |
| `call @llvm.smax.i32` + `@llvm.umin.i32` в `shade` | | **`CLAMPI`** — `min(max(x, 0), 255)` |
| `icmp ult` (9 шт. в IR): границы в `drop`, `x>0`/`x<W-1` в `render` | | **`CMPLTUI`** — беззнаковое сравнение с константой → 0/1 |
| `urem` от `simRand` (координата капли) | | **`REMUI`**, **`RAND`** |
| обмен `a <-> b` (`phi` указателей), константы | | **`MOV`**, **`LDI`** |
| `while (1)`, `if` в `drop`, `if (t % 16 == 0)` | | **`JMP`**, **`BZ`**, **`BNZ`** |

## Инструкции

Опкод `0` зарезервирован под «не инструкция» (метку).

### Поток управления
Для них режим 2 (п.3) **не** вызывает эмулирующую функцию, а строит нативный IR.

| Опкод | Инструкция | Семантика | IR (режим 3) |
|---|---|---|---|
| `0xF0` | `HALT` | конец программы | `ret void` |
| `0x80` | `JMP label` | переход | `br label` |
| `0x81` | `BNZ rc, label` | если `rc != 0` → label | `icmp ne` + `br i1` |
| `0x82` | `BZ rc, label` | если `rc == 0` → label | `icmp eq` + `br i1` |

### Графика и внешние функции

| Опкод | Инструкция | Семантика | IR (режим 3) |
|---|---|---|---|
| `0xF1` | `FLUSH` | `simFlush()` | `call @simFlush` |
| `0x60` | `PUTBLK rx, ry, rc` | `simPutPixel(3·rx+i, 3·ry+j, rc)` для `j, i ∈ 0..2` | 2 `mul` + 9 × (`add`, `add`, `call @simPutPixel`) |
| `0x61` | `RAND rd` | `rd = simRand()` | `call @simRand` |

### Пересылки, арифметика, логика

| Опкод | Инструкция | Семантика | IR |
|---|---|---|---|
| `0x10` | `MOV rd, rs` | `rd = rs` | load/store |
| `0x11` | `LDI rd, imm` | `rd = imm` | store const |
| `0x20` | `ADD rd, ra, rb` | `rd = ra + rb` | `add` |
| `0x21` | `SUB rd, ra, rb` | `rd = ra − rb` | `sub` |
| `0x22` | `AND rd, ra, rb` | `rd = ra & rb` | `and` |
| `0x23` | `OR rd, ra, rb` | `rd = ra \| rb` | `or` |
| `0x30` | `ADDI rd, ra, imm` | `rd = ra + imm` | `add` |
| `0x31` | `MULI rd, ra, imm` | `rd = ra · imm` | `mul` |
| `0x32` | `SHLI rd, ra, imm` | `rd = ra << imm` | `shl` |
| `0x33` | `SHRI rd, ra, imm` | `rd = ra >> imm` (знаковый) | `ashr` |
| `0x34` | `ANDI rd, ra, imm` | `rd = ra & imm` | `and` |
| `0x35` | `ORI rd, ra, imm` | `rd = ra \| imm` | `or` |
| `0x36` | `REMUI rd, ra, imm` | `rd = ra mod imm` (беззнаковый) | `urem` |
| `0x37` | `CMPLTUI rd, ra, imm` | `rd = (unsigned)ra < imm` | `icmp ult` + `zext` |
| `0x38` | `CLAMPI rd, ra, imm` | `rd = min(max(ra, 0), imm)` | 2 × (`icmp` + `select`) |
| `0x39` | `INC_NE rd, rc, imm` | `rc = rc + 1; rd = (rc != imm)` | `add` + `icmp ne` + `zext` |

### Память

| Опкод | Инструкция | Семантика | IR |
|---|---|---|---|
| `0x40` | `LD rd, rb, imm` | `rd = Mem[rb + imm]` | `add` + `getelementptr @mem` + `load` |
| `0x41` | `ST rs, rb, imm` | `Mem[rb + imm] = rs` | `add` + `getelementptr @mem` + `store` |

Всего 25 инструкций; в `app_water.myasm` используются все, кроме `HALT`
(приложение — бесконечный цикл `while (1)`).

## Приёмы, которые повторяют -O2 IR

- Проверка `0 < x < W−1` → `(x−1) <u W−2` (`ADDI` + `CMPLTUI`) — ровно так её
  записывает clang (`icmp ult`).
- `cl = x > 0 ? c−1 : c` без ветвления: `&a[cl] = &a[c] − (x>0)`, аналогично `cr`.
- `y * W` → `SHLI y 9` (W = 512), `t % 16` → `ANDI t 15`.
- `0xFF000000` как `i32` = `−16777216` → `ORI r, r, -16777216`.
