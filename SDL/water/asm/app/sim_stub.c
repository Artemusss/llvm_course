/* sim_stub.c — headless-реализация графики (без окна/SDL2) для проверки.
 *
 * Считает FNV-1a хэш потока пикселей (x, y, argb) и печатает его при выходе —
 * так сравниваются режимы 1/2/3 и исходный app_water.c (должны совпасть).
 * simRand = rand() без srand — детерминированная последовательность.
 *
 *   SIM_FRAMES — сколько кадров (simFlush) выполнить, затем exit(0). По умолч. 20.
 *                (капли падают на кадрах t = 0, 16, ... — 20 кадров покрывают их)
 */
#include "../include/sim.h"
#include <stdio.h>
#include <stdlib.h>

static unsigned long long g_pixels = 0;
static unsigned long long g_hash = 1469598103934665603ULL;
static int g_frames = 0, g_frame_limit = 20;

static void report(void) {
  fprintf(stderr, "[sim_stub] frames=%d pixels=%llu hash=%016llx\n", g_frames,
          g_pixels, g_hash);
}

void simInit(void) {
  const char *f = getenv("SIM_FRAMES");
  if (f && *f) g_frame_limit = atoi(f);
  atexit(report);
}

void simExit(void) {}

void simFlush(void) {
  if (++g_frames >= g_frame_limit)
    exit(0);
}

void simPutPixel(int x, int y, int argb) {
  unsigned long long v = ((unsigned long long)(unsigned)x << 42) ^
                         ((unsigned long long)(unsigned)y << 21) ^
                         (unsigned)argb;
  g_hash = (g_hash ^ v) * 1099511628211ULL;
  ++g_pixels;
}

int simRand(void) { return rand(); }
