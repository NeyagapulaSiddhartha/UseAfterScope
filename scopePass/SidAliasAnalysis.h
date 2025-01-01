#include "llvm/Pass.h"
#include "llvm/IR/BasicBlock.h"
#include "llvm/IR/Function.h"
#include "llvm/IR/Instruction.h"
#include "llvm/IR/Instructions.h"
#include "llvm/IR/CFG.h"
#include "llvm/Support/raw_ostream.h"
#include <map>
#include "llvm/IR/DebugInfoMetadata.h" // Add this include for DbgDeclareInst
#include <set>
#include<queue>
#include<algorithm>
#include <string>
#include <regex>
#include <iostream>
#include "llvm/Pass.h"
#include "llvm/IR/Module.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/Support/FileSystem.h" // For llvm::sys::fs::F_RW
#include "llvm/IR/DebugInfo.h"
#include "llvm/IR/DebugLoc.h"

using namespace llvm;

// struct alias_c : public FunctionPass {
struct alias_c  {
  static char ID;
   std:: set<   std::pair<Value*,Value *>   > gmap;
   std::vector<Value * > all_variables;
  std:: map<BasicBlock* , std:: set<std::pair<Value* ,Value*>>>B_map;
  std:: map<BasicBlock* , std:: set<std::pair<Value* ,Value*>>>Prev_B_map;
  
//   std::set<std::pair<BasicBlock*> worklist;
// alias_c() : FunctionPass(ID) {}


   std::string get_ret(Value* I);

bool is_variable(Value * I);
StringRef getOriginalName(const Value* V) ;
 Function* findEnclosingFunc(const Value* V);
std:: set<   std::pair<Value*,Value *>> Init(Function &F);
std::vector<Value*> getALLelements( std:: set<   std::pair<Value*,Value *>   > gmap );
std::vector<Value *>Gen (BasicBlock *BB,Value *ROperand,   std:: set<std::pair<Value*,Value *>> gmap);
 std:: set<   std::pair<Value*,Value *>   > cross(std::vector<Value*> v1,std::vector<Value*> v2,int null =0);
 std:: set<   std::pair<Value*,Value*>   > mustkill(BasicBlock * BB, std :: vector < Value*> gen, std:: set<   std::pair<Value*,Value *>   > gmap);
std::map<Instruction*, std::set<std::pair<Value*,Value *>>> I_map;
std::map<llvm::Function*,  std:: set<std::pair<Value*,Value *>>> params;
std::vector<Value *> Pointee(BasicBlock * BB,Value *ROperand,std:: set<   std::pair<Value*,Value *>   > gmap);
 std:: set<std::pair<Value*,Value *>> minus( std:: set<std::pair<Value*,Value *>> gen , std:: set<std::pair<Value*,Value *>> kill);
std:: set<std::pair<Value*,Value *>> uni( std:: set<std::pair<Value*,Value *>> a , std:: set<std::pair<Value*,Value *>> b);
std::list<CallInst*>call_context;
bool  processblock(BasicBlock *BB);
std::set<std::pair<Value*, Value*>> kildal(Function &F);
BasicBlock * getExitBlock(Function &F);
bool runOnFunction(Function &F);
Module *M;
  };






    
  
//  // end of struct alias_c
//   // end of anonymous namespace

// char alias_c::ID = 0;
// static RegisterPass<alias_c> X("alias_lib_given", "Alias Analysis Pass for Assignment",
//                              false /* Only looks at CFG */,
//                              false /* Analysis Pass */);

                            