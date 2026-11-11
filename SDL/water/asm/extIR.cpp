#include "include/extIR.h"
#include "llvm/ExecutionEngine/ExecutionEngine.h"
#include "llvm/ExecutionEngine/GenericValue.h"
#include "llvm/ExecutionEngine/MCJIT.h"
#include "llvm/IR/IRBuilder.h"
#include "llvm/IR/Verifier.h"
#include "llvm/Support/TargetSelect.h"
#include "llvm/Support/raw_ostream.h"
#include <memory>
#include <unordered_map>

using namespace llvm;

// Режим 2 (п.3): каждая инструкция, КРОМЕ потока управления, становится
// call do_<Name>(R1, R2, R3Imm) — эмулирующей функцией (она работает с
// регистрами и памятью CPU). JMP/BNZ/BZ/HALT строятся нативным IR
// (br / condbr / ret); условие читается из глобального @regFile,
// который при исполнении отображается на CPU::RegFile.
void ExtIR::buildIR(Binary &Bin) {
  module = new Module("app_water_ext", context);
  IRBuilder<> builder(context);
  voidType = Type::getVoidTy(context);
  int32Type = Type::getInt32Ty(context);

  ArrayType *regFileType = ArrayType::get(int32Type, CPU::RegSize);
  module->getOrInsertGlobal("regFile", regFileType);
  regFile = module->getNamedGlobal("regFile");

  FunctionType *funcType = FunctionType::get(voidType, false);
  mainFunc = Function::Create(funcType, Function::ExternalLinkage, "app", module);

  FunctionType *doType =
      FunctionType::get(voidType, {int32Type, int32Type, int32Type}, false);
  // Прототип do_<Name> объявляется при первом вызове, поэтому в модуле
  // нет объявлений для инструкций потока управления (они не эмулируются).

  // Блоки в порядке PC: блок PC 0 — первый блок функции (entry).
  std::unordered_map<uint32_t, BasicBlock *> BBMap;
  for (auto &BB : Bin.PC2BBName)
    BBMap[BB.first] = BasicBlock::Create(context, BB.second, mainFunc);

  auto loadReg = [&](uint32_t R) {
    return builder.CreateLoad(
        int32Type, builder.CreateConstGEP2_32(regFileType, regFile, 0, R));
  };

  uint32_t PC = 0;
  builder.SetInsertPoint(BBMap[0]);
  for (Instr &I : Bin.Instrs) {
    // 1) Данные/графика/память: вызов эмулирующей функции.
    if (!Instr::isControlFlow(I.Op)) {
      Value *args[] = {builder.getInt32(I.R1), builder.getInt32(I.R2),
                       builder.getInt32(I.R3Imm)};
      switch (I.Op) {
      default:
        break;
#define ISA_(Opcode_, Name_, SkipArgs_, ReadArgs_, WriteArgs_, Execute_,       \
             IRGenExecute_)                                                    \
  case (Opcode_):                                                              \
    builder.CreateCall(module->getOrInsertFunction("do_" #Name_, doType),     \
                       args);                                                  \
    break;
#include "include/ISA.h"
#undef ISA_
      }
    }

    // 2) Поток управления — нативный IR.
    PC++;
    auto BB = BBMap.find(PC);
    switch (I.Op) {
    default:
      if (BB != BBMap.end())
        builder.CreateBr(BB->second); // падение в следующий блок
      break;
    case Instr::BNZ:
      builder.CreateCondBr(builder.CreateICmpNE(loadReg(I.R1), builder.getInt32(0)),
                           BBMap[I.R3Imm], BB->second);
      break;
    case Instr::BZ:
      builder.CreateCondBr(builder.CreateICmpEQ(loadReg(I.R1), builder.getInt32(0)),
                           BBMap[I.R3Imm], BB->second);
      break;
    case Instr::JMP:
      builder.CreateBr(BBMap[I.R3Imm]);
      break;
    case Instr::HALT:
      builder.CreateRetVoid();
      break;
    }
    if (BB != BBMap.end())
      builder.SetInsertPoint(BB->second);
  }
}

void ExtIR::dumpIR() {
  outs() << "\n[LLVM IR]:\n";
  module->print(outs(), nullptr);
  outs() << '\n';
}

bool ExtIR::verifyIR() {
  bool bad = verifyModule(*module, &outs());
  outs() << "[VERIFICATION] " << (bad ? "FAIL\n" : "OK\n");
  return bad;
}

void ExtIR::executeIR(CPU &Cpu) {
  InitializeNativeTarget();
  InitializeNativeTargetAsmPrinter();

  ExecutionEngine *ee = EngineBuilder(std::unique_ptr<Module>(module)).create();
  ee->InstallLazyFunctionCreator([](const std::string &fn) -> void * {
#define ISA_(Opcode_, Name_, SkipArgs_, ReadArgs_, WriteArgs_, Execute_,       \
             IRGenExecute_)                                                    \
  if (fn == "do_" #Name_)                                                      \
    return reinterpret_cast<void *>(CPU::do_##Name_);
#include "include/ISA.h"
#undef ISA_
    errs() << "[EE] Can't find function " << fn << '\n';
    return nullptr;
  });
  ee->addGlobalMapping(regFile, (void *)Cpu.RegFile);
  ee->finalizeObject();

  CPU::setCPU(&Cpu);
  simInit();
  outs() << "\n#[Running mode 2: IR + emulating functions]\n";
  ee->runFunction(mainFunc, ArrayRef<GenericValue>());
  outs() << "#[Done mode 2]\n";
  simExit();
}
