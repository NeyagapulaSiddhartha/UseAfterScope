

#include "llvm/Pass.h"
#include "llvm/IR/Function.h"
#include "llvm/Analysis/LoopInfo.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/IR/Constants.h"
#include "llvm/IR/GlobalValue.h"
#include "llvm/Transforms/Utils.h"
#include "llvm/IR/Dominators.h"
#include "llvm/IR/DebugLoc.h"
#include "llvm/Analysis/PostDominators.h"
#include "llvm/IR/InstrTypes.h"
#include "llvm/IR/IRBuilder.h"
#include "llvm/Transforms/Utils/Mem2Reg.h"
#include "llvm/IR/Instructions.h"
#include "llvm/ADT/StringRef.h"
#include "llvm/IR/LegacyPassManager.h"
// #include "llvm/Transforms/IPO/PassManagerBuilder.h"
#include "llvm/IR/CFG.h"
#include "llvm/Analysis/CFG.h"
#include "llvm/Analysis/AliasAnalysis.h"
#include "llvm/Analysis/TargetLibraryInfo.h"
#include "llvm/Analysis/CallGraph.h"
#include "llvm/IR/LLVMContext.h"
#include "llvm/IR/Module.h"
#include "llvm/IR/Type.h"
#include<algorithm>
#include <fstream>
#include<map>
#include<iostream>
#include<vector>
#include<set>
#include<iterator>
#include <tuple>
#include <unordered_map> 
#include <tuple>
#include "llvm/Transforms/Utils/Cloning.h"
#include <sstream>
#include "llvm/Transforms/Scalar/SROA.h"
#include "llvm/Transforms/Scalar.h"


class AggrAlias{
    public:

    llvm::Value* get_true_value(llvm::Value *val);
    llvm::Value* get_true_value(llvm::Value *val, std::vector<llvm::Instruction*>caller_instr_stack);
    llvm::Function *getFunction(llvm::Value *val);
    bool isAlias(llvm::Value *val1, llvm::Value* val2);
    bool isAlias_inter(llvm::Value *val1, std::vector<llvm::Instruction*> context1, llvm::Value* val2, std::vector<llvm::Instruction*> context2);



};