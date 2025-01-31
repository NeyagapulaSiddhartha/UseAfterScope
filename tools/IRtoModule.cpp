/**
 * This file is distributed under the University of Illinois Open Source
 * License. See LICENSE for details.
 *
 * \file IRtoModule.cpp
 * \author Markus Kusano
 *
 * Simply takes an std::string to a filename and returns a Module* to the
 * parsed code.
 *
 * It appears that the extra passed SMDiagnostic parameter is simply extra
 * information if an error occurs. This information is printed out via stderr.
 */

#include "llvm/IRReader/IRReader.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/Support/Error.h"
#include "llvm/Support/SourceMgr.h"
#include "llvm/IR/LLVMContext.h"
#include "llvm/ADT/StringRef.h"
#include "llvm/ExecutionEngine/Orc/ThreadSafeModule.h"
using namespace::llvm;

/// Attempts to parse filename using context. progName is the currently
/// executing program name. This is used for outputting error messages.
/// 
/// \param filename LLVM IR file to parse
/// \param context LLVM Context to parse with
/// \param progName currently executing program name. Used for error reporting
/// \return Returns a parsed LLVM module or NULL on failure.
std::unique_ptr<Module> IRtoModule(std::string filename, LLVMContext &context, char* progName) {
    SMDiagnostic Err;
    auto Mod = llvm::parseIRFile(filename, Err, context);

    if (!Mod) {
	Err.print(progName, errs());
	return NULL;
    }

    return Mod;
}
