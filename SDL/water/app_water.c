#include "sim.h"

// ---- Water ripple: explicit finite-difference wave equation on a grid ----
// Single logic entry point: void app(). No structs, no switch-case,
// no dynamic allocation (only fixed-size int arrays on the stack),
// one uniform data type (int), and the only header is "sim.h".

#define SCALE 3                 // screen pixels per grid cell (1536/3=512, 768/3=256)
#define W (SIM_X_SIZE / SCALE)  // grid width  = 512
#define H (SIM_Y_SIZE / SCALE)  // grid height = 256
#define N (W * H)               // cells per buffer

#define DAMP 6                  // damping: larger => waves live longer
#define DROP_R 3                // drop radius in cells
#define DROP_H 640              // drop impulse height
#define DROP_PERIOD 16          // frames between random drops

// Fill one SCALE x SCALE screen block for grid cell (gx, gy).
void drawBlock(int gx, int gy, int argb) {
  int x0 = gx * SCALE;
  int y0 = gy * SCALE;
  for (int j = 0; j < SCALE; j++)
    for (int i = 0; i < SCALE; i++)
      simPutPixel(x0 + i, y0 + j, argb);
}

// Map wave height h and horizontal slope to a water color (fake lighting).
int shade(int h, int slope) {
  int lum = 120 + (h >> 3) + (slope >> 1);
  if (lum < 0) lum = 0;
  if (lum > 255) lum = 255;
  int r = lum >> 3;         // deep-blue tint: little red
  int g = (lum * 5) >> 3;   // ~0.62 * lum
  int b = lum;              // full blue
  return 0xFF000000 | (r << 16) | (g << 8) | b;
}

// Render the current height buffer to the screen.
void render(int *cur) {
  for (int y = 0; y < H; y++)
    for (int x = 0; x < W; x++) {
      int c = y * W + x;
      int cl = (x > 0)     ? c - 1 : c;
      int cr = (x < W - 1) ? c + 1 : c;
      int slope = cur[cl] - cur[cr];
      drawBlock(x, y, shade(cur[c], slope));
    }
}

// One physics step: dst = new heights from src neighbours minus dst (old),
// then apply damping. Borders are left untouched (absorbing edge).
void step(int *src, int *dst) {
  for (int y = 1; y < H - 1; y++)
    for (int x = 1; x < W - 1; x++) {
      int c = y * W + x;
      int v = ((src[c - 1] + src[c + 1] + src[c - W] + src[c + W]) >> 1) - dst[c];
      v -= v >> DAMP;
      dst[c] = v;
    }
}

// Add a drop (impulse) into buffer buf at grid (cx, cy).
void drop(int *buf, int cx, int cy, int power) {
  for (int j = -DROP_R; j <= DROP_R; j++)
    for (int i = -DROP_R; i <= DROP_R; i++) {
      int x = cx + i;
      int y = cy + j;
      if (x > 0 && x < W - 1 && y > 0 && y < H - 1)
        buf[y * W + x] += power;
    }
}

void app(void) {
  int buf1[N] = {};
  int buf2[N] = {};
  int *a = buf1;   // current heights
  int *b = buf2;   // previous heights
  int t = 0;

  drop(a, W / 2, H / 2, DROP_H);   // initial splash

  while (1) {
    step(a, b);                    // b := new heights from a
    int *tmp = a; a = b; b = tmp;  // a := new current
    render(a);
    simFlush();

    if (t % DROP_PERIOD == 0) {
      int rx = (simRand() & 0x3FFFFFFF) % (W - 2 * DROP_R - 2) + DROP_R + 1;
      int ry = (simRand() & 0x3FFFFFFF) % (H - 2 * DROP_R - 2) + DROP_R + 1;
      drop(a, rx, ry, DROP_H);
    }
    t++;
  }
}
