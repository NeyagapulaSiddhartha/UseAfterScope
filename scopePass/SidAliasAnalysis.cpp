#include "llvm/IR/Argument.h"
#include "llvm/Pass.h"
#include "llvm/IR/BasicBlock.h"
#include "llvm/IR/Function.h"
#include "llvm/IR/Instruction.h"
#include "llvm/IR/Instructions.h"
#include "llvm/IR/CFG.h"
#include "llvm/Support/Casting.h"
#include "llvm/Support/InstructionCost.h"
#include "llvm/Support/raw_ostream.h"
#include <map>
#include "llvm/IR/DebugInfoMetadata.h" // Add this include for DbgDeclareInst
#include <set>
#include<queue>
#include<algorithm>
#include <string>
#include <regex>
#include <iostream>
#include <vector>
#include "llvm/Pass.h"
#include "llvm/IR/Module.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/Support/FileSystem.h" // For llvm::sys::fs::F_RW
#include "llvm/IR/DebugInfo.h"
#include "llvm/IR/DebugLoc.h"
#include"SidAliasAnalysis.h"
using namespace llvm;



// struct alias_c : public FunctionPass {

  //  std::string alias_c::get_ret(Value* I) {
  //      std::string s;
  //      raw_string_ostream os(s);
  //      I->print(os);
  //      os.flush();
  //      std::string instructionSubstr = os.str();
  //      size_t equalPos = instructionSubstr.find('=');
  //      if (equalPos != std::string::npos) {
  //          std::string substr = instructionSubstr.substr(0, equalPos);
  //          return substr;
  //      } else {
  //          return "";
  //      }
  //  }


   std::string alias_c::get_ret(Value* II) {
//  errs()<<*M;
 if(isa<Argument>(II)){

 }
 else{
    auto  x = dyn_cast<Instruction>(II);
    auto F = x->getFunction();
    // errs()<<" got the function -------------------------"<<*F;
    // errs()<< " got the Instruction ((((((((((((((((((()))))))))))))))))))"<<*x<<"\n";
     for(auto &BB : *F)
        {
          for(auto &I : BB)
          {
            if(isa<llvm::DbgDeclareInst>(&I))
            {
              // errs()<<"the instruction is "<<I<<"\n";
              // errs()<<"the value is "<<*I.getOperand(0)<<"\n";
              if(dyn_cast<DbgDeclareInst>(&I)->getAddress()==II)
              {
                  auto strrr=dyn_cast<DbgDeclareInst>(&I)->getVariable()->getName().str();
                //   errs()<<"this is working "<<dyn_cast<DbgDeclareInst>(&I)->getVariable()->getName().str()<<"   \n";
                //  errs()<<" the string  \n";
                return strrr;
                }
  //           }
  //           else{
  //             errs()<<"the instruction is "<<I<<"\n";
            }
          }
        }


 }
// //  auto f = II->getB
    return "arg";
   
;      // for(Function &F : *M)
      // {
      //   for(auto &BB : F)
      //   {
      //     for(auto &I : BB)
      //     {
      //       // if(isa<llvm::DbgDeclareInst>(&I))
      //       // {
      //       //   // errs()<<"the instruction is "<<I<<"\n";
      //       //   // errs()<<"the value is "<<*I.getOperand(0)<<"\n";
      //       //   // if(dyn_cast<DbgDeclareInst>(&I)->getAddress()==II)
      //       //   // {
      //       //   //     // auto strrr=dyn_cast<DbgDeclareInst>(&I)->getVariable()->getName().str();
      //       //   //   //   errs()<<"this is working "<<dyn_cast<DbgDeclareInst>(&I)->getVariable()<<"   \n";
      //       //   //   //  errs()<<" the string  \n";
      //       //     return "sid";
      //       //     // }
      //       // }
      //       // else{
      //         errs()<<"the instruction is "<<I<<"\n";
      //       // }
      //     }
      //   }
      // }
   }

bool alias_c:: is_variable(Value * I)
{
  if(dyn_cast<AllocaInst>(I))
{  if(dyn_cast<AllocaInst>(I)->getAllocatedType()->getTypeID() ==15||dyn_cast<AllocaInst>(I)->getAllocatedType()->getTypeID() ==17)
  {
    return 1;
  }
  else 
  {
    return 0;
  }}
  else return 0;

}

std:: set  <   std::pair<Value*,Value *>> alias_c::Init(Function &F)
{
  std:: set<   std::pair<Value*,Value *>   > gmap;
  
  // errs()<<"the function name is "<<F.getName().str()<<"\n";
  for(auto &x : F.args()){

    all_variables.push_back(&x);
  }

    for (BasicBlock &BB : F)
    {
      
        for (Instruction &I : BB)
        {

          if(isa<llvm::StoreInst>(&I))
          {
            if(isa<llvm::Argument>(I.getOperand(0)))
            {

              // errs()<<"the store instruction is "<<*I.getOperand(0)<<"\n";
            }
            // errs()<<"the store instruction is "<<*I.getOperand(0)<<"\n";
          }
            if (AllocaInst *AI = dyn_cast<AllocaInst>(&I))
            {
                         if(AI->getAllocatedType()->getTypeID() ==15 || AI->getAllocatedType()->getTypeID() ==17)
                         {
                          // errs()<<*AI<<"\n";
                          // errs()<<"the allocated type is \n";
                          errs()<<AI->getAllocatedType()->getTypeID()<<"\n";

                               // B_map[&BB][&I]=&I;
                                //gmap[&I]=&I;
                                //errs()<<*AI<<"\n"; //////////printing 
                                gmap.insert(std::make_pair(&I,&I));
                                all_variables.push_back(&I);
                         }
                         else if(AI->getAllocatedType()->getTypeID() !=15  )
                         {
                              // errs()<<"allocas which dosent have iD as  15 "<<*AI<<"\n"; //////////printing
                              //gmap[&I]= NULL;
                              //gmap.insert(std::make_pair(&I,&I));
                              all_variables.push_back(&I);
                         }
            }
        }
    }


    
// }
return gmap;
}

std::vector<Value*> alias_c::getALLelements( std:: set<   std::pair<Value*,Value *>   > gmap )
{

return all_variables;
}

 std:: set<   std::pair<Value*,Value *>   > alias_c::cross(std::vector<Value*> v1,std::vector<Value*> v2,int null)
{
   std:: set<   std::pair<Value*,Value *>   > out;
   if(null==1)
   {
    for(auto &key :v1)
    {
      out.insert(std::make_pair(key,nullptr));
    }
   }
   else{
  for (auto & key : v1) 
  {
   for (auto & value : v2) 
  {
   //out[key]=value;

   out.insert(std::make_pair(key,value));
  }
  }
   }
  return out;
}

 std:: set<   std::pair<Value*,Value *>   > alias_c::mustkill(BasicBlock * BB, std :: vector < Value*> gen, std:: set<   std::pair<Value*,Value *>   > gmap)
{
  // errs()<<"------------calculating the kill set \n---------";
  
 std:: set<   std::pair<Value*,Value *>   > killinfo;

  if(gen.size()==1)
    {

             std::vector<Value*> v =getALLelements(gmap);
              killinfo = cross(gen , v);
                
              }
              else{
                killinfo.insert(std::make_pair(nullptr , nullptr));

              }

        
return killinfo;
}

std::vector<Value *>  alias_c::Gen (BasicBlock *BB,Value *ROperand,   std:: set<std::pair<Value*,Value *>> gmap)
{
// getting the operands of store 
  int x=0;
  Value * init_operand =ROperand;
  while(! (isa<llvm::AllocaInst>(ROperand) ||  isa<llvm::Argument>(ROperand)))  //// getting the depth of alloca inst 
  {
    // errs()<<" the back tracking of loads --------"<<*ROperand<<"\n";
    if(isa<llvm::Argument>(ROperand))
    {
      // errs()<<"the argument gotten in gen set is "<<*ROperand<<"\n";
    }

    ROperand=dyn_cast<Instruction>(ROperand)->getOperand(0);
        
    x++;
  }
    if(init_operand !=ROperand && dyn_cast<GetElementPtrInst>(init_operand) )
  {
    x=0;
  }

  // errs()<<x<<"xxxx"<<*ROperand<<"\n";
  std::vector<Value *> v1 ,v2;
   v1.push_back(ROperand);                // v1  stores the Aloca Inst 
  //                                   // After while v1 stores the actual Alloca

  while(x)                         ///  iterate through B_map and find tha actual variables defined 
  {  
      std::vector<Value *>v2;
      --x;
      int p=0;
      while(!v1.empty())
      
      {
        // errs()<<"v1 is is running for the "<<p++<<"time \n";
          Value * temp2 = v1.back();
          v1.pop_back();
      for (const auto& i : gmap) 
      {
          // errs()<<"debugging the gen set \n";
          // errs()<<*i.first<<"^^^^^^^^^^^^^^^^^^^^^^^^^^  "<<*i.second<<"\n";
        if (i.first == temp2 &&  i.first!=i.second) {
      //               // Store matching entry in the new map
      // errs()<<"after matching the allocas \t"<<*i.first<<"  "<<*i.second<<"\n";
                    v2.push_back(i.second);
      //           }
        }

      }
      }
      v1=v2;
 }
 
// for (auto x: v2){

//   errs()<<"the gen set is #################################################"<<*x<<"\n";
// }
  return v1;
}





std::vector<Value *> alias_c::Pointee(BasicBlock * BB,Value *ROperand,std:: set<   std::pair<Value*,Value *>   > gmap)
{
        int x=0;
        Value * init_operand =ROperand;
      while(!  (isa<llvm::AllocaInst>(ROperand) ||  isa<llvm::Argument>(ROperand)))  //// getting the depth of alloca inst 
      {

        ROperand= dyn_cast<Instruction>(ROperand)->getOperand(0);
        //errs()<<" the back tracking of loads --------"<<*ROperand<<"\n";
            
        x++;
      }
      if(init_operand !=ROperand && dyn_cast<GetElementPtrInst>(init_operand) )
      {
        x=0;
      }
      if(isa<llvm::Argument>(init_operand))
      {
        x=1;
      }

      std::vector<Value *> v1;
      v1.push_back(ROperand);  
    while(x)                         ///  iterate through B_map and find tha actual variables defined 
      { 
        std::vector<Value *> v2;
        --x;


        while(!v1.empty())
        
        {
          Value * temp2 = v1.back();
          v1.pop_back();

        for (const auto& i : gmap) 
        {

          if (i.first == temp2) {
        //               // Store matching entry in the new map
                      v2.push_back(i.second);
        //           }

          }

        }


        }
        
        v1=v2;
      
      }
      return v1;

    }


 std:: set<std::pair<Value*,Value *>> alias_c::minus( std:: set<std::pair<Value*,Value *>> gen , std:: set<std::pair<Value*,Value *>> kill)
 {
  std:: set <std::pair<Value*,Value*>>s1;
  std::set_difference(gen.begin(),gen.end(),kill.begin(),kill.end(),std::inserter(s1,s1.begin()));
  return s1;
 }

 
std:: set<std::pair<Value*,Value *>>  alias_c::uni( std:: set<std::pair<Value*,Value *>> a , std:: set<std::pair<Value*,Value *>> b)
 {
  std:: set <std::pair<Value*,Value*>>s1;
  std::set_union(a.begin(),a.end(),b.begin(),b.end(),std::inserter(s1,s1.begin()));
  return s1;
 }


bool alias_c:: processblock(BasicBlock *BB, node * root)
{
   int i=0;
 //errs()<<"-------------------processing new block------------------\n";

 int change =0;
  // std:: map<BasicBlock* , std:: set<std::make_pair<Value* ,Value*>>>B_map;
  std:: set< std::pair<Value*,Value *> >iin ;  ///////////////////calculate in set
    std:: set<std::pair<Value*,Value *>> gmap ;


    for(BasicBlock* pred : predecessors(BB))
    {
      iin = uni(iin,B_map[pred]);
    }


  gmap=iin; 

    if(BB==&BB->getParent()->getEntryBlock())
    {
      gmap=uni(gmap,root->params);

    }



    // for(auto cc : params[BB->getParent()])
    // {
    //   errs()<<"the params are \n";
    //   errs()<<*cc.first<<"  "<<*cc.second<<"\n";
    // }

  for (Value &I : *BB)
  {

        if(CallInst *ci = dyn_cast<CallInst>(&I))
        {
                    auto f= ci->getCalledFunction();
                
                  
                  if(!(f->isDeclaration() || f->isIntrinsic() || f->isDeclarationForLinker()))
                  {
                      // errs()<<"the call instruction is %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% \t"<<f->getName().str()<<"\n";
                        std::set<std::pair<Value*, Value*>> temp;
                        i=0;
                        for (auto &arg : f->args())
                        {
                              // errs()<< "the arg is \t"<<arg<<"\t"<<"the operand is \t"<<*ci->getArgOperand(i)<<"\n";
                            
                            std::vector<Value*> tgen = Gen(BB,ci->getOperand(i),gmap);
                            for(auto s : tgen)
                                {
                                    temp.insert(std::make_pair(&arg,s));
                                  
                                }
                                i++;
                          }
                            node * temproot;
                        for(auto x : root->succ){

                          if(x->I==ci || x->I == f){
                            temproot=x;
                          }
                        
                        }
                          temproot->params=uni (temproot->params,uni(gmap,temp));
                        // runOnFunction(*f);
                  }

                  else if(f->getName().str()=="pthread_create")
                  {
                      errs()<<"the pthread create is called \n";
                      std::set<std::pair<Value*, Value*>> temp;
                      i=0;
                    llvm::Function *f=dyn_cast<Function>(ci->getArgOperand(2));
                    // errs()<<"the function called by pthreads siiss  is \t"<<f->getName().str()<<"\n";
                    for (auto &arg : f->args())
                    {
                        if(i<3)
                        continue;

                          // errs()<< "the arg is \t"<<arg<<"\t"<<"the operand is \t"<<*ci->getArgOperand(3+i)<<"\n";

                          std::vector<Value*> tgen = Gen(BB,ci->getOperand(3+i),gmap); // handling only one parameter  , for multiple parameteres iterate through them and find all pts pairs 
                      for(auto s : tgen)
                          {

                              temp.insert(std::make_pair(&arg,s));
                            
                          }
                          i++;
                        }
                          node * temproot;
                        for(auto x : root->Thread){

                          if(x->I==ci || x->I == f){
                            temproot=x;
                          }
                        
                        }
                          temproot->params=uni (temproot->params,uni(gmap,temp));
                          // params[f ]=uni(gmap,temp);
                        // runOnFunction(*f);
                    }
                
                else{
                  // call_context.p(x);
                }
          }
        
    if(StoreInst *si = dyn_cast<StoreInst>(&I))
    {

          Value* OP1 =si->getOperand(0);
          Value* OP2 = si->getOperand(1);

        if(isa<ConstantPointerNull>(si->getOperand(0)))
        //errs()<<"this is the constant pointer null---------------------------- \t"<< *si->getOperand(0)<<"\n";
        {
            errs()<<"the store instruction in ConstantPointerNull is  "<<*si<<"\n"; 
            
              std :: vector< Value *> pointee ;
                std:: vector < Value *> gen = Gen(BB,OP2,gmap);

                std:: set<std::pair<Value*,Value *>> kill = mustkill(BB,gen,gmap);

                
                gmap =minus(gmap , kill);                   /////////// performing transfer function
                gmap = uni( gmap, cross(gen, pointee,1));
          }
          
        else if(si && (si->getOperand(0)->getType()->getTypeID()==15 || si->getOperand(0)->getType()->getTypeID()==17 )&& (si->getOperand(1)->getType()->getTypeID()==15 || si->getOperand(1)->getType()->getTypeID()==17 ))
        {  

          // errs()<<"the store instruction in else is  "<<*si<<"\n"; 
          i++;
        




            std:: vector < Value *> gen = Gen(BB,OP2,gmap); /////////////////// creating gen set 

    
            std :: vector< Value *> pointee = Pointee(BB,OP1,gmap);  ///////////////creating pointee set 




            std:: set<std::pair<Value*,Value *>> kill = mustkill(BB,gen,gmap);   // creating kill set 


              gmap =minus(gmap , kill);                   /////////// performing transfer function
              gmap = uni( gmap, cross(gen, pointee));

      }
      
      }
    }



     if(gmap!=B_map[BB])
   {
    change =1;

   }
B_map[BB]=gmap;

if(i==0 && Prev_B_map[BB]!=B_map[BB])
{
  Prev_B_map[BB]=B_map[BB];
  return 1;
}
return change ;

}


std::set<std::pair<Value*, Value*>> alias_c::kildal(Function &F,node *root)
{


   BasicBlock * entry =  &F.getEntryBlock();
  B_map[entry]  = Init(F);

  std::queue<BasicBlock*> worklist;
  std::set<std::pair<Value*, Value*>> final_result;
       worklist.push(entry);

       while (!worklist.empty())
       {
           BasicBlock* curr_node = worklist.front();
       
           int change = processblock(curr_node,root);
           worklist.pop();
           final_result = B_map[curr_node];
            if (change) {
               for (BasicBlock* Succ : successors(curr_node)) {

                 B_map[Succ]=B_map[curr_node];
                   worklist.push(Succ);
               }
           }
       }

return final_result;

}

BasicBlock * alias_c::getExitBlock(Function &F)
{
  for(BasicBlock &BB :F)
  {
    for (Instruction &I:BB )
    {
      if (ReturnInst *RI = dyn_cast<ReturnInst>(&I))
      {
        return &BB;

      }
    }
  }
}

  std::set<std::pair<Value*, Value*>> alias_c::runOnFunction(Function &F, node * root)  {

    if(F.isDeclaration() || F.isIntrinsic() || F.isDeclarationForLinker())
    {
      return {};
    }
    // write your code here
    std::set<std::pair<Value*, Value*>> final_list =kildal(F,root);
    BasicBlock* FB = getExitBlock(F);
  if(FB)
  {
    final_list=B_map[FB];
  }
  errs()<<"-------------------*****printing aliases in func **************-------------------\t"<<F.getName().str()<<"\n";

  //  for (const auto& i : final_list) {


  //   errs()<<*i.first<<*i.second<<" the key value pairs aree -------------------------- \n";

  //   errs()<<get_ret(i.first);
  //  }

 //printKeysWithSameValue(final_list);

   errs()<<"-------------------*****printing aliases in func **************-------------------\t"<<F.getName().str()<<"\n";

for (const auto& i : final_list) {

  if(is_variable(i.first))
  {
    errs()<<get_ret(i.first);
    errs()<<" = { ";
     
          errs()<<" ";
          
          
    for(const auto &j : final_list)
  {
    

   if(i.second==j.second && i.second!=nullptr)
   { 
        if(is_variable(i.first) && is_variable(j.first))
        { 
          errs()<<get_ret(j.first);errs()<<"  ,";
         
        }
     }
  }
  errs()<<" }\n";
  }
  }
errs()<<"-------------------*****fun aliasyes completed **************-------------------\n";
        return final_list;
      }
      

// //  // end of struct alias_c
// //   // end of anonymous namespace

// // char alias_c::ID = 0;
// // static RegisterPass<alias_c> X("alias_lib_given", "Alias Analysis Pass for Assignment",
// //                              false /* Only looks at CFG */,
// //                              false /* Analysis Pass */);

                            