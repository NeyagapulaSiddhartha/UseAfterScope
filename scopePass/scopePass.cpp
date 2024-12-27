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
#include "/home/cs23mtech12010/CCM/CCMutator/llvm-project/llvm/include/llvm/Transforms/Tools/EnumerateCallInst.h"

using namespace llvm;

namespace {
struct scopePass : public PassInfoMixin<scopePass> {
  static char ID;





std::list<llvm::DILocalScope*> ScpList;

std::list<llvm::AllocaInst*> AlocList;

std::list<llvm::AllocaInst*> IntraAliases(llvm::Value* V){
std::list<llvm::AllocaInst*> Temp;

// AggrAlias A;
// for (auto x : AlocList){

//   if(A.isAlias(x, V)){
//     Temp.push_back(x);
//   }
// }

return Temp;
}










  PreservedAnalyses run(Function &F, FunctionAnalysisManager &FAM) {

  auto &AA = FAM.getResult<AAManager>(F);
  BatchAAResults BatchAA(AA);
  AliasSetTracker AST(BatchAA);

    //  AggrAlias A;

         for (BasicBlock &BB : F) {
      for (llvm::Instruction &I : BB) {
        if (isa<llvm::AllocaInst>(&I)) {
          // llvm::errs() << I << " \n";
          
          AlocList.push_back(dyn_cast<llvm::AllocaInst>(&I));
        }
        AST.add(&I);
      }
    }

    EnumerateCallInst ECI;
      ECI.AA=&AST;
      AggrAlias SAA;
      // ECI.SAA=&SAA;
      ECI.ThreadCreateName("pthread_create");
      ECI.ThreadJoinName("pthread_join");
      ECI.visit(F);
      ECI.printInstDebugInfo(1);
      ECI.printInstDebugInfo(2);


    errs() << "scopePass\n";





    
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
