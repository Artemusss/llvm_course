#include "include/bin.h"
#include "include/cpu.h"
#include "include/extIR.h"
#include "include/fullIR.h"
#include "llvm/Support/raw_ostream.h"
#include <cstdlib>
#include <string>
using namespace llvm;

// ASM-симулятор / ASM2IR-генератор для своей ISA.
//   asmsim <file.myasm> 1           — симуляция (п.5*)
//   asmsim <file.myasm> 2           — IR с вызовами эмулирующих функций + EE (п.3)
//   asmsim <file.myasm> 3           — полный IR + EE (п.4)
//   asmsim <file.myasm> 3 out.ll    — выгрузить полный IR в файл
// Флаг -v (последним аргументом не считается): печать дизассемблера и IR.
int main(int argc, char *argv[]) {
  bool Verbose = false;
  std::vector<std::string> Args;
  for (int i = 1; i < argc; i++) {
    std::string A = argv[i];
    if (A == "-v") Verbose = true;
    else Args.push_back(A);
  }
  if (Args.size() != 2 && Args.size() != 3) {
    outs() << "Usage: " << argv[0] << " <asm-file> <mode 1-3> [out.ll] [-v]\n"
              "  1: simulation (emulating functions only, no IR)\n"
              "  2: IR with emulating-function calls + ExecutionEngine\n"
              "  3: full IR equivalents + ExecutionEngine (or dump to out.ll)\n";
    return 1;
  }

  Instr::prepareDicts();
  Binary Bin;
  std::string ErrorMsg;
  if (Bin.readFile(Args[0], ErrorMsg)) {
    outs() << "[ASM READ ERROR] " << ErrorMsg << '\n';
    return 1;
  }
  outs() << "[ASM] " << Bin.Instrs.size() << " instructions, "
         << Bin.BBName2PC.size() << " labels\n";
  if (Verbose)
    outs() << "[Disassembly]\n" << Bin.writeInstrs();

  CPU Cpu;
  switch (std::atoi(Args[1].c_str())) {
  case 1:
    outs() << "#[Running mode 1: simulation]\n";
    if (Cpu.Execute(Bin, ErrorMsg)) {
      outs() << "[CPU RUN ERROR] " << ErrorMsg << '\n';
      return 1;
    }
    break;
  case 2: {
    ExtIR Ext;
    Ext.buildIR(Bin);
    if (Verbose) Ext.dumpIR();
    if (Ext.verifyIR()) return 1;
    Ext.executeIR(Cpu);
    break;
  }
  case 3: {
    FullIR Full;
    Full.buildIR(Bin);
    if (Verbose) Full.dumpIR();
    if (Full.verifyIR()) return 1;
    if (Args.size() == 3) {
      if (Full.printIR(Args[2], ErrorMsg)) {
        outs() << "[IR DUMP ERROR] " << ErrorMsg << "\n";
        return 1;
      }
      outs() << "[IR] written to " << Args[2] << "\n";
    } else {
      Full.executeIR(Cpu);
    }
    break;
  }
  default:
    outs() << "[ERROR] mode must be 1-3\n";
    return 1;
  }
  return 0;
}
