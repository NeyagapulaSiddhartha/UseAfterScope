/**
 * This file is distributed under the University of Illinois Open Source
 * License. See LICENSE for details.

 * \file scopePass.cpp
 * Author: Markus Kusano
 * Date: 2013-01-11
 *
 * Remove volatile keyword from some LLVM IR instructions
 */
#include "/home/cs23mtech12010/CCM/CCMutator/llvm-project/llvm/include/llvm/Transforms/Tools/EnumerateCallInst.h"
#include "/home/cs23mtech12010/CCM/CCMutator/llvm-project/llvm/lib/Transforms/scopePass/SidAliasAnalysis.h"
#include "AliasAnalysis.h"
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
using namespace llvm;

void print(node root) {
  for (auto x : root.succ) {
    // print(*x);
    errs() << "the succ is " << *(x->I) << "\n";
  }
  for (auto x : root.Thread) {
    // print(*x);
    errs() << "the succ is " << *(x->I) << "\n";
  }
  for (auto x : root.succ) {
    print(*x);
    // errs()<<"the succ is "<<*(x->I)<<"\n";
  }
  for (auto x : root.Thread) {
    print(*x);
    // errs()<<"the succ is "<<*(x->I)<<"\n";
  }
}

namespace {
struct scopePass : public PassInfoMixin<scopePass> {
  static char ID;

  std::list<llvm::DILocalScope *> ScpList;
  std::list<llvm::AllocaInst *> AlocList;

  std::list<llvm::AllocaInst *> IntraAliases(llvm::Value *V) {
    std::list<llvm::AllocaInst *> Temp;

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

    EnumerateCallInst ECI;
    ECI.ThreadCreateName("pthread_create");
    ECI.ThreadJoinName("pthread_join");

    llvm::Function *main_func = M.getFunction("main");
    ECI.Threads(main_func, {});

    // for(auto x : ECI.Thread_Calls){

    //   errs()<<"the thread calls are "<<*x.second<<"\n";
    //   for(auto y : x.first){
    //     errs()<<"the context is are "<<*y<<"\n";
    //   }
    //   errs()<<"t||||||||||||||||||||||||||||||||||| \n";
    // }

    //   for(auto x : ECI.Join_Calls){
    //   errs()<<"the thread Joins are "<<*x.second<<"\n";
    //   for(auto y : x.first){
    //     errs()<<"the context is are "<<*y<<"\n";
    //   }
    //   errs()<<"t||||||||||||||||||||||||||||||||||| \n";
    // }

    ECI.M = &M;
    // ECI.AA=&AST;

    llvm::Function *F = M.getFunction("main");

    errs() << "---------------**********************----------------- \n";
    alias_c A;
    A.M = &M;
    CallInst *call = nullptr;

    node root;
    root.I = M.getFunction("main");
    root.succ = {};
    ECI.Init_Insencitive();

    ECI.CreateCallGraph(M.getFunction("main"), &root);

    std::map<Function *, int> visited;

    for (Function &F : M) {
      visited[&F] = 0;
    }
    ECI.Create_ContextInsensitve(visited);

    ECI.BFS(&root);

    auto x = A.runOnFunction(*M.getFunction("main"),
                             &root); // running analysis on the main function
    root.aaResult = x;
    auto final_list = x;

    // print(root);

    // ECI.SAA=&SAA;
    errs() << "after main  \n";

    ECI.visit(F);
    // ECI.printInstDebugInfo(1);
    // ECI.printInstDebugInfo(2);

    errs() << "scopePass\n";

    return PreservedAnalyses::all();
  }

  static bool isRequired() { return true; }

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
