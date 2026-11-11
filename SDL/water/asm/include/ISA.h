// ============================================================================
//  ISA.h — набор инструкций для app_water (X-macro). Единый источник для:
//    * словарей имя<->опкод               (instr.cpp)
//    * парсера/печати ассемблера           (bin.cpp:   Skip/Read/WriteArgs)
//    * симуляции                           (cpu.cpp:   Execute)       режим 1 (п.5*)
//    * IR с эмулирующими функциями         (extIR.cpp)                режим 2 (п.3)
//    * полного IR-эквивалента              (fullIR.cpp: IRGenExecute) режим 3 (п.4)
//
//  ISA_(Opcode, Name, SkipArgs, ReadArgs, WriteArgs, Execute, IRGenExecute)
//
//  Модель: 32 регистра r0..r31 (i32), словная память Mem[0..MEM_WORDS),
//  буферы высот сетки: buf1 = Mem[0..N), buf2 = Mem[N..2N), N = 512*256.
//  Опкоды ненулевые: 0 = «не инструкция» (метка).
//
//  Набор выведен из статистики задания 2 по app_water (../stats/) и его -O2 IR;
//  обоснование каждой инструкции — в ISA.md.
// ============================================================================

// ---- SkipArgs ---------------------------------------------------------------
#define SKIP_3ARGS { InputFile >> Arg >> Arg >> Arg; }
#define SKIP_2ARGS { InputFile >> Arg >> Arg; }
#define SKIP_1ARGS { InputFile >> Arg; }

// ---- ReadArgs ---------------------------------------------------------------
#define READ_REG(Reg) { InputFile >> Arg; I.Reg = std::stoi(Arg.substr(1)); }
#define READ_IMM      { InputFile >> Arg; I.R3Imm = (uint32_t)std::stoll(Arg); }
#define READ_LABEL                                                             \
  {                                                                            \
    InputFile >> Arg;                                                          \
    if (BBName2PC.find(Arg) == BBName2PC.end()) {                              \
      ErrorMsg = std::string("Can't find label: " + Arg);                      \
      return true;                                                             \
    }                                                                          \
    I.R3Imm = BBName2PC[Arg];                                                  \
  }
#define READ_1REG       { READ_REG(R1) }
#define READ_2REGS      { READ_REG(R1) READ_REG(R2) }
#define READ_3REGS      { READ_REG(R1) READ_REG(R2) READ_REG(R3Imm) }
#define READ_2REGS_IMM  { READ_REG(R1) READ_REG(R2) READ_IMM }
#define READ_REG_IMM    { READ_REG(R1) READ_IMM }
#define READ_REG_LABEL  { READ_REG(R1) READ_LABEL }

// ---- WriteArgs --------------------------------------------------------------
#define WRITE_REG(Reg)  { Stream << " r" << I.Reg; }
#define WRITE_IMM       { Stream << " " << (int32_t)I.R3Imm; }
#define WRITE_LABEL     { Stream << " " << PC2BBName[I.R3Imm]; }
#define WRITE_1REG      { WRITE_REG(R1) }
#define WRITE_2REGS     { WRITE_REG(R1) WRITE_REG(R2) }
#define WRITE_3REGS     { WRITE_REG(R1) WRITE_REG(R2) WRITE_REG(R3Imm) }
#define WRITE_2REGS_IMM { WRITE_REG(R1) WRITE_REG(R2) WRITE_IMM }
#define WRITE_REG_IMM   { WRITE_REG(R1) WRITE_IMM }
#define WRITE_REG_LABEL { WRITE_REG(R1) WRITE_LABEL }

// ---- Хелперы IR (fullIR): регистры = ячейки alloca regFile, память = @mem ---
#define GEP2_32(Arg) builder.CreateConstGEP2_32(regFileType, regFile, 0, Arg)
#define LOAD_REG(Arg) builder.CreateLoad(int32Type, GEP2_32(Arg))
#define STORE_REG(Val, Arg) builder.CreateStore(Val, GEP2_32(Arg))
#define GEN_IMM(Arg) builder.getInt32(Arg)
#define MEM_PTR(Base, Off)                                                     \
  builder.CreateInBoundsGEP(int32Type, memArr,                                 \
                            builder.CreateAdd(LOAD_REG(Base), GEN_IMM(Off)))

#define R(n) C->RegFile[n]
#define SR(n) ((int32_t)C->RegFile[n])

// ============================================================================
//  Поток управления (режим 2 строит их нативным IR, без эмулирующих функций)
// ============================================================================

//  HALT — конец программы: ret void
ISA_(0xF0, HALT, {}, {}, {},
     { C->Run = 0; },
     { builder.CreateRetVoid(); })

//  JMP label — безусловный переход (while(1) главного цикла)
ISA_(0x80, JMP, SKIP_1ARGS, READ_LABEL, WRITE_LABEL,
     { C->NextPC = R3Imm; },
     {
       PC++;
       builder.CreateBr(BBMap[I.R3Imm]);
       auto Next = BBMap.find(PC);
       if (Next != BBMap.end()) builder.SetInsertPoint(Next->second);
       continue;
     })

//  BNZ rc, label — если rc != 0 -> label  (br <- icmp: повтор цикла)
ISA_(0x81, BNZ, SKIP_2ARGS, READ_REG_LABEL, WRITE_REG_LABEL,
     { if (R(R1)) C->NextPC = R3Imm; },
     {
       PC++;
       builder.CreateCondBr(builder.CreateICmpNE(LOAD_REG(I.R1), GEN_IMM(0)),
                            BBMap[I.R3Imm], BBMap[PC]);
       builder.SetInsertPoint(BBMap[PC]);
       continue;
     })

//  BZ rc, label — если rc == 0 -> label  (if в drop)
ISA_(0x82, BZ, SKIP_2ARGS, READ_REG_LABEL, WRITE_REG_LABEL,
     { if (!R(R1)) C->NextPC = R3Imm; },
     {
       PC++;
       builder.CreateCondBr(builder.CreateICmpEQ(LOAD_REG(I.R1), GEN_IMM(0)),
                            BBMap[I.R3Imm], BBMap[PC]);
       builder.SetInsertPoint(BBMap[PC]);
       continue;
     })

// ============================================================================
//  Графика / внешние функции
// ============================================================================

//  FLUSH — simFlush()
ISA_(0xF1, FLUSH, {}, {}, {},
     { simFlush(); },
     { builder.CreateCall(simFlushFunc); })

//  PUTBLK rx, ry, rc — drawBlock: заливка блока 3x3 пикселя (SCALE = 3) для
//  клетки (rx, ry) цветом rc. Слита из самого горячего места трассы:
//  call<-add 18.4%, call<-mul 8.5%, call<-trunc 2.8% — аргументы simPutPixel.
ISA_(0x60, PUTBLK, SKIP_3ARGS, READ_3REGS, WRITE_3REGS,
     {
       int32_t x0 = SR(R1) * 3;
       int32_t y0 = SR(R2) * 3;
       int32_t c = SR(R3Imm);
       for (int j = 0; j < 3; j++)
         for (int i = 0; i < 3; i++)
           simPutPixel(x0 + i, y0 + j, c);
     },
     {
       Value *x0 = builder.CreateMul(LOAD_REG(I.R1), GEN_IMM(3));
       Value *y0 = builder.CreateMul(LOAD_REG(I.R2), GEN_IMM(3));
       Value *c = LOAD_REG(I.R3Imm);
       for (int j = 0; j < 3; j++)
         for (int i = 0; i < 3; i++)
           builder.CreateCall(simPutPixelFunc,
                              {builder.CreateAdd(x0, GEN_IMM(i)),
                               builder.CreateAdd(y0, GEN_IMM(j)), c});
     })

//  RAND rd — rd = simRand()
ISA_(0x61, RAND, SKIP_1ARGS, READ_1REG, WRITE_1REG,
     { R(R1) = simRand(); },
     { STORE_REG(builder.CreateCall(simRandFunc), I.R1); })

// ============================================================================
//  Пересылки
// ============================================================================

//  MOV rd, rs — копия (обмен указателей буферов a<->b: phi в IR)
ISA_(0x10, MOV, SKIP_2ARGS, READ_2REGS, WRITE_2REGS,
     { R(R1) = R(R2); },
     { STORE_REG(LOAD_REG(I.R2), I.R1); })

//  LDI rd, imm — загрузка константы
ISA_(0x11, LDI, SKIP_2ARGS, READ_REG_IMM, WRITE_REG_IMM,
     { R(R1) = R3Imm; },
     { STORE_REG(GEN_IMM(I.R3Imm), I.R1); })

// ============================================================================
//  Арифметика и логика: регистр-регистр
// ============================================================================

ISA_(0x20, ADD, SKIP_3ARGS, READ_3REGS, WRITE_3REGS,
     { R(R1) = R(R2) + R(R3Imm); },
     { STORE_REG(builder.CreateAdd(LOAD_REG(I.R2), LOAD_REG(I.R3Imm)), I.R1); })

ISA_(0x21, SUB, SKIP_3ARGS, READ_3REGS, WRITE_3REGS,
     { R(R1) = R(R2) - R(R3Imm); },
     { STORE_REG(builder.CreateSub(LOAD_REG(I.R2), LOAD_REG(I.R3Imm)), I.R1); })

ISA_(0x22, AND, SKIP_3ARGS, READ_3REGS, WRITE_3REGS,
     { R(R1) = R(R2) & R(R3Imm); },
     { STORE_REG(builder.CreateAnd(LOAD_REG(I.R2), LOAD_REG(I.R3Imm)), I.R1); })

ISA_(0x23, OR, SKIP_3ARGS, READ_3REGS, WRITE_3REGS,
     { R(R1) = R(R2) | R(R3Imm); },
     { STORE_REG(builder.CreateOr(LOAD_REG(I.R2), LOAD_REG(I.R3Imm)), I.R1); })

// ============================================================================
//  Арифметика и логика: регистр-константа
// ============================================================================

ISA_(0x30, ADDI, SKIP_3ARGS, READ_2REGS_IMM, WRITE_2REGS_IMM,
     { R(R1) = R(R2) + R3Imm; },
     { STORE_REG(builder.CreateAdd(LOAD_REG(I.R2), GEN_IMM(I.R3Imm)), I.R1); })

ISA_(0x31, MULI, SKIP_3ARGS, READ_2REGS_IMM, WRITE_2REGS_IMM,
     { R(R1) = R(R2) * R3Imm; },
     { STORE_REG(builder.CreateMul(LOAD_REG(I.R2), GEN_IMM(I.R3Imm)), I.R1); })

ISA_(0x32, SHLI, SKIP_3ARGS, READ_2REGS_IMM, WRITE_2REGS_IMM,
     { R(R1) = R(R2) << R3Imm; },
     { STORE_REG(builder.CreateShl(LOAD_REG(I.R2), GEN_IMM(I.R3Imm)), I.R1); })

//  SHRI — арифметический сдвиг вправо (ashr): h>>3, slope>>1, v>>DAMP
ISA_(0x33, SHRI, SKIP_3ARGS, READ_2REGS_IMM, WRITE_2REGS_IMM,
     { R(R1) = (uint32_t)(SR(R2) >> R3Imm); },
     { STORE_REG(builder.CreateAShr(LOAD_REG(I.R2), GEN_IMM(I.R3Imm)), I.R1); })

ISA_(0x34, ANDI, SKIP_3ARGS, READ_2REGS_IMM, WRITE_2REGS_IMM,
     { R(R1) = R(R2) & R3Imm; },
     { STORE_REG(builder.CreateAnd(LOAD_REG(I.R2), GEN_IMM(I.R3Imm)), I.R1); })

ISA_(0x35, ORI, SKIP_3ARGS, READ_2REGS_IMM, WRITE_2REGS_IMM,
     { R(R1) = R(R2) | R3Imm; },
     { STORE_REG(builder.CreateOr(LOAD_REG(I.R2), GEN_IMM(I.R3Imm)), I.R1); })

//  REMUI — беззнаковый остаток (urem: случайная координата капли)
ISA_(0x36, REMUI, SKIP_3ARGS, READ_2REGS_IMM, WRITE_2REGS_IMM,
     { R(R1) = R(R2) % R3Imm; },
     { STORE_REG(builder.CreateURem(LOAD_REG(I.R2), GEN_IMM(I.R3Imm)), I.R1); })

//  CMPLTUI rd, ra, imm — rd = (unsigned)ra < imm  (icmp ult: проверки границ)
ISA_(0x37, CMPLTUI, SKIP_3ARGS, READ_2REGS_IMM, WRITE_2REGS_IMM,
     { R(R1) = R(R2) < R3Imm; },
     {
       STORE_REG(builder.CreateZExt(
                     builder.CreateICmpULT(LOAD_REG(I.R2), GEN_IMM(I.R3Imm)),
                     int32Type),
                 I.R1);
     })

//  CLAMPI rd, ra, imm — rd = min(max(ra, 0), imm)  (smax + umin в shade)
ISA_(0x38, CLAMPI, SKIP_3ARGS, READ_2REGS_IMM, WRITE_2REGS_IMM,
     {
       int32_t v = SR(R2);
       if (v < 0) v = 0;
       if (v > (int32_t)R3Imm) v = (int32_t)R3Imm;
       R(R1) = (uint32_t)v;
     },
     {
       Value *v = LOAD_REG(I.R2);
       v = builder.CreateSelect(builder.CreateICmpSLT(v, GEN_IMM(0)), GEN_IMM(0), v);
       v = builder.CreateSelect(builder.CreateICmpSGT(v, GEN_IMM(I.R3Imm)),
                                GEN_IMM(I.R3Imm), v);
       STORE_REG(v, I.R1);
     })

//  INC_NE rd, rc, imm — rc = rc + 1; rd = (rc != imm)
//  слитые add<-add, icmp<-add (+ br<-icmp через BNZ) — счётчик цикла
ISA_(0x39, INC_NE, SKIP_3ARGS, READ_2REGS_IMM, WRITE_2REGS_IMM,
     { R(R1) = (++R(R2)) != R3Imm; },
     {
       Value *inc = builder.CreateAdd(LOAD_REG(I.R2), GEN_IMM(1));
       STORE_REG(inc, I.R2);
       STORE_REG(builder.CreateZExt(builder.CreateICmpNE(inc, GEN_IMM(I.R3Imm)),
                                    int32Type),
                 I.R1);
     })

// ============================================================================
//  Память (load <- getelementptr 6.1%: GEP слит в базу + смещение)
// ============================================================================

//  LD rd, rb, imm — rd = Mem[rb + imm]
ISA_(0x40, LD, SKIP_3ARGS, READ_2REGS_IMM, WRITE_2REGS_IMM,
     { R(R1) = C->Mem[R(R2) + R3Imm]; },
     { STORE_REG(builder.CreateLoad(int32Type, MEM_PTR(I.R2, I.R3Imm)), I.R1); })

//  ST rs, rb, imm — Mem[rb + imm] = rs
ISA_(0x41, ST, SKIP_3ARGS, READ_2REGS_IMM, WRITE_2REGS_IMM,
     { C->Mem[R(R2) + R3Imm] = R(R1); },
     { builder.CreateStore(LOAD_REG(I.R1), MEM_PTR(I.R2, I.R3Imm)); })

#undef R
#undef SR
