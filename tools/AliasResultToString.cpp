#include "llvm/Analysis/AliasAnalysis.h"
#include "llvm/Support/raw_ostream.h"

const char *AAResToString(llvm::AliasResult res) {
    switch (res) {
    case llvm::AliasResult::NoAlias:
        return "No Alias";
    case llvm::AliasResult::MayAlias:
        return "May Alias";
    case llvm::AliasResult::PartialAlias:
        return "Partial Alias";
    case llvm::AliasResult::MustAlias:
        return "Must Alias";
    default:
        llvm::errs() << "Warning: in AAResToString, unknown alias result encountered\n";
        return "Unknown alias result";
    }
}
