#include "AliasAnalysis.h"

#define DEBUG 0

bool AggrAlias::is_changed(std::map<llvm::Value*, std::set<llvm::Value*>> old_map, 
        std::map<llvm::Value*, std::set<llvm::Value*>> new_map)
{
    bool flag_changed = false;
    for(auto iter = old_map.begin(); iter!=old_map.end(); iter++)
    {
        if(new_map.find(iter->first) == new_map.end())
        {
            flag_changed = true;
            return flag_changed;
        }
        else
        {
            for(auto ptr_iter = iter->second.begin(); ptr_iter!=iter->second.end(); ptr_iter++)
            {
                if(new_map[iter->first].find(*ptr_iter) != new_map[iter->first].end())
                {
                    continue;
                }
                else
                {
                    flag_changed = true;
                    return flag_changed;
                }
            }
        }
    }
    return flag_changed;
}

//check if the two values are aliases at instruction instr
bool AggrAlias::isAlias(llvm::Value *val1, llvm::Value *val2, llvm::Instruction *instr)
{
    assert(val1->getType()->isPointerTy() && "val1 is not a pointer");
    assert(val2->getType()->isPointerTy() && "val2 is not a pointer");
    assert(instr!=nullptr && "Instruction is null");

    //If alias Analysis has run atleast once
    static bool alias_analysis_run = false;
    if(!alias_analysis_run)
    {
        llvm::Module *M = instr->getModule();
        run_main(M); //run the alias analysis
        alias_analysis_run = true;
    }

    std::set<llvm::Value*> f_pset = points_to_map_out[instr][val1];
    std::set<llvm::Value*> s_pset = points_to_map_out[instr][val2];
    for(auto iter = f_pset.begin(); iter!=f_pset.end(); iter++)
    {
        if(s_pset.find(*iter) != s_pset.end())
        {
            return true;
        }
    }
    return false;
}

std::vector<llvm::Instruction*> AggrAlias::getSuccessorInstructions(llvm::Instruction *instr)
{
    std::vector<llvm::Instruction*>successor_instr;
    // errs()<<*instr<<"\n"; //debug
    if(!instr->isTerminator())
    {
        successor_instr.push_back(instr->getNextNode());
    }
    else
    {
        for(int i=0; i<instr->getNumSuccessors(); i++)
        {
            llvm::BasicBlock *succ_bb = instr->getSuccessor(i);
            successor_instr.push_back(&succ_bb->front());
        }
    }
    return successor_instr;
}

std::vector<llvm::Instruction*> AggrAlias::getPredecessorInstructions(llvm::Instruction *instr)
{
    std::vector<llvm::Instruction*>predecessor_instr;
    llvm::BasicBlock *contain_bb = instr->getParent();
    llvm::Instruction *first_instr = &contain_bb->front();
    if(first_instr!=instr)
    {
        std::vector<llvm::Instruction*> temp_vector;
        for(auto iterator = contain_bb->begin(); iterator!=contain_bb->end(); iterator++)
        {
            if(&*iterator == instr)
            {
                break;
            }
            temp_vector.push_back(&*iterator);
        }
        predecessor_instr.push_back(temp_vector.back());
    }
    else
    {
        for(auto pred_bb = pred_begin(contain_bb); pred_bb!=pred_end(contain_bb); pred_bb++)
        {
            predecessor_instr.push_back(&(*pred_bb)->back());
        }
    }
    return predecessor_instr;
}

llvm::ReturnInst * AggrAlias::getReturnInstruction(llvm::Function *func)
{
    for(auto bb_iter = func->begin(); bb_iter!=func->end(); bb_iter++)
    {
        for(auto instr_iter = bb_iter->begin(); instr_iter!=bb_iter->end(); instr_iter++)
        {
            if(llvm::ReturnInst *RI = llvm::dyn_cast<llvm::ReturnInst>(instr_iter))
            {
                return RI;
            }
        }
    }
}

void AggrAlias::run_alias_analysis(llvm::Function *func)
{
    #if DEBUG
        llvm::errs()<<"Running Alias Analysis for Function: "<<func->getName().str()<<"\n";
    #endif
    std::vector <llvm::Instruction*> worklist = {}; //worklist to iterate over the instructions
    std::set<llvm::Instruction*> visited_instr = {}; //set to keep track of the visited instructions
    if(llvm::Instruction *instr_start = llvm::dyn_cast<llvm::Instruction>(func->getEntryBlock().begin()))
    {
        worklist.push_back(instr_start);
    }
    make_alias_info(func, call_stack);
    while(!worklist.empty())
    {
        llvm::Instruction *instr = worklist.front();
        visited_instr.insert(instr);

        points_to_map_out[instr] = points_to_map_in[instr]; //copy the in set to the out set

        // if(llvm::AllocaInst *AI = llvm::dyn_cast<llvm::AllocaInst>(instr))
        // {
        //     llvm::Value *ai_val = get_value(AI);
        //     points_to_map_out[instr][ai_val] = {ai_val};
        // }
        // else if(llvm::LoadInst *LI = llvm::dyn_cast<llvm::LoadInst>(instr))
        // {
        //     llvm::Value *load_val = LI->getPointerOperand();
        //     llvm::Value *load_instr_val = get_value(LI);
        //     points_to_map_out[instr][load_val].insert(load_instr_val);
        // }
        if (llvm::StoreInst *SI = llvm::dyn_cast<llvm::StoreInst>(instr))
        {
            llvm::Value *op_val = SI->getValueOperand();
            llvm::Value *ptr_val = SI->getPointerOperand();
            if(op_val->getType()->isPointerTy() && ptr_val->getType()->isPointerTy())
            {
                if(llvm::LoadInst *op_load = llvm::dyn_cast<llvm::LoadInst>(op_val))
                {
                    llvm::Value *op_load_val = getLoadValue(op_load);
                    if(llvm::LoadInst *ptr_load = llvm::dyn_cast<llvm::LoadInst>(ptr_val))
                    {
                        llvm::Value *ptr_load_val = getLoadValue(ptr_load);
                        for(auto iter = points_to_map_in[instr][ptr_load_val].begin(); iter!=points_to_map_in[instr][ptr_load_val].end(); iter++)
                        {
                            points_to_map_out[instr][*iter] = points_to_map_in[instr][op_load_val];
                        }
                    }
                    else
                    {
                        points_to_map_out[instr][ptr_val] = points_to_map_in[instr][op_load_val];
                    }
                }
                else
                {
                    if(llvm::LoadInst *ptr_load = llvm::dyn_cast<llvm::LoadInst>(ptr_val))
                    {
                        llvm::Value *ptr_load_val = getLoadValue(ptr_load);
                        for(auto iter = points_to_map_in[instr][ptr_load_val].begin(); iter!=points_to_map_in[instr][ptr_load_val].end(); iter++)
                        {
                            points_to_map_out[instr][ptr_val].insert(*iter);
                        }
                    }
                    else
                    {
                        points_to_map_out[instr][ptr_val].insert(op_val);
                    }
                }
            }
            
            // else
            // {
            //     points_to_map_out[instr][ptr_val] = {op_val};
            // }
        }
        else if(llvm::CallInst *CI = llvm::dyn_cast<llvm::CallInst>(instr))
        {
            llvm::Function *called_func = CI->getCalledFunction();
            if(!called_func->isDeclaration()){
                call_stack.push_back(instr);
                //Impelement CallInstruction iter
                int count_arg = 0;
                for(auto iter = CI->arg_begin(); iter!=CI->arg_end(); iter++)
                {
                    llvm::Value *func_arg = called_func->getArg(count_arg);
                    llvm::Value *arg_val = *iter;
                    points_to_map_inter_in[CI][func_arg] = points_to_map_out[instr][arg_val];
                    count_arg++;
                }
                points_to_map_inter_in[CI] = points_to_map_in[instr];
                run_alias_analysis(called_func);
                call_stack.pop_back();
                points_to_map_out[instr] = points_to_map_inter_out[CI];
            }
            else
            {
                points_to_map_out[instr] = points_to_map_in[instr];
            }
        }
        //get the successor instructions
        std::vector<llvm::Instruction*>successor_instr = getSuccessorInstructions(instr);
        for(auto iter = successor_instr.begin(); iter!=successor_instr.end(); iter++)
        {
            std::vector<llvm::Instruction*> pred_set = getPredecessorInstructions(*iter);
            std::map<llvm::Value*, std::set<llvm::Value*>> successor_points_to_set;
            for(auto iter_pred = pred_set.begin(); iter_pred!=pred_set.end(); iter_pred++)
            {
                for(auto iter_val = points_to_map_out[*iter_pred].begin(); iter_val!=points_to_map_out[*iter_pred].end(); iter_val++)
                {
                    for(auto iter_set = iter_val->second.begin(); iter_set!=iter_val->second.end(); iter_set++)
                    {
                        successor_points_to_set[iter_val->first].insert(*iter_set);
                    }
                } 
            }
            if(visited_instr.find(*iter) == visited_instr.end() || 
                is_changed(points_to_map_in[*iter], successor_points_to_set))
            {
                points_to_map_in[*iter] = successor_points_to_set;
                worklist.push_back(*iter);   
            }
            // llvm::errs()<<"Successor Set::::::::::::::\n";
            // //debug
            // for(auto iter = successor_points_to_set.begin(); iter!=successor_points_to_set.end(); iter++)
            // {
            //     llvm::errs()<<"Value: "<<*(iter->first)<<"\n";
            //     for(auto iter_set = iter->second.begin(); iter_set!=iter->second.end(); iter_set++)
            //     {
            //         llvm::errs()<<"Points to: "<<**(iter_set)<<"\n";
            //     }
            // }
            // llvm::errs()<<"Successor Set End::::::::::::::\n";
        }
        worklist.erase(worklist.begin());
    }
    llvm::Instruction *ret_inst = getReturnInstruction(func);
    if(call_stack.empty()==false){
        llvm::Instruction *call_instr = call_stack.back();
        if(llvm::CallInst *CI = llvm::dyn_cast<llvm::CallInst>(call_instr))
        {
            points_to_map_inter_out[CI] = points_to_map_out[ret_inst];
            //remove the information of function local args from the points to map out
            for(auto iter = func->arg_begin(); iter!=func->arg_end(); iter++)
            {
                llvm::Value *arg_val = iter;
                if(points_to_map_inter_out[CI].find(arg_val) != points_to_map_inter_out[CI].end())
                    points_to_map_inter_out[CI][ret_inst].erase(arg_val);
            }
        }
    }
    #if DEBUG
        llvm::errs()<<"Alias Analysis Completed for Function: "<<func->getName().str()<<"\n";
        if(call_stack.empty()==false)
            llvm::errs()<<"Call Site: "<<*(call_stack.back())<<"\n";
    #endif
    return;
}

llvm::Value* AggrAlias::get_value(llvm::Instruction *instr)
{
    if(llvm::Value *val = llvm::dyn_cast<llvm::Value>(instr))
    {
        return val;
    }
}

void AggrAlias::make_alias_info(llvm::Function *func, std::vector<llvm::Instruction*>context)
{
    //initialize the points-to-set with the alloca instructions
    for(auto bb_iter = func->begin(); bb_iter!=func->end(); bb_iter++)
    {
        for(auto instr_iter = bb_iter->begin(); instr_iter!=bb_iter->end(); instr_iter++)
        {
            if(llvm::Instruction *instr = llvm::dyn_cast<llvm::Instruction>(instr_iter))
            {
                points_to_map_in[instr] = {}; //initialize the points to map with empty set
                points_to_map_out[instr] = {}; //initialize the points to map with empty set      
            }
        }
    }
    if(context.empty()==false)
    {
        llvm::Instruction *callsite_instr = context.back();
        if(llvm::CallInst *CI = llvm::dyn_cast<llvm::CallInst>(callsite_instr))
        {
            points_to_map_in[&func->getEntryBlock().front()] = points_to_map_inter_out[CI];
        }
    }
}

void AggrAlias::run_main(llvm::Module *M)
{
    llvm::Function *main_func = M->getFunction("main");
    run_alias_analysis(main_func); //start the alias analysis on every function
}

void AggrAlias::PrintAll()
{
    for(auto iter = points_to_map_out.begin(); iter!=points_to_map_out.end(); iter++)
    {
        llvm::errs()<<"Instruction: "<<*(iter->first)<<"\n";
        print_analysis_results(iter->first);
    }
}

void AggrAlias::print_analysis_results(llvm::Instruction *instr)
{
    //print points to map
    std::map<llvm::Value*, std::set<llvm::Value*>> points_to_set = points_to_map_out[instr];
    llvm::errs()<<"Points to Set::::::::::::::\n";
    for(auto iter = points_to_set.begin(); iter!=points_to_set.end(); iter++)
    {
        llvm::errs()<<"Value: "<<*(iter->first)<<"{\n";
        for(auto iter_set = iter->second.begin(); iter_set!=iter->second.end(); iter_set++)
        {
            llvm::errs()<<"Points to: "<<**(iter_set)<<"\n";
        }
        llvm::errs()<<"}\n";
    }
    llvm::errs()<<"Points to Set End::::::::::::::\n";
}

llvm::Value* AggrAlias::getLoadValue(llvm::LoadInst *LI)
{
    llvm::Value* load_value= LI->getPointerOperand();
    while(true)
    {
        if(llvm::LoadInst *LI = llvm::dyn_cast<llvm::LoadInst>(load_value))
        {
            load_value = LI->getPointerOperand();
        }
        if(llvm::isa<llvm::AllocaInst>(load_value) || llvm::isa<llvm::Argument>(load_value))
        {
            break;
        }
    }
    return load_value;
}
