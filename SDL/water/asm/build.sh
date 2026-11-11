#!/usr/bin/env bash
# Сборка asmsim — симулятора/ASM2IR-генератора своей ISA (режимы 1-3).
#   SIM=app/sim_stub.c (по умолч.) — headless;  SIM=../../sim.c — окно SDL2
set -euo pipefail
cd "$(dirname "$0")"

LLVM_CONFIG="${LLVM_CONFIG:-llvm-config}"
CXX="${CXX:-clang++}"
CC="${CC:-clang}"
SIM="${SIM:-app/sim_stub.c}"
OUT="${OUT:-asmsim}"

LLVM_FLAGS="$("$LLVM_CONFIG" --cxxflags --ldflags --libs --system-libs)"
EXTRA=""
if [[ "$(basename "$SIM")" == "sim.c" ]]; then
  EXTRA="$(pkg-config --libs sdl2)"
  $CC -O2 -c -I .. -I ../.. "$SIM" -o sim_impl.o
else
  $CC -O2 -c -I include "$SIM" -o sim_impl.o
fi
# shellcheck disable=SC2086
$CXX -std=c++17 -O2 -I . main.cpp bin.cpp cpu.cpp instr.cpp extIR.cpp fullIR.cpp \
     sim_impl.o $LLVM_FLAGS $EXTRA -o "$OUT"
rm -f sim_impl.o
echo "built: ./$OUT  (LLVM $("$LLVM_CONFIG" --version), sim=$SIM)"
