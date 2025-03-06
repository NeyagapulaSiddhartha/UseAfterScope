//===- svf-ex.cpp -- A driver example of SVF-------------------------------------//
//
//                     SVF: Static Value-Flow Analysis
//
// Copyright (C) <2013->  <Yulei Sui>
//

// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.

// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.

// You should have received a copy of the GNU General Public License
// along with this program.  If not, see <http://www.gnu.org/licenses/>.
//
//===-----------------------------------------------------------------------===//

/*
 // A driver program of SVF including usages of SVF APIs
 //
 // Author: Yulei Sui,
 */

#include "AE/Svfexe/SVFIR2AbsState.h"
#include "Graphs/SVFG.h"
#include "SVF-LLVM/LLVMUtil.h"
#include "SVF-LLVM/SVFIRBuilder.h"
#include "Util/CommandLine.h"
#include "Util/Options.h"
#include "WPA/Andersen.h"
#include <iostream>
#include <execinfo.h>
#include <cstdlib>
#include "/home/cs23mtech12010/CCM/SVF/svf/include/MTA/MTA.h"
#include "/home/cs23mtech12010/CCM/SVF/svf/include/MTA/FSMPTA.h"
using namespace llvm;
using namespace std;
using namespace SVF;



FSMPTA* fsmpta;
MHP *mhp;

void dumpTopLevelPtsTo( SVFIR* pag)
{

    std::cout<<" ^^^^^^^^111111^^^^^^^own^^^^^&&&&&&&&&&Dumping Top Level Points-To Information\n";
    for (OrderedNodeSet::iterator nIter = fsmpta->getAllValidPtrs().begin();
            nIter != fsmpta->getAllValidPtrs().end(); ++nIter)
    {
        const PAGNode* node = fsmpta->getPAG()->getGNode(*nIter);
        if(node->hasValue())
      { 
        const Value *pValue = LLVMModuleSet::getLLVMModuleSet()->getLLVMValue(node->getValue());
        if(dyn_cast<llvm::StoreInst>(pValue) || dyn_cast<llvm::LoadInst>(pValue))
        
    {
        if (fsmpta->getPAG()->isValidTopLevelPtr(node))
        {
            const PointsTo& pts = fsmpta->getPts(node->getId());

            const Value *ptoValue = LLVMModuleSet::getLLVMModuleSet()->getLLVMValue(pag->getGNode(node->getId())->getValue());
            auto v =LLVMModuleSet::getLLVMModuleSet()->getSVFValue(ptoValue);
        if(mhp->hasThreadStmtSet(SVFUtil::dyn_cast<SVFInstruction>(v)))
         {
            const MHP::CxtThreadStmtSet& tsSet = mhp->getThreadStmtSet(SVFUtil::dyn_cast<SVFInstruction>(v));
            outs()<<" thread ids ----\n";
            for (const CxtThreadStmt& cts : tsSet)
            {
               outs()<<" the thread id " <<cts.getTid()<< "\t";
                // const CallStrCxt& curCxt = cts.getContext();
            }

        }
            outs() << "\nNodeID " <<  pag->getGNode(node->getId())->toString()<< " ";

            if (pts.empty())
            {
                outs() << "\t\tPointsTo: {empty}\n\n";
            }
            else
            {
                outs() << "  PointsTo: { ";

                int k =0;
                for (PointsTo::iterator it = pts.begin(), eit = pts.end();
                it != eit; ++it)
                {
                        k++;
                }
                for (PointsTo::iterator it = pts.begin(), eit = pts.end(); it != eit; ++it)
                {

                        // const PAGNode* node = pag->getGNode(*it)->getValueName();
                        const Value *ptoValue = LLVMModuleSet::getLLVMModuleSet()->getLLVMValue(pag->getGNode(*it)->getValue());
                        auto v =LLVMModuleSet::getLLVMModuleSet()->getSVFValue(ptoValue);
                        if(mhp->hasThreadStmtSet(SVFUtil::dyn_cast<SVFInstruction>(v)))
                     {                        
                        const MHP::CxtThreadStmtSet& tsSet = mhp->getThreadStmtSet(SVFUtil::dyn_cast<SVFInstruction>(v));
                        outs()<<" thread ids ----\n";
                        for (const CxtThreadStmt& cts : tsSet)
                        {
                           outs()<<" the thread id " <<cts.getTid()<< "\t";
                            // const CallStrCxt& curCxt = cts.getContext();
                        }
                    }
                        outs()<<" \n";
                        outs() <<" " << pag->getGNode(*it)->toString() << " ";
              
                    // else
                    // {
                    //     outs()<< *it<<" ";
                    // }
                }
                outs() << "}\n\n";
            }
        }
    }
}
    }

    outs().flush();
}
std::vector<SVF::CxtStmt> cxtStmtList;

void handleIntra(const CxtStmt& cts)
{

    const SVFInstruction* curInst = cts.getStmt();
    const CallStrCxt& curCxt = cts.getContext();

    const std::vector<const SVFInstruction*> & nextInsts = curInst->getSuccInstructions();
    for (const auto& ni: nextInsts)
    {
        CxtStmt newCts(curCxt, ni);
        cxtStmtList.push_back(newCts);
    }
}

int main(int argc, char ** argv)
{

    std::vector<std::string> moduleNameVec;
    moduleNameVec = OptionBase::parseOptions( argc, argv, "Whole Program Points-to Analysis", "[options] <input-bitcode...>");

    if (Options::WriteAnder() == "ir_annotator")
    {
        LLVMModuleSet::preProcessBCs(moduleNameVec);
    }

    SVFModule* svfModule = LLVMModuleSet::buildSVFModule(moduleNameVec);

    /// Build Program Assignment Graph (SVFIR)
    SVFIRBuilder builder(svfModule);
    SVFIR* pag = builder.build();




    MTA mta;
   mta.runOnModule(pag);
    mhp=mta.getMHP();

    FSMPTA* fsmpta1 = FSMPTA::createFSMPTA(svfModule, mta.getMHP(), mta.getLockAnalysis());
    fsmpta1->initialize(pag->getModule());
    fsmpta1->analyze();
    fsmpta= fsmpta1;

    // SVFGBuilder svfBuilder;
    // SVFG* svfg = svfBuilder.buildFullSVFG(fsmpta);

    std::cout<<" custom printing of the points to results ----------\n";
    dumpTopLevelPtsTo(pag);
    //fsmpta->finalize();

    TCT *tct = mhp->getTCT();
    ThreadCallGraph * tcg = mhp->getThreadCallGraph();
    ForkJoinAnalysis* fja= mhp->getfja();



    std::cout<<"******* Join relations between threads *********"<<"\n";
    for (const std::pair<const NodeID, TCTNode*>& tpair : *tct)
    {

        const CxtThread& ct = tpair.second->getCxtThread();
        NodeID rootTid = tpair.first;
        const SVFFunction* routine = tct->getStartRoutineOfCxtThread(ct);

        std::cout<<" In the thread  t"<<rootTid<<"\n";
        // LLVMModuleSet::getLLVMModuleSet()->getSVFValue(I1)
        // const llvm::Function *func = SVFUtil::dyn_cast<Function>(LLVMModuleSet::getLLVMModuleSet()->getLLVMValue(routine));

        const SVF::SVFInstruction* I = routine->getEntryBlock()->front();
        CxtStmt cs(ct.getContext(), I);
      
      

    
        cxtStmtList.push_back(cs);
        while(!cxtStmtList.empty()){
           

            CxtStmt cts = cxtStmtList.back();
            cxtStmtList.pop_back();
            const SVFInstruction* inst = cts.getStmt();
            // std::cout<<" current statement is "<<inst->toString()<<"\n";
         
             if (SVFUtil::isCallSite(inst) && !SVFUtil::isExtCall(inst))
            {
                 
                const SVFInstruction* call = cts.getStmt();
                const CallStrCxt& curCxt = cts.getContext();
                CallICFGNode* cbn = mhp->getCBN(call);
                if (tct->getThreadCallGraph()->hasCallGraphEdge(cbn))
                {
                    for (PTACallGraph::CallGraphEdgeSet::const_iterator cgIt = tcg->getCallEdgeBegin(cbn),
                            ecgIt = tcg->getCallEdgeEnd(cbn);
                            cgIt != ecgIt; ++cgIt)
                    {
                        const SVFFunction* svfcallee = (*cgIt)->getDstNode()->getFunction();
                        if ( SVF::SVFUtil::isExtCall(svfcallee))
                            continue;
                        CallStrCxt newCxt = curCxt;
                        fja->pushCxt(newCxt, call, svfcallee);
                        const SVFInstruction* svfEntryInst = svfcallee->getEntryBlock()->front();
                        CxtStmt newCts(newCxt , svfEntryInst);
                        //std::cout<<"-------------- found a function call  0000\n--------- "<<inst->toString();
                        cxtStmtList.push_back(newCts);
                     
                    }
                }

            }

             if (fja->isTDJoin(inst))
            {
                // std::cout<<" the join statement is "<<inst->toString()<<"\n";
                NodeBS joinedTids = fja->getDirectlyJoinedTid(cts);

                for(auto id : joinedTids)
                {
                    llvm::errs()<<" the joined thread id is "<<id<<"\n";
                }
                handleIntra(cts);
            }
            else{
                handleIntra(cts);
            }


         }

        }





    // // clean up memory
    // delete vfg;
    FSMPTA::releaseFSMPTA();
    // AndersenWaveDiff::releaseAndersenWaveDiff();
    // SVFIR::releaseSVFIR();

    // LLVMModuleSet::getLLVMModuleSet()->dumpModulesToFile(".svf.bc");
    // SVF::LLVMModuleSet::releaseLLVMModuleSet();
    // llvm::llvm_shutdown();
    return 0;
}

