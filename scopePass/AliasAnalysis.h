#ifndef AliasAnalysis_H
#define AliasAnalysis_H
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

    std::vector <llvm::Instruction*> call_stack = {}; //call stack to keep track of the call instructions4
    
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

    void print_analysis_results(llvm::Instruction *instr);

    void PrintAll();

    llvm::Value *get_value(llvm::Instruction *instr);//get value corresponding to the instruction
    
    llvm::Value* getLoadValue(llvm::LoadInst *LI);

};

// namespace {
    
// //write the Analysis
// struct  AggrAliasAnalysis : public ModulePass {
//     static char ID;

//     AggrAliasAnalysis() : ModulePass(ID) {}

//     bool runOnModule(Module &M) override
//     {
//         AggrAlias *AA = new AggrAlias();
//         AA->run_main(&M);
//         AA->PrintAll();
//     }
// };
// };

// char AggrAliasAnalysis::ID = 0;
// static RegisterPass<AggrAliasAnalysis> X("aggr_alias", "Aggressive Alias Analysis Pass", false, false);
// static RegisterStandardPasses Y(
//     PassManagerBuilder::EP_ModuleOptimizerEarly,
//     [](const PassManagerBuilder &Builder,
//        legacy::PassManagerBase &PM) { 
//          if (Builder.OptLevel >= 0)
//             PM.add(new AggrAliasAnalysis()); 
//         });
#endif
