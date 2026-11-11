/* start.c — точка входа для эталона (app_water.c) и выгруженного IR
 * при headless-проверке. Для окна используйте ../../start.c + ../../sim.c. */
#include "../include/sim.h"
void app(void);
int main(void) {
  simInit();
  app();
  simExit();
  return 0;
}
