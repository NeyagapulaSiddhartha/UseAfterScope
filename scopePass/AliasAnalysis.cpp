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
#include "AliasAnalysis.h"
//Primary Driver Struct of the pass
using namespace llvm;


   llvm::Value*  AggrAlias::get_true_value(llvm::Value *val)
    {
        std::vector<llvm::Instruction*>instr_set = {}; // Instruction Set to iterate over
        if(llvm::Instruction *I = llvm::dyn_cast<llvm::Instruction>(val))
        {
            instr_set.push_back(I); // Insert the instruction into the instr_set to recursively travese
        }
        while(!instr_set.empty())
        {
            auto iter_instr = instr_set.begin();
            if(llvm::isa<llvm::AllocaInst>(*iter_instr))
            {
                return *iter_instr;
            }
            else if (llvm::isa<llvm::CallInst>(*iter_instr))
            {
                return *iter_instr;
            }
            else if(llvm::LoadInst *LI = llvm::dyn_cast<llvm::LoadInst>(*iter_instr))
            {
                llvm::Value *val_inserter = LI->getPointerOperand();
                if(llvm::isa<llvm::GlobalValue>(val_inserter))
                {
                    return val_inserter;
                }
                if(llvm::Instruction *I = llvm::dyn_cast<llvm::Instruction>(val_inserter))
                {
                    instr_set.push_back(I);
                }
                else if(llvm::isa<llvm::Argument>(val_inserter))
                {
                    return val_inserter;
                }
            }
            else if(llvm::GetElementPtrInst *GEP = llvm::dyn_cast<llvm::GetElementPtrInst>(*iter_instr))
            {
                llvm::Value *val_inserter = GEP->getPointerOperand();

                if(llvm::isa<llvm::GlobalValue>(val_inserter))
                {
                    return val_inserter;
                }
                if(llvm::Instruction *I = llvm::dyn_cast<llvm::Instruction>(val_inserter))
                {
                    instr_set.push_back(I);
                }
                else if(llvm::isa<llvm::Argument>(val_inserter))
                {
                    return val_inserter;
                }
            }
            else if(llvm::CastInst *CSI = llvm::dyn_cast<llvm::CastInst>(*iter_instr))
            {
                llvm::Value *val_inserter = CSI->getOperand(0);
                if(llvm::isa<llvm::GlobalValue>(val_inserter))
                {
                    return val_inserter;
                }
                if(llvm::Instruction *I = llvm::dyn_cast<llvm::Instruction>(val_inserter))
                {
                    instr_set.push_back(I);
                }
                else if(llvm::isa<llvm::Argument>(val_inserter))
                {
                    return val_inserter;
                }
            }
            instr_set.erase(instr_set.begin());
        }
    }

    //Return True LLVM::Value from a Intermediate Value for a Function
   llvm::Value*   AggrAlias::get_true_value(llvm::Value *val, std::vector<llvm::Instruction*>caller_instr_stack)
    {
        #if DEBUG
            errs()<<"DEBUGGING: Function Name: get_true_value\n"  ;
        #endif
        if(caller_instr_stack.empty())
        {
            return get_true_value(val);
        }
        std::vector<llvm::Value*>instr_set = {}; // Instruction Set to iterate over
        instr_set.push_back(val); // Push the value in the instruction set
        while(!instr_set.empty())
        {
            auto iter_instr = instr_set.begin();
            if(llvm::isa<llvm::AllocaInst>(*iter_instr))
            {
                return *iter_instr;
            }
            else if(llvm::Argument *arg = llvm::dyn_cast<llvm::Argument>(*iter_instr))
            {
                llvm::Instruction *caller_instr = caller_instr_stack.back();
                if(llvm::CallInst *CI = llvm::dyn_cast<llvm::CallInst>(caller_instr))
                {
                    llvm::Function *caller_func = CI->getCalledFunction();
                    int iter_count = 0; //takes the count of the argument index
                    for(auto arg_iter = caller_func->arg_begin(); arg_iter!=caller_func->arg_end(); arg_iter++)
                    {
                        if(llvm::Argument* val_arg_iter = llvm::dyn_cast<llvm::Argument>(arg_iter))
                        {
                            if(val_arg_iter == arg)
                            {
                                break;
                            }
                        }
                        iter_count++;
                    }
                    //get the argument at that particular index
                    llvm::Value *val_inserter = CI->getArgOperand(iter_count);
                    instr_set.push_back(val_inserter);
                }
                else
                {
                    llvm::errs()<<"Error: The caller instruction is not a Call Instruction\n";
                    exit(1);
                }
                caller_instr_stack.pop_back();
            }
            else if (llvm::CallInst *CI = llvm::dyn_cast<llvm::CallInst>(*iter_instr))
            {
                return *iter_instr;
            }
            else if(llvm::LoadInst *LI = llvm::dyn_cast<llvm::LoadInst>(*iter_instr))
            {
                // return LI->getPointerOperand();
                llvm::Value *val_inserter = LI->getPointerOperand();
                if(llvm::isa<llvm::GlobalValue>(val_inserter))
                {
                    return val_inserter;
                }
                if(llvm::isa<llvm::Instruction>(val_inserter))
                {
                    instr_set.push_back(val_inserter);
                }
                else if(llvm::isa<llvm::Argument>(val_inserter))
                {
                    instr_set.push_back(val_inserter);
                }
            }
            else if(llvm::GetElementPtrInst *GEP = llvm::dyn_cast<llvm::GetElementPtrInst>(*iter_instr))
            {
                llvm::Value *val_inserter = GEP->getPointerOperand();

                if(llvm::isa<llvm::GlobalValue>(val_inserter))
                {
                    return val_inserter;
                }
                if(llvm::isa<llvm::Instruction>(val_inserter))
                {
                    instr_set.push_back(val_inserter);
                }
                else if(llvm::isa<llvm::Argument>(val_inserter))
                {
                    instr_set.push_back(val_inserter);
                }
                // return GEP->getPointerOperand();
            }
            else if(llvm::CastInst *CSI = llvm::dyn_cast<llvm::CastInst>(*iter_instr))
            {
                llvm::Value *val_inserter = CSI->getOperand(0);
                if(llvm::isa<llvm::GlobalValue>(val_inserter))
                {
                    return val_inserter;
                }
                if(llvm::isa<llvm::Instruction>(val_inserter))
                {
                    instr_set.push_back(val_inserter);
                }
                else if(llvm::isa<llvm::Argument>(val_inserter))
                {
                    instr_set.push_back(val_inserter);;
                }
            }
            instr_set.erase(instr_set.begin());
        }
    }

    llvm::Function *    AggrAlias::getFunction(llvm::Value *val)
    {
        if(llvm::Instruction *instr = llvm::dyn_cast<llvm::Instruction>(val))
        {
            return instr->getFunction();
        }
        else if(llvm::Argument *arg = llvm::dyn_cast<llvm::Argument>(val))
        {
            return arg->getParent();
        }
    }

    bool    AggrAlias::isAlias(llvm::Value *val1, llvm::Value* val2)
    {
        //assertion checks
        assert((val1!=nullptr || val2!=nullptr) && "Value is nullptr");
        llvm::Value *val1_true = get_true_value(val1);
        llvm::Value *val2_true = get_true_value(val2);
        if(val1_true == val2_true)
        {
            return true;
        }
        else
        {
            return false;
        }
    }

    bool  AggrAlias::isAlias_inter(llvm::Value *val1, std::vector<llvm::Instruction*> context1, 
        llvm::Value* val2, std::vector<llvm::Instruction*> context2)
    {
        assert((val1!=nullptr || val2!=nullptr) && "Value is nullptr");
        if(context1.size() == 0 && context2.size() == 0)
        {
            return isAlias(val1, val2); //Context is emty hence calling intraprocedural alias analysis
        }
        llvm::Function *func1 = getFunction(val1);
        llvm::Function *func2 = getFunction(val2);
        if(func1 == func2)
        {
            return isAlias(val1, val2);
        }
        llvm::Value* val1_true = get_true_value(val1, context1);
        llvm::Value* val2_true = get_true_value(val2, context2);
        if(val1_true == val2_true)
        {
            return true;
        }
        else
        {
            return false;
        }
    }

