#ifndef SIM_H
#define SIM_H

/* Графический интерфейс курса (как SDL/sim.h). Реализация — SDL/sim.c (окно)
 * или headless app/sim_stub.c (проверка без дисплея). */
#define SIM_X_SIZE 1536
#define SIM_Y_SIZE 768

#ifdef __cplusplus
extern "C" {
#endif
void simInit(void);
void simExit(void);
void simFlush(void);
void simPutPixel(int x, int y, int argb);
int simRand(void);
#ifdef __cplusplus
}
#endif

#endif // SIM_H
