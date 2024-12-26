/**
 * This file is distributed under the University of Illinois Open Source
 * License. See LICENSE for details.

 * \file scopePass.cpp
 * Author: Markus Kusano
 * Date: 2013-01-11
 *
 * Remove volatile keyword from some LLVM IR instructions
 */
#include "llvm/ADT/IntrusiveRefCntPtr.h"
#include "llvm/Analysis/AliasAnalysis.h"
#include "llvm/Analysis/AliasSetTracker.h"
#include "llvm/Analysis/MemorySSA.h"
#include "llvm/Analysis/MemorySSAUpdater.h"
#include "llvm/IR/BasicBlock.h"
#include "llvm/IR/DebugInfo.h"
#include "llvm/IR/Instruction.h"
#include "llvm/IR/Instructions.h"
#include "llvm/IR/IntrinsicInst.h"
#include "llvm/IR/LegacyPassManager.h"
#include "llvm/IR/Value.h"
#include "llvm/Pass.h"
#include "llvm/Passes/PassBuilder.h"
#include "llvm/Passes/PassPlugin.h"
#include "llvm/Support/Casting.h"
#include "llvm/Support/CommandLine.h"
#include "llvm/Support/Debug.h"
#include "llvm/Support/raw_ostream.h"
#include "AliasAnalysis.h"
using namespace llvm;

namespace {
struct scopePass : public PassInfoMixin<scopePass> {
  static char ID;

  class scope {
  public:
    scope(llvm::DILocalScope *CID) { ID = CID; }
    llvm::DILocalScope *ID;
    scope *parent = nullptr;
  };
  std::list<scope *> list;
  void insert(scope *node) {
    auto it = std::find(list.begin(), list.end(), node);
    if (it == list.end()) {
      list.push_back(node);
    }
  }

std::list<llvm::AllocaInst*> AlocList;

std::list<llvm::AllocaInst*> IntraAliases(llvm::Value* V){
std::list<llvm::AllocaInst*> Temp;
AggrAlias A;
for (auto x : AlocList){


  if(A.isAlias(x, V)){
    Temp.push_back(x);
  }
}

return Temp;
}










  PreservedAnalyses run(Function &F, FunctionAnalysisManager &FAM) {

  auto &AA = FAM.getResult<AAManager>(F);
  BatchAAResults BatchAA(AA);
  AliasSetTracker AST(BatchAA);

     AggrAlias A;
// for (auto &BB : F) {
//   for(auto &I : BB){
//    for( auto &BB1 : F){
//     for(auto &I1 : BB1){
//        if((isa<llvm::AllocaInst>(&I) || isa<llvm::LoadInst>(&I) ||isa<llvm::LoadInst>(&I) )&& ( isa<llvm::AllocaInst>(&I1) || isa<llvm::LoadInst>(&I1) ||isa<llvm::LoadInst>(&I1) )){
//       if(A.isAlias(dyn_cast<llvm::Value>(&I),dyn_cast<llvm::Value>( &I1))){
//         errs()<<I<<" and "<<I1<<" are alias---------\n"; 
//        }
//       // else{
//       //   // errs()<<I<<" and "<<I1<<" are not alias---------\n";
//       // }
//       }
//     }
//    }
//   }
// }
    

    errs() << "scopePass\n";
    // FunctionAnalysisManager &FAM =
    // MAM.getResult<FunctionAnalysisManagerModuleProxy>(M).getManager();
    // llvm::Function *F = M.getFunction("foo");
    // auto &AA = FAM.getResult<AAManager>(F);
    // BatchAAResults BatchAA(AA);
    // AliasSetTracker AST(BatchAA);

    for (BasicBlock &BB : F) {
      for (llvm::Instruction &I : BB) {
        if (isa<llvm::AllocaInst>(&I)) {
          // llvm::errs() << I << " \n";
          AST.add(&I);
          AlocList.push_back(dyn_cast<llvm::AllocaInst>(&I));
        }

        if (MDNode *MD = I.getMetadata(LLVMContext::MD_dbg)) {

          if (auto *DILoc = dyn_cast<llvm::DILocation>(MD)) {

            llvm::DILocalScope *CID = DILoc->getScope();

            scope *node = new scope(CID);
            insert(node);
          }
        }
        if (isa<llvm::LoadInst>(&I)) {
          AST.add(dyn_cast<llvm::LoadInst>(&I));

          // errs()<<*A.get_true_value(dyn_cast<llvm::Value>(&I));
        }
        if (isa<llvm::StoreInst>(&I)) {
          AST.add(dyn_cast<llvm::StoreInst>(&I));
        }

        if (isa<llvm::CallInst>(&I) && !isa<llvm::IntrinsicInst>(&I)) {
          llvm::CallInst *C = dyn_cast<llvm::CallInst>(&I);
          // errs() << *C->getOperand(0) << " \n";

          // AA.getModRefInfoMask(C->getOperand(0));
        }
        // AST.dump();
        // 	for (AliasSet &AS : AST)
        //    AS.dump();
      }
    }


    
  //   for (const AliasSet &AS : AST) {
  //   if (AS.isMayAlias())
  //     {   
  //       errs()<<"the alias sets  \n";
  //             for (const auto &A : AS) {
  //               Value *Ptr = A.getValue();
  //               // Alias tracker should have pointers of same data type.
  //               errs()<<*Ptr <<"the aliases ----\n";
  //             }
  //     }
  //     if(AS.isMustAlias()){
  //               errs()<<"the alias sets must  \n";
  //             for (const auto &A : AS) {
  //               Value *Ptr = A.getValue();
  //               // Alias tracker should have pointers of same data type.
  //               errs()<<*Ptr <<"the aliases ----\n";
  //             }
  //     }
  // }
  for(BasicBlock &BB :F){
    for (Instruction &I :BB){
      if(isa<llvm::CallInst>(&I) && !isa<llvm::IntrinsicInst>(&I)){
        auto C = dyn_cast<CallInst>(&I);
        auto op = C->getOperand(0);
        auto L= dyn_cast<LoadInst>(op);
        const MemoryLocation MemLoc=MemoryLocation::get(L);
       AliasSet  &x= AST.getAliasSetFor(MemLoc);
                     for (const auto &A : x) {
                Value *Ptr = A.getValue();
                // Alias tracker should have pointers of same data type.
                errs()<<*Ptr <<"the aliases -- of arguments --\n";
              }
      }
    }
  }



    for(BasicBlock &BB :F){
    for (Instruction &I :BB){
      if(isa<llvm::CallInst>(&I) && !isa<llvm::IntrinsicInst>(&I)){
        auto C = dyn_cast<CallInst>(&I);
        auto op = C->getOperand(0);
      auto P= IntraAliases(op);
      errs()<<"the alias sets for func args are \n";
      for(auto x : P){
        errs()<<*x<<"\n";
      }

      }
    }
  }

  

  
  

    return PreservedAnalyses::all();
  }

  static bool isRequired() { return true; }
  //    void getAnalysisUsage(AnalysisUsage &AU) const override {
  //     AU.addRequired<MemorySSAWrapperPass>();
  //     AU.addPreserved<MemorySSAWrapperPass>();

  //   }

}; // struct scopePass
} // namespace

llvm::PassPluginLibraryInfo getHelloWorldPluginInfo() {
  return {LLVM_PLUGIN_API_VERSION, "scopePass", LLVM_VERSION_STRING,
          [](PassBuilder &PB) {
            PB.registerPipelineParsingCallback(
                [](StringRef Name, FunctionPassManager &FPM,
                   ArrayRef<PassBuilder::PipelineElement>) {
                  if (Name == "scopePass") {
                    FPM.addPass(scopePass());

                    return true;
                  }
                  return false;
                });
          }};
}

extern "C" LLVM_ATTRIBUTE_WEAK ::llvm::PassPluginLibraryInfo
llvmGetPassPluginInfo() {
  return getHelloWorldPluginInfo();
}
