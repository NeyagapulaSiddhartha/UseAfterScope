/**
 * This file is distributed under the University of Illinois Open Source
 * License. See LICENSE for details.
 *
 * \file EnumerateCallInst.cpp
 * \author Markus Kusano
 *
 * See EnumerateCallInst.h for more information
 */
#include "EnumerateCallInst.h"
#include "ItaniumDemangle.h"
#include "RemoveInst.h"
#include "llvm/Analysis/AliasAnalysis.h"
#include "llvm/Analysis/AliasSetTracker.h"
#include "llvm/Analysis/MemoryLocation.h"
#include "llvm/IR/DebugInfo.h"
#include "llvm/IR/Instructions.h"
#include "llvm/Support/Casting.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/Transforms/Utils/BasicBlockUtils.h"
#include <queue>

#define MUT_DEBUG

// Enable even more debugging output
// #define MUT_DEBUG_VERB

EnumerateCallInst::EnumerateCallInst() { isCpp = false; }

void EnumerateCallInst::ThreadJoinName(std::string funcName) {
  ThreadJoin.insert(funcName);
}

void EnumerateCallInst::ThreadCreateName(std::string funcName) {
  ThreadCreate.insert(funcName);
}

void EnumerateCallInst::visitCallInst(CallInst &I) {
  // Check if the function being called is in the search set
  Function *call;
  call = I.getCalledFunction();
  int ret;

  ret = checkIfMatch(call);
  if (ret == 1) {
    TC_callInsts.push_back(&I);
  }

  if (ret == 2) {
    TJ_callInsts.push_back(&I);
  }
}
void EnumerateCallInst::Init_Insencitive() {

  for (auto &F : *M) {
    Insencitive[&F] = new node;
    Insencitive[&F]->I = &F;
  }
}

void EnumerateCallInst::Threads(Function *F,
                                std::list<llvm::CallInst *> context) {
  for (auto &BB : *F) {
    for (auto &I : BB) {
      if (auto *CI = dyn_cast<CallInst>(&I)) {

        auto ret = checkIfMatch(CI->getCalledFunction());

        // errs()<<" the call instruction analysed is "<<*CI<<"\n";
        if (ret == 1) { // thread create
          Thread_Calls[context] = CI;
          //  context.push_back(CI);
          auto x = context;

          if (auto *II = dyn_cast<Function>(CI->getOperand(2))) {
            x.push_back(CI);
            Threads(II, x);
          }
        }
        if (ret == 2) { // thread join
          Join_Calls[context] = CI;
        }
        if (ret == 3) { // Normal function call
          auto x = context;
          x.push_back(CI);
          Threads(CI->getCalledFunction(), x);
        }
        // if(auto *II = dyn_cast<InvokeInst>(&I)){
        //     visitInvokeInst(*II);
        // }
      }
    }
  }
}

void EnumerateCallInst::CreateCallGraph(Function *F, node *root,
                                        int Thread_depth, int Call_depth) {

  for (auto &BB : *F) {

    for (auto &I : BB) {

      if (auto *CI = dyn_cast<CallInst>(&I)) {

        auto ret = checkIfMatch(CI->getCalledFunction());

        if (ret == 1) { // thread call
          if (Call_depth >= 3) {
            auto *II = dyn_cast<Function>(CI->getOperand(2));
            root->Thread.push_back(Insencitive[II]);
            //
          }
          auto *II = dyn_cast<Function>(CI->getOperand(2));
          node *temp = new node;
          temp->I = &I;

          root->Thread.push_back(temp);

          CreateCallGraph(II, temp, Thread_depth + 1, Call_depth + 1);
        }

        if (ret == 2) { // join calll
          root->Join.push_back(&I);
        }

        if (ret == 3) { // user defined function call
          auto II = CI->getCalledFunction();
          if (Call_depth >= 3) {
            root->succ.push_back(Insencitive[CI->getCalledFunction()]);
            //
          } else {
            // errs()<<"the normal function call is "<<*CI<<"\n";
            node *temp = new node;
            temp->I = &I;
            root->succ.push_back(temp);
            CreateCallGraph(CI->getCalledFunction(), temp, Thread_depth,
                            Call_depth + 1);
          }
        }
      }
    }
  }
}

void EnumerateCallInst::Create_ContextInsensitve(
    std::map<Function *, int> visited) {

  for (auto x : Insencitive) {
    if (!visited[x.first]) {
      visited[x.first]++;
      for (auto &BB : *x.first) {

        for (auto &I : BB) {

          if (auto *CI = dyn_cast<CallInst>(&I)) {

            auto ret = checkIfMatch(CI->getCalledFunction());

            if (ret == 1) { // thread call
              auto *II = dyn_cast<Function>(CI->getOperand(2));

              auto it = std::find(Insencitive[x.first]->Thread.begin(),
                                  Insencitive[x.first]->Thread.end(),
                                  Insencitive[II]);
              if (it != Insencitive[x.first]->Thread.end()) {

                Insencitive[x.first]->Thread.push_back(Insencitive[II]);
              }

              // }
            }
            if (ret == 2) { // join calll
            }
            if (ret == 3) {
              // user defined function call
              auto *II = dyn_cast<Function>(CI->getOperand(2));
              auto it =
                  std::find(Insencitive[x.first]->succ.begin(),
                            Insencitive[x.first]->succ.end(), Insencitive[II]);
              if (it != Insencitive[x.first]->succ.end()) {

                Insencitive[x.first]->Thread.push_back(Insencitive[II]);
              }
            }
          }
        }
      }
    }
  }
}

void EnumerateCallInst::RunAlias(node *root) {

  std::queue<node *> qu;
  if (auto x = dyn_cast<Function>(root->I)) {
    A.runOnFunction(*x, root);

  }

  else {
    auto ci = dyn_cast<CallInst>(root->I);
    int ret = checkIfMatch(ci->getCalledFunction());

    if (ret == 1) {
      auto f = dyn_cast<Function>(ci->getOperand(2));

      A.runOnFunction(*f, root);
    }
    if (ret == 3) {
      A.runOnFunction(*(ci->getCalledFunction()), root);
    }
  }
}

void EnumerateCallInst::BFS(node *start) {

//   errs() << "starting the BFS " << "  \n";
  if (!start)
    return; // Handle null input

  std::queue<node *> q;          // Queue for BFS
  std::map<node *, int> visited; // Set to track visited nodes

  // Initialize the BFS
  q.push(start);

  std::cout << "BFS traversal order: ";

  while (!q.empty()) {
    node *current = q.front();
    q.pop();

    // Process the current node (printing its ID here)
    visited[current]++;
    RunAlias(current);
    // if (isa<Function>(current->I)) {
    //   errs() << "doing bFS  " << dyn_cast<Function>(current->I)->getName().str()
    //          << " \n";
    // } else {
    //   errs() << "doing bFS  " << *(current->I) << " \n";
    // }
    // Traverse the successors
    for (node *neighbor : current->succ) {
      if (visited[current] + visited[neighbor] < 3) {
        q.push(neighbor);
        // visited.insert(neighbor);
      }
    }
    for (node *neighbor : current->Thread) {
      if (visited[current] + visited[neighbor] < 3) {
        q.push(neighbor);
        // visited.insert(neighbor);
      }
    }
  }
  std::cout << std::endl;
}

void EnumerateCallInst::visitInvokeInst(InvokeInst &I) {
  // Check if the function being called is in the search set
  Function *call;
  call = I.getCalledFunction();
  bool ret;

  ret = checkIfMatch(call);
  if (ret) {
#ifdef MUT_DEBUG
    errs() << "DEBUG: Matching InvokeInst found\n" << I << '\n';
#endif
    invokeInsts.push_back(&I);
  }
}

MemoryLocation EnumerateCallInst::getMem(Value *V) {
  if (isa<AllocaInst>(V)) {

    auto AI = dyn_cast<AllocaInst>(V);
    Module *M = AI->getFunction()->getParent();
    const DataLayout &DL = M->getDataLayout();
    Type *AllocatedType = AI->getAllocatedType();
    uint64_t Size = DL.getTypeStoreSize(AllocatedType);
    return MemoryLocation(AI, Size);
  }
  if (auto L = dyn_cast<LoadInst>(V))
    return MemoryLocation::get(L);
}

void EnumerateCallInst::makepairs(std::vector<CallInst *> TC_callInsts,
                                  std::vector<CallInst *> TJ_callInsts) {

  // errs()<<"entered the makepairs\n";
  //     auto instr= dyn_cast<Instruction>(TC_callInsts[0]);
  //     if (const BasicBlock* bb = instr->getParent()) {
  //     if (const Function* func = bb->getParent()) {
  //           errs()<<"weweweweentered the makepairs\n";
  //          errs()<<*func->getParent()<<"\n";
  //     }
  //     else{
  //         errs()<<"the parent is inner null\n";
  //     }
  // }
  // else{
  //     errs()<<"the parent is null\n";
  // }

  // SAA->run_main(M);

  //    for(auto i=0;i<TC_callInsts.size();i++){
  //         for(auto j=0;j<TJ_callInsts.size();j++){
  //             auto x= TC_callInsts[i]->getArgOperand(0);
  //             auto y= TJ_callInsts[j]->getArgOperand(0);
  //                BasicBlock *BB=  TC_callInsts[i]->getParent();
  //                 Function *F = BB->getParent();
  //                 auto &LBB = F->back();
  //                 AliasSet& AR1= AA->getAliasSetFor(getMem(x));
  //                 AliasSet& AR2= AA->getAliasSetFor(getMem(y));
  //                 bool alias=false;
  //             //     for(auto& temp: AR1){
  //             //          errs()<<"the alias are "<<*temp.getValue()<<
  //             *TC_callInsts[i]<<"\n";
  //             //         if(temp.getValue()==y){
  //             //             alias=true;
  //             //         }
  //             //     }
  //             // for(auto& temp: AR2){
  //             //        errs()<<"the alias are "<<*temp.getValue()<<
  //             *TJ_callInsts[j]<<"\n";
  //             //         if(temp.getValue()==x){
  //             //             alias=true;
  //             //         }
  //             //     }
  //                 // if(alias){
  //                 //
  //                 pairs.push_back(std::make_pair(TC_callInsts[i],TJ_callInsts[j]));
  //                 // }

  //             if(SAA->isAlias(y, x, &LBB.back())){
  //                 pairs.push_back(std::make_pair(TC_callInsts[i],TJ_callInsts[j]));
  //                 }
  //                 else{
  //                     errs()<<*x <<" ---- "<<*y<<"are not aliases
  //                     --------------------\n";
  //                 }

  //         }
  //     }

//   for (auto x : pairs) {

//     errs() << "the pairs are " << *x.first << "  " << *x.second << "\n";
//   }
}

int EnumerateCallInst::checkIfMatch(Function *F) {
  char *demangledFuncName;
  std::string foundName;

  if (F) {
    // Assumption: calls to searched for will never be indirect
#ifdef MUT_DEBUG_VERB
    errs() << "DEBUG: function calling: ";
    errs() << F->getName() << '\n';
#endif
    if (isCpp) {
      demangledFuncName =
          demangleCpp(F->getName()); // potentially returns malloced char*
      if (demangledFuncName == NULL) {
        // If demangling failed, assume the function name is a non mangled
        foundName = F->getName();
      } else {
        foundName = removeParameters(demangledFuncName);
        free(demangledFuncName);
      }
    } else {
      foundName = F->getName();
    }

    if (ThreadCreate.count(foundName)) {
      // Found a match
      return 1;
    }
    if (ThreadJoin.count(foundName)) {
      // Found a match
      return 2;
    }
    if (!(F->isDeclaration() || F->isIntrinsic() ||
          F->isDeclarationForLinker())) {
      return 3;
    }
    // errs()<<"the function is "<<foundName<<"\n";
  } else {
    errs() << "WARNING: Indirect function call found, ignoring\n";
  }

  return 0;
}

void EnumerateCallInst::printInstDebugInfo(int x) {

  if (x == 1) {
    callInsts = TC_callInsts;
    printInstDebugInfo();
  } else {
    callInsts = TJ_callInsts;
    printInstDebugInfo();
  }

  makepairs(TC_callInsts, TJ_callInsts);
}

void EnumerateCallInst::printInstDebugInfo() const {
  // Iterate over each  call instruction and print out
  // it's information if found. Otherwise print out a warning
  errs() << "entered the printInstDebugInfo\n";
  MDNode *metaNode;

  for (unsigned i = 0; i < callInsts.size(); i++) {
    errs() << callInsts[i]->getCalledFunction()->getName() << "\t";

    // errs()<<"parameters are "<<*CallInstparm.at(callInsts[i])<<"\t";
    metaNode = callInsts[i]->getMetadata("dbg");
    if (metaNode) {
      if (auto *Loc = llvm::dyn_cast<llvm::DILocation>(metaNode)) {
        auto x = Loc->getScope();
        StringRef File = Loc->getFilename();
        unsigned Line = Loc->getLine();
        auto f = x->getScope();
        llvm::errs() << File << '\t' << Line << " \t" << x << '\n';
      }
    } else {
      errs() << "Warning: No meta data found for instruction " << i << '\n';
    }
  }
  // for (unsigned i = 0; i < invokeInsts.size(); i++) {
  //     metaNode = invokeInsts[i]->getMetadata("dbg");
  //     if (metaNode) {
  //         DILocation Loc(metaNode);
  //         StringRef File = Loc.getFilename();
  //         unsigned Line = Loc.getLineNumber();
  //         errs() << File << '\t' << Line << '\n';
  //     }
  //     else {
  //         errs() << "Warning: No meta data found for instruction "
  //                << i << '\n';
  //     }
  // }
  for (unsigned i = 0; i < invokeInsts.size(); i++) {
    if (auto *metaNode = invokeInsts[i]->getMetadata("dbg")) {
      if (auto *Loc = llvm::dyn_cast<llvm::DILocation>(metaNode)) {
        StringRef File = Loc->getFilename();
        unsigned Line = Loc->getLine();
        llvm::errs() << File << '\t' << Line << '\n';
      }
    }
  }
}

void EnumerateCallInst::searchCpp() { isCpp = true; }

bool EnumerateCallInst::getIsCpp() { return isCpp; }
