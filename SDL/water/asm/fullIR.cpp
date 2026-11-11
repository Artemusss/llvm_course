#include "include/fullIR.h"
#include "llvm/ExecutionEngine/ExecutionEngine.h"
#include "llvm/ExecutionEngine/GenericValue.h"
#include "llvm/ExecutionEngine/MCJIT.h"
#include "llvm/IR/IRBuilder.h"
#include "llvm/IR/Verifier.h"
#include "llvm/Support/TargetSelect.h"
#include "llvm/Support/raw_ostream.h"
#include <memory>
#include <system_error>
#include <unordered_map>

using namespace llvm;

// Режим 3 (п.4): полноценный IR-эквивалент КАЖДОЙ инструкции (IRGenExecute).
// Никаких эмулирующих функций: арифметика — add/sub/shl/ashr/..., память —
// load/store в глобальный @mem, графика — call @simPutPixel/@simFlush/@simRand.
void FullIR::buildIR(Binary &Bin) {
  module = new Module("app_water_full", context);
  IRBuilder<> builder(context);
  voidType = Type::getVoidTy(context);
  int32Type = Type::getInt32Ty(context);

  FunctionType *funcType = FunctionType::get(voidType, false);
  mainFunc = Function::Create(funcType, Function::ExternalLinkage, "app", module);

  FunctionCallee simPutPixelFunc = module->getOrInsertFunction(
      "simPutPixel",
      FunctionType::get(voidType, {int32Type, int32Type, int32Type}, false));
  FunctionCallee simFlushFunc =
      module->getOrInsertFunction("simFlush", FunctionType::get(voidType, false));
  FunctionCallee simRandFunc =
      module->getOrInsertFunction("simRand", FunctionType::get(int32Type, false));

  // Память программы: два буфера высот, нулевая инициализация (как buf = {}).
  ArrayType *memType = ArrayType::get(int32Type, CPU::MemWords);
  GlobalVariable *memArr = new GlobalVariable(
      *module, memType, false, GlobalValue::InternalLinkage,
      ConstantAggregateZero::get(memType), "mem");

  std::unordered_map<uint32_t, BasicBlock *> BBMap;
  for (auto &BB : Bin.PC2BBName)
    BBMap[BB.first] = BasicBlock::Create(context, BB.second, mainFunc);

  uint32_t PC = 0;
  builder.SetInsertPoint(BBMap[0]);
  ArrayType *regFileType = ArrayType::get(int32Type, CPU::RegSize);
  Value *regFile = builder.CreateAlloca(regFileType, nullptr, "regFile");

  for (Instr &I : Bin.Instrs) {
    switch (I.Op) {
    default:
      break;
#define ISA_(Opcode_, Name_, SkipArgs_, ReadArgs_, WriteArgs_, Execute_,       \
             IRGenExecute_)                                                    \
  case (Opcode_):                                                              \
    IRGenExecute_; /* JMP/BNZ/BZ сами делают PC++/SetInsertPoint/continue */    \
    break;
#include "include/ISA.h"
#undef ISA_
    }
    PC++;
    auto BB = BBMap.find(PC);
    if (BB != BBMap.end()) {
      builder.CreateBr(BB->second); // падение в следующий блок
      builder.SetInsertPoint(BB->second);
    }
  }
  (void)simFlushFunc; (void)simRandFunc; (void)simPutPixelFunc;
}

void FullIR::executeIR(CPU &Cpu) {
  (void)Cpu;
  InitializeNativeTarget();
  InitializeNativeTargetAsmPrinter();

  ExecutionEngine *ee = EngineBuilder(std::unique_ptr<Module>(module)).create();
  ee->InstallLazyFunctionCreator([](const std::string &fn) -> void * {
    if (fn == "simFlush") return reinterpret_cast<void *>(simFlush);
    if (fn == "simPutPixel") return reinterpret_cast<void *>(simPutPixel);
    if (fn == "simRand") return reinterpret_cast<void *>(simRand);
    errs() << "[EE] Can't find function " << fn << '\n';
    return nullptr;
  });
  ee->finalizeObject();

  simInit();
  outs() << "\n#[Running mode 3: full IR]\n";
  ee->runFunction(mainFunc, ArrayRef<GenericValue>());
  outs() << "#[Done mode 3]\n";
  simExit();
}

// Выгрузка IR: линкуется с графикой курса —
//   clang app_water.gen.ll ../../start.c ../../sim.c -lSDL2 -o app_water_asm
bool FullIR::printIR(const std::string &FileName, std::string &ErrorMsg) {
  std::error_code EC;
  raw_fd_ostream Out(FileName, EC);
  if (EC) {
    ErrorMsg = "Can't print LLVM IR to " + FileName;
    return true;
  }
  module->print(Out, nullptr);
  return false;
}
