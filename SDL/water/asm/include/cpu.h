#ifndef CPU_H
#define CPU_H
#include "bin.h"
#include "sim.h"
#include "llvm/Support/raw_ostream.h"
#include <cstdint>
#include <string>

// Модель процессора: 32 регистра + словная память (два буфера высот сетки).
// Статические do_<Name> — эмулирующие функции инструкций: их напрямую зовёт
// режим 1 (симуляция) и через call из IR — режим 2 (extIR).
struct CPU {
  static constexpr uint32_t RegSize = 32;
  static constexpr uint32_t GridN = 512 * 256;     // клеток в одном буфере
  static constexpr uint32_t MemWords = 2 * GridN;  // buf1 + buf2

  uint32_t RegFile[RegSize] = {};
  uint32_t *Mem;
  uint32_t PC = 0;
  uint32_t NextPC = 0;
  uint32_t Run = 0;
  bool DumpInstrs = false;

  CPU() : Mem(new uint32_t[MemWords]()) {}
  ~CPU() { delete[] Mem; }
  CPU(const CPU &) = delete;
  CPU &operator=(const CPU &) = delete;

  bool Execute(Binary &Bin, std::string &ErrorMsg); // режим 1

  static CPU *C;
  static void setCPU(CPU *Cpu) { C = Cpu; }

#define ISA_(Opcode_, Name_, SkipArgs_, ReadArgs_, WriteArgs_, Execute_,       \
             IRGenExecute_)                                                    \
  static void do_##Name_(uint32_t R1, uint32_t R2, uint32_t R3Imm) {           \
    (void)R1; (void)R2; (void)R3Imm;                                           \
    if (C->DumpInstrs)                                                         \
      llvm::outs() << #Name_ "\n";                                             \
    Execute_;                                                                  \
  }
#include "ISA.h"
#undef ISA_
};
#endif // CPU_H
