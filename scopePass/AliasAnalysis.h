#ifndef SAliasAnalysis_H
#define SAliasAnalysis_H
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

//Primary Driver Struct of the pass
using namespace llvm;

class AggrAlias{
    
    private:
    std::map<llvm::Instruction*, std::map<llvm::Value*, std::set<llvm::Value*>>> points_to_map_in;
    std::map<llvm::Instruction*, std::map<llvm::Value*, std::set<llvm::Value*>>> points_to_map_out;

    std::map<llvm::CallInst*, std::map<llvm::Value*, std::set<llvm::Value*>>> points_to_map_inter_in; // Inter In Map
    std::map<llvm::CallInst*, std::map<llvm::Value*, std::set<llvm::Value*>>> points_to_map_inter_out; //Inter Out Map
    
    public:
    //See if the old points to map and new points to map are different
    bool is_changed(std::map<llvm::Value*, std::set<llvm::Value*>> old_map, 
        std::map<llvm::Value*, std::set<llvm::Value*>> new_map);

    //check if the two values are aliases at instruction instr
    bool isAlias(llvm::Value *val1, llvm::Value *val2, llvm::Instruction *instr);

    std::vector<llvm::Instruction*> getSuccessorInstructions(llvm::Instruction *instr);

    std::vector<llvm::Instruction*> getPredecessorInstructions(llvm::Instruction *instr);

    void run_alias_analysis(llvm::Function *func);

    void make_alias_info(llvm::Function *func, std::vector<llvm::Instruction*>context);

    llvm::ReturnInst * getReturnInstruction(llvm::Function *func);

    void run_main(llvm::Module *M);

};
#endif

