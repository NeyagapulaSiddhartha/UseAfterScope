/**
 * This file is distributed under the University of Illinois Open Source
 * License. See LICENSE for details.

 * \file scopePass.cpp
 * Author: Markus Kusano
 * Date: 2013-01-11
 *
 * Remove volatile keyword from some LLVM IR instructions
 */
#include "llvm/Analysis/AliasAnalysis.h"
#include "llvm/Analysis/AliasSetTracker.h"
#include "llvm/Analysis/MemorySSA.h"
#include "llvm/Analysis/MemorySSAUpdater.h"
#include "llvm/IR/DebugInfo.h"
#include "llvm/IR/LegacyPassManager.h"
#include "llvm/Pass.h"
#include "llvm/Passes/PassBuilder.h"
#include "llvm/Passes/PassPlugin.h"
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

  // auto &AA = FAM.getResult<AAManager>(F);
  // BatchAAResults BatchAA(AA);
  // AliasSetTracker AST(BatchAA);

  PreservedAnalyses run(Function &F, FunctionAnalysisManager &FAM) {


     AggrAlias A;

    

    errs() << "scopePass\n";
    // FunctionAnalysisManager &FAM =
    // MAM.getResult<FunctionAnalysisManagerModuleProxy>(M).getManager();
    // llvm::Function *F = M.getFunction("foo");
    auto &AA = FAM.getResult<AAManager>(F);
    BatchAAResults BatchAA(AA);
    AliasSetTracker AST(BatchAA);

    for (BasicBlock &BB : F) {
      for (llvm::Instruction &I : BB) {
        if (isa<llvm::AllocaInst>(&I)) {
          llvm::errs() << I << " \n";
          AST.add(&I);
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

          errs()<<*A.get_true_value(dyn_cast<llvm::Value>(&I));
        }
        if (isa<llvm::StoreInst>(&I)) {
          AST.add(dyn_cast<llvm::StoreInst>(&I));
        }

        if (isa<llvm::CallInst>(&I) && !isa<llvm::IntrinsicInst>(&I)) {
          llvm::CallInst *C = dyn_cast<llvm::CallInst>(&I);
          errs() << *C->getOperand(0) << " \n";

          // AA.getModRefInfoMask(C->getOperand(0));
        }
        // AST.dump();
        // 	for (AliasSet &AS : AST)
        //    AS.dump();
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
