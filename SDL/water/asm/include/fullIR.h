#ifndef FULLIR_H
#define FULLIR_H
#include "bin.h"
#include "cpu.h"
#include "extIR.h"

// Режим 3 (задание п.4): полный IR-эквивалент каждой инструкции (IRGenExecute).
// Регистры — alloca [32 x i32], память — глобальный @mem [2N x i32],
// графика — прямые call @simPutPixel/@simFlush/@simRand.
struct FullIR : ExtIR {
  void buildIR(Binary &Bin);
  void executeIR(CPU &Cpu);
  bool printIR(const std::string &FileName, std::string &ErrorMsg); // -> *.ll
};
#endif // FULLIR_H
