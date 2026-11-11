#!/usr/bin/env bash
# Запуск app_water.myasm:
#   ./run.sh 1              режим 1 — симуляция (п.5*)
#   ./run.sh 2              режим 2 — IR + эмулирующие функции + EE (п.3)
#   ./run.sh 3              режим 3 — полный IR + EE (п.4)
#   ./run.sh 3 out.ll       выгрузить полный IR
#   ./run.sh check          сверка хэшей всех режимов с исходным app_water.c
set -euo pipefail
cd "$(dirname "$0")"
if [[ "${1:-}" == "check" ]]; then
  SIM=app/sim_stub.c OUT=asmsim_check ./build.sh >/dev/null
  export SIM_FRAMES="${SIM_FRAMES:-20}"
  clang -O2 -I include ../app_water.c app/start.c \
        app/sim_stub.c -o /tmp/app_water_ref 2>/dev/null
  echo -n "app_water.c (эталон): "; /tmp/app_water_ref 2>&1 | grep -oE 'hash=[0-9a-f]+'
  for m in 1 2 3; do
    echo -n "app_water.myasm, режим $m: "
    ./asmsim_check app_water.myasm $m 2>&1 | grep -oE 'hash=[0-9a-f]+'
  done
  ./asmsim_check app_water.myasm 3 /tmp/app_water.gen.ll >/dev/null
  clang -O2 /tmp/app_water.gen.ll app/start.c app/sim_stub.c -o /tmp/app_water_gen 2>/dev/null
  echo -n "выгруженный IR (clang): "; /tmp/app_water_gen 2>&1 | grep -oE 'hash=[0-9a-f]+'
  exit 0
fi
[[ -x ./asmsim ]] || ./build.sh
./asmsim app_water.myasm "$@"
