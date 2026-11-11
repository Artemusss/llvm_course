#include "include/cpu.h"

CPU *CPU::C = nullptr;

// Режим 1 (п.5*): симуляция без генерации IR — цикл выборки и вызов
// эмулирующей функции do_<Name> для каждой инструкции; переходы через NextPC.
bool CPU::Execute(Binary &Bin, std::string &ErrorMsg) {
  PC = 0;
  Run = 1;
  setCPU(this);
  simInit();
  while (Run) {
    if (PC >= Bin.Instrs.size()) {
      ErrorMsg = "PC out of range: " + std::to_string(PC);
      return true;
    }
    Instr &I = Bin.Instrs[PC];
    NextPC = PC + 1;
    switch (I.Op) {
    default:
      ErrorMsg = "Wrong Opcode: " + std::to_string(I.Op);
      return true;
#define ISA_(Opcode_, Name_, SkipArgs_, ReadArgs_, WriteArgs_, Execute_,       \
             IRGenExecute_)                                                    \
  case (Opcode_):                                                              \
    do_##Name_(I.R1, I.R2, I.R3Imm);                                           \
    break;
#include "include/ISA.h"
#undef ISA_
    }
    PC = NextPC;
  }
  simExit();
  return false;
}
