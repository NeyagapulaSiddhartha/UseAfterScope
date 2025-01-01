add_llvm_library(scopePass MODULE scopePass.cpp
AliasAnalysis.cpp
SidAliasAnalysis.cpp
compare.cpp
${LLVM_MAIN_INCLUDE_DIR}/llvm/Transforms/Tools/AliasResultToString.cpp
${LLVM_MAIN_INCLUDE_DIR}/llvm/Transforms/Tools/EnumerateCallInst.cpp
${LLVM_MAIN_INCLUDE_DIR}/llvm/Transforms/Tools/FileInfo.cpp
${LLVM_MAIN_INCLUDE_DIR}/llvm/Transforms/Tools/FuncLocalLockCalls.cpp
${LLVM_MAIN_INCLUDE_DIR}/llvm/Transforms/Tools/IRtoModule.cpp
${LLVM_MAIN_INCLUDE_DIR}/llvm/Transforms/Tools/ItaniumDemangle.cpp
${LLVM_MAIN_INCLUDE_DIR}/llvm/Transforms/Tools/LockUnlockPairs.cpp
${LLVM_MAIN_INCLUDE_DIR}/llvm/Transforms/Tools/RemoveInst.cpp

ADDITIONAL_HEADER_DIRS
AliasAnalysis.h
${LLVM_MAIN_INCLUDE_DIR}/llvm/Transforms/Tools/EnumerateCallInst.h
)

