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
#include"SidAliasAnalysis.h"
using namespace llvm;

namespace {
struct scopePass : public PassInfoMixin<scopePass> {
  static char ID;

std::list<llvm::DILocalScope*> ScpList;
std::list<llvm::AllocaInst*> AlocList;

std::list<llvm::AllocaInst*> IntraAliases(llvm::Value* V){
std::list<llvm::AllocaInst*> Temp;

 // the list of contexts at which a given function is called 

// AggrAlias A;
// for (auto x : AlocList){

//   if(A.isAlias(x, V)){
//     Temp.push_back(x);
//   }
// }
return Temp;
}


  PreservedAnalyses run(Module &M, ModuleAnalysisManager &MAM) {

//  errs()<<"the module ----------------"<<M<<"\n";


    //  AggrAlias A;
              for(Function &F : M){

              }

    EnumerateCallInst ECI;
      ECI.ThreadCreateName("pthread_create");
      ECI.ThreadJoinName("pthread_join");



    llvm::Function *main_func = M.getFunction("main");
    ECI.Threads(main_func, {});

    for(auto x : ECI.Thread_Calls){

      errs()<<"the thread calls are "<<*x.first<<"\n";
      for(auto y : x.second){
        errs()<<"the context is are "<<*y<<"\n";
      }
      errs()<<"t||||||||||||||||||||||||||||||||||| \n";
    }


      for(auto x : ECI.Join_Calls){
      errs()<<"the thread Joins are "<<*x.first<<"\n";
      for(auto y : x.second){
        errs()<<"the context is are "<<*y<<"\n";
      }
      errs()<<"t||||||||||||||||||||||||||||||||||| \n";
    }

      ECI.M=&M;
      // ECI.AA=&AST;
      AggrAlias SAA;
       llvm::Function *F = M.getFunction("main");

       


errs()<<"---------------**********************----------------- \n";
alias_c A;
A.M=&M;
CallInst * call=nullptr;
 for(auto x : ECI.Thread_Calls){

for(Function &F : M){

  if(F.getName().str() == "_Z4fun3PPi")
{   
      for(auto &BB : F){
          for(auto &I : BB){
            if(isa<CallInst>(&I))
            {call = dyn_cast<llvm::CallInst>(&I);
            errs()<<"fount the instruction that needede too be matched%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% \n";}
          }
    }



}


}

      if(x.first == call)
      {

    auto context = x.second;
    context.push_back(x.first);

for (auto &F : M){
      if(!(F.isDeclaration() || F.isIntrinsic() || F.isDeclarationForLinker()))
    
    {
          if(F.getName().str() == "main")
          {
            
            for(auto x : context){
              errs()<<"the context is "<<*x<<"\n";
            }
                A.call_context=context; 
                A.runOnFunction(F);
                    errs()<<"the function name is "<<F.getName().str()<<"\n";
                    errs()<<"***********************************\n";
                    errs()<<"***********************************\n";
                    errs()<<"***********************************\n";errs()<<"***********************************\n";
                    errs()<<"***********************************\n";errs()<<"***********************************\n";
                    errs()<<"***********************************\n";
          }

    }


}

break;
      }
      else{
        errs()<<"the function is not found \n"<<"the function is "<<*x.first<<"\n";
      }
    
    }
// }


      // ECI.SAA=&SAA;
      // errs()<<"after main  \n";

      // ECI.visit(F);
      // ECI.printInstDebugInfo(1);
      // ECI.printInstDebugInfo(2);


    errs() << "scopePass\n";

// AggrAlias1 A1;



    
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
                [](StringRef Name, ModulePassManager &MPM,
                   ArrayRef<PassBuilder::PipelineElement>) {
                  if (Name == "scopePass") {
                    MPM.addPass(scopePass());

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
