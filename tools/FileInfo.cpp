/**
 * This file is distributed under the University of Illinois Open Source
 * License. See LICENSE for details.
 *
 * \file FileInfo.h
 * \author Markus Kusano
 * 2013-04-03
 *
 * Helper utility to obtain debug filename and linenumber information of an
 * instruction
 */
#include "FileInfo.h"
#include "llvm/Support/raw_ostream.h"
#include <climits>

StringRef getDebugFilename(Instruction *inst) {
    MDNode *metaNode;
    metaNode = inst->getMetadata("dbg");

    if (metaNode) {
        // DILocation Loc(metaNode);

        // if (!Loc.Verify())
        //   return "";

        if (auto *Loc = llvm::dyn_cast<llvm::DILocation>(metaNode)) {
            StringRef File = Loc->getFilename();
            unsigned Line = Loc->getLine();
            llvm::errs() << File << '\t' << Line << '\n';
            return File;
        }

        // return Loc.getFilename();
    }
    return "";
}

unsigned getDebugLineNum(Instruction *inst) {

    MDNode *metaNode;
    metaNode = inst->getMetadata("dbg");

    if (metaNode) {
        if (auto *Loc = llvm::dyn_cast<llvm::DILocation>(metaNode)) {
            StringRef File = Loc->getFilename();
            unsigned Line = Loc->getLine();
            llvm::errs() << File << '\t' << Line << '\n';
            return Line;
        }
        // DILocation Loc(metaNode);
        // return Loc.getLineNumber();
    }
    return UINT_MAX;
}
