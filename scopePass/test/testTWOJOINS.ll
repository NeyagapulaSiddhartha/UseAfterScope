; ModuleID = '/home/cs23mtech12010/CCM/CCMutator/llvm-project/llvm/lib/Transforms/scopePass/test/testTWOJOINS.cpp'
source_filename = "/home/cs23mtech12010/CCM/CCMutator/llvm-project/llvm/lib/Transforms/scopePass/test/testTWOJOINS.cpp"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@thread1 = dso_local global i64 0, align 8, !dbg !0
@thread2 = dso_local global i64 0, align 8, !dbg !5
@.str = private unnamed_addr constant [26 x i8] c"Hello from Thread 2! ID:\0A\00", align 1, !dbg !11

; Function Attrs: mustprogress noinline optnone uwtable
define dso_local noundef ptr @_Z15threadFunction2Pv(ptr noundef %0) #0 !dbg !271 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  call void @llvm.dbg.declare(metadata ptr %2, metadata !275, metadata !DIExpression()), !dbg !276
  %3 = call i32 (ptr, ...) @printf(ptr noundef @.str), !dbg !277
  ret ptr null, !dbg !278
}

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

declare i32 @printf(ptr noundef, ...) #2

; Function Attrs: mustprogress noinline nounwind optnone uwtable
define dso_local void @_Z4fun4Pi(ptr noundef %0) #3 !dbg !279 {
  %2 = alloca ptr, align 8
  %3 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  call void @llvm.dbg.declare(metadata ptr %2, metadata !283, metadata !DIExpression()), !dbg !284
  call void @llvm.dbg.declare(metadata ptr %3, metadata !285, metadata !DIExpression()), !dbg !286
  %4 = load ptr, ptr %2, align 8, !dbg !287
  store ptr %4, ptr %3, align 8, !dbg !288
  ret void, !dbg !289
}

; Function Attrs: mustprogress noinline nounwind optnone uwtable
define dso_local void @_Z4fun3PPi(ptr noundef %0) #3 !dbg !290 {
  %2 = alloca ptr, align 8
  %3 = alloca ptr, align 8
  %4 = alloca i64, align 8
  store ptr %0, ptr %2, align 8
  call void @llvm.dbg.declare(metadata ptr %2, metadata !294, metadata !DIExpression()), !dbg !295
  call void @llvm.dbg.declare(metadata ptr %3, metadata !296, metadata !DIExpression()), !dbg !297
  %5 = load ptr, ptr %2, align 8, !dbg !298
  %6 = load ptr, ptr %5, align 8, !dbg !299
  store ptr %6, ptr %3, align 8, !dbg !300
  call void @llvm.dbg.declare(metadata ptr %4, metadata !301, metadata !DIExpression()), !dbg !302
  %7 = load ptr, ptr %2, align 8, !dbg !303
  %8 = load ptr, ptr %7, align 8, !dbg !304
  call void @_Z4fun4Pi(ptr noundef %8), !dbg !305
  ret void, !dbg !306
}

; Function Attrs: mustprogress noinline nounwind optnone uwtable
define dso_local void @_Z4fun2PPi(ptr noundef %0) #3 !dbg !307 {
  %2 = alloca ptr, align 8
  %3 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  call void @llvm.dbg.declare(metadata ptr %2, metadata !308, metadata !DIExpression()), !dbg !309
  call void @llvm.dbg.declare(metadata ptr %3, metadata !310, metadata !DIExpression()), !dbg !311
  %4 = load ptr, ptr %2, align 8, !dbg !312
  call void @_Z4fun3PPi(ptr noundef %4), !dbg !313
  %5 = load ptr, ptr %2, align 8, !dbg !314
  %6 = load ptr, ptr %5, align 8, !dbg !315
  store ptr %6, ptr %3, align 8, !dbg !316
  %7 = load ptr, ptr %2, align 8, !dbg !317
  call void @_Z4fun3PPi(ptr noundef %7), !dbg !318
  ret void, !dbg !319
}

; Function Attrs: mustprogress noinline nounwind optnone uwtable
define dso_local void @_Z3funPi(ptr noundef %0) #3 !dbg !320 {
  %2 = alloca ptr, align 8
  %3 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  call void @llvm.dbg.declare(metadata ptr %2, metadata !321, metadata !DIExpression()), !dbg !322
  call void @llvm.dbg.declare(metadata ptr %3, metadata !323, metadata !DIExpression()), !dbg !324
  %4 = load ptr, ptr %2, align 8, !dbg !325
  store ptr %4, ptr %3, align 8, !dbg !326
  call void @_Z4fun2PPi(ptr noundef %3), !dbg !327
  ret void, !dbg !328
}

; Function Attrs: mustprogress noinline norecurse nounwind optnone uwtable
define dso_local noundef i32 @main() #4 !dbg !329 {
  %1 = alloca i32, align 4
  call void @llvm.dbg.declare(metadata ptr %1, metadata !330, metadata !DIExpression()), !dbg !331
  store i32 18, ptr %1, align 4, !dbg !331
  call void @_Z3funPi(ptr noundef %1), !dbg !332
  ret i32 0, !dbg !333
}

attributes #0 = { mustprogress noinline optnone uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #2 = { "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #3 = { mustprogress noinline nounwind optnone uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #4 = { mustprogress noinline norecurse nounwind optnone uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }

!llvm.dbg.cu = !{!2}
!llvm.module.flags = !{!263, !264, !265, !266, !267, !268, !269}
!llvm.ident = !{!270}

!0 = !DIGlobalVariableExpression(var: !1, expr: !DIExpression())
!1 = distinct !DIGlobalVariable(name: "thread1", scope: !2, file: !7, line: 4, type: !8, isLocal: false, isDefinition: true)
!2 = distinct !DICompileUnit(language: DW_LANG_C_plus_plus_14, file: !3, producer: "clang version 17.0.0 (https://github.com/llvm/llvm-project.git 88bf774c565080e30e0a073676c316ab175303af)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, globals: !4, imports: !18, splitDebugInlining: false, nameTableKind: None)
!3 = !DIFile(filename: "/home/cs23mtech12010/CCM/CCMutator/llvm-project/llvm/lib/Transforms/scopePass/test/testTWOJOINS.cpp", directory: "/home/cs23mtech12010/CCM/CCMutator/llvm-project/build", checksumkind: CSK_MD5, checksum: "3560e2a66f2e8a4a8f8413afc9200a41")
!4 = !{!0, !5, !11}
!5 = !DIGlobalVariableExpression(var: !6, expr: !DIExpression())
!6 = distinct !DIGlobalVariable(name: "thread2", scope: !2, file: !7, line: 4, type: !8, isLocal: false, isDefinition: true)
!7 = !DIFile(filename: "llvm/lib/Transforms/scopePass/test/testTWOJOINS.cpp", directory: "/home/cs23mtech12010/CCM/CCMutator/llvm-project", checksumkind: CSK_MD5, checksum: "3560e2a66f2e8a4a8f8413afc9200a41")
!8 = !DIDerivedType(tag: DW_TAG_typedef, name: "pthread_t", file: !9, line: 27, baseType: !10)
!9 = !DIFile(filename: "/usr/include/x86_64-linux-gnu/bits/pthreadtypes.h", directory: "", checksumkind: CSK_MD5, checksum: "2d764266ce95ab26d4a4767c2ec78176")
!10 = !DIBasicType(name: "unsigned long", size: 64, encoding: DW_ATE_unsigned)
!11 = !DIGlobalVariableExpression(var: !12, expr: !DIExpression())
!12 = distinct !DIGlobalVariable(scope: null, file: !7, line: 6, type: !13, isLocal: true, isDefinition: true)
!13 = !DICompositeType(tag: DW_TAG_array_type, baseType: !14, size: 208, elements: !16)
!14 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !15)
!15 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!16 = !{!17}
!17 = !DISubrange(count: 26)
!18 = !{!19, !27, !31, !38, !42, !49, !54, !56, !62, !66, !70, !80, !82, !86, !90, !94, !99, !103, !107, !111, !115, !123, !127, !131, !133, !137, !141, !146, !152, !156, !160, !162, !170, !174, !182, !184, !188, !192, !196, !200, !205, !210, !215, !216, !217, !218, !220, !221, !222, !223, !224, !225, !226, !228, !229, !230, !231, !232, !233, !234, !239, !240, !241, !242, !243, !244, !245, !246, !247, !248, !249, !250, !251, !252, !253, !254, !255, !256, !257, !258, !259, !260, !261, !262}
!19 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !20, entity: !21, file: !26, line: 52)
!20 = !DINamespace(name: "std", scope: null)
!21 = !DISubprogram(name: "abs", scope: !22, file: !22, line: 840, type: !23, flags: DIFlagPrototyped, spFlags: 0)
!22 = !DIFile(filename: "/usr/include/stdlib.h", directory: "", checksumkind: CSK_MD5, checksum: "f0db66726d35051e5af2525f5b33bd81")
!23 = !DISubroutineType(types: !24)
!24 = !{!25, !25}
!25 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!26 = !DIFile(filename: "/usr/lib/gcc/x86_64-linux-gnu/9/../../../../include/c++/9/bits/std_abs.h", directory: "")
!27 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !20, entity: !28, file: !30, line: 127)
!28 = !DIDerivedType(tag: DW_TAG_typedef, name: "div_t", file: !22, line: 62, baseType: !29)
!29 = !DICompositeType(tag: DW_TAG_structure_type, file: !22, line: 58, size: 64, flags: DIFlagFwdDecl, identifier: "_ZTS5div_t")
!30 = !DIFile(filename: "/usr/lib/gcc/x86_64-linux-gnu/9/../../../../include/c++/9/cstdlib", directory: "")
!31 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !20, entity: !32, file: !30, line: 128)
!32 = !DIDerivedType(tag: DW_TAG_typedef, name: "ldiv_t", file: !22, line: 70, baseType: !33)
!33 = distinct !DICompositeType(tag: DW_TAG_structure_type, file: !22, line: 66, size: 128, flags: DIFlagTypePassByValue, elements: !34, identifier: "_ZTS6ldiv_t")
!34 = !{!35, !37}
!35 = !DIDerivedType(tag: DW_TAG_member, name: "quot", scope: !33, file: !22, line: 68, baseType: !36, size: 64)
!36 = !DIBasicType(name: "long", size: 64, encoding: DW_ATE_signed)
!37 = !DIDerivedType(tag: DW_TAG_member, name: "rem", scope: !33, file: !22, line: 69, baseType: !36, size: 64, offset: 64)
!38 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !20, entity: !39, file: !30, line: 130)
!39 = !DISubprogram(name: "abort", scope: !22, file: !22, line: 591, type: !40, flags: DIFlagPrototyped | DIFlagNoReturn, spFlags: 0)
!40 = !DISubroutineType(types: !41)
!41 = !{null}
!42 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !20, entity: !43, file: !30, line: 132)
!43 = !DISubprogram(name: "aligned_alloc", scope: !22, file: !22, line: 586, type: !44, flags: DIFlagPrototyped, spFlags: 0)
!44 = !DISubroutineType(types: !45)
!45 = !{!46, !47, !47}
!46 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: null, size: 64)
!47 = !DIDerivedType(tag: DW_TAG_typedef, name: "size_t", file: !48, line: 46, baseType: !10)
!48 = !DIFile(filename: "lib/clang/17/include/stddef.h", directory: "/home/cs23mtech12010/CCM/CCMutator/llvm-project/build", checksumkind: CSK_MD5, checksum: "d1776268f398bd1ca997c840ad581432")
!49 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !20, entity: !50, file: !30, line: 134)
!50 = !DISubprogram(name: "atexit", scope: !22, file: !22, line: 595, type: !51, flags: DIFlagPrototyped, spFlags: 0)
!51 = !DISubroutineType(types: !52)
!52 = !{!25, !53}
!53 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !40, size: 64)
!54 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !20, entity: !55, file: !30, line: 137)
!55 = !DISubprogram(name: "at_quick_exit", scope: !22, file: !22, line: 600, type: !51, flags: DIFlagPrototyped, spFlags: 0)
!56 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !20, entity: !57, file: !30, line: 140)
!57 = !DISubprogram(name: "atof", scope: !22, file: !22, line: 101, type: !58, flags: DIFlagPrototyped, spFlags: 0)
!58 = !DISubroutineType(types: !59)
!59 = !{!60, !61}
!60 = !DIBasicType(name: "double", size: 64, encoding: DW_ATE_float)
!61 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !14, size: 64)
!62 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !20, entity: !63, file: !30, line: 141)
!63 = !DISubprogram(name: "atoi", scope: !22, file: !22, line: 104, type: !64, flags: DIFlagPrototyped, spFlags: 0)
!64 = !DISubroutineType(types: !65)
!65 = !{!25, !61}
!66 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !20, entity: !67, file: !30, line: 142)
!67 = !DISubprogram(name: "atol", scope: !22, file: !22, line: 107, type: !68, flags: DIFlagPrototyped, spFlags: 0)
!68 = !DISubroutineType(types: !69)
!69 = !{!36, !61}
!70 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !20, entity: !71, file: !30, line: 143)
!71 = !DISubprogram(name: "bsearch", scope: !22, file: !22, line: 820, type: !72, flags: DIFlagPrototyped, spFlags: 0)
!72 = !DISubroutineType(types: !73)
!73 = !{!46, !74, !74, !47, !47, !76}
!74 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !75, size: 64)
!75 = !DIDerivedType(tag: DW_TAG_const_type, baseType: null)
!76 = !DIDerivedType(tag: DW_TAG_typedef, name: "__compar_fn_t", file: !22, line: 808, baseType: !77)
!77 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !78, size: 64)
!78 = !DISubroutineType(types: !79)
!79 = !{!25, !74, !74}
!80 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !20, entity: !81, file: !30, line: 144)
!81 = !DISubprogram(name: "calloc", scope: !22, file: !22, line: 542, type: !44, flags: DIFlagPrototyped, spFlags: 0)
!82 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !20, entity: !83, file: !30, line: 145)
!83 = !DISubprogram(name: "div", scope: !22, file: !22, line: 852, type: !84, flags: DIFlagPrototyped, spFlags: 0)
!84 = !DISubroutineType(types: !85)
!85 = !{!28, !25, !25}
!86 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !20, entity: !87, file: !30, line: 146)
!87 = !DISubprogram(name: "exit", scope: !22, file: !22, line: 617, type: !88, flags: DIFlagPrototyped | DIFlagNoReturn, spFlags: 0)
!88 = !DISubroutineType(types: !89)
!89 = !{null, !25}
!90 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !20, entity: !91, file: !30, line: 147)
!91 = !DISubprogram(name: "free", scope: !22, file: !22, line: 565, type: !92, flags: DIFlagPrototyped, spFlags: 0)
!92 = !DISubroutineType(types: !93)
!93 = !{null, !46}
!94 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !20, entity: !95, file: !30, line: 148)
!95 = !DISubprogram(name: "getenv", scope: !22, file: !22, line: 634, type: !96, flags: DIFlagPrototyped, spFlags: 0)
!96 = !DISubroutineType(types: !97)
!97 = !{!98, !61}
!98 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !15, size: 64)
!99 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !20, entity: !100, file: !30, line: 149)
!100 = !DISubprogram(name: "labs", scope: !22, file: !22, line: 841, type: !101, flags: DIFlagPrototyped, spFlags: 0)
!101 = !DISubroutineType(types: !102)
!102 = !{!36, !36}
!103 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !20, entity: !104, file: !30, line: 150)
!104 = !DISubprogram(name: "ldiv", scope: !22, file: !22, line: 854, type: !105, flags: DIFlagPrototyped, spFlags: 0)
!105 = !DISubroutineType(types: !106)
!106 = !{!32, !36, !36}
!107 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !20, entity: !108, file: !30, line: 151)
!108 = !DISubprogram(name: "malloc", scope: !22, file: !22, line: 539, type: !109, flags: DIFlagPrototyped, spFlags: 0)
!109 = !DISubroutineType(types: !110)
!110 = !{!46, !47}
!111 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !20, entity: !112, file: !30, line: 153)
!112 = !DISubprogram(name: "mblen", scope: !22, file: !22, line: 922, type: !113, flags: DIFlagPrototyped, spFlags: 0)
!113 = !DISubroutineType(types: !114)
!114 = !{!25, !61, !47}
!115 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !20, entity: !116, file: !30, line: 154)
!116 = !DISubprogram(name: "mbstowcs", scope: !22, file: !22, line: 933, type: !117, flags: DIFlagPrototyped, spFlags: 0)
!117 = !DISubroutineType(types: !118)
!118 = !{!47, !119, !122, !47}
!119 = !DIDerivedType(tag: DW_TAG_restrict_type, baseType: !120)
!120 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !121, size: 64)
!121 = !DIBasicType(name: "wchar_t", size: 32, encoding: DW_ATE_signed)
!122 = !DIDerivedType(tag: DW_TAG_restrict_type, baseType: !61)
!123 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !20, entity: !124, file: !30, line: 155)
!124 = !DISubprogram(name: "mbtowc", scope: !22, file: !22, line: 925, type: !125, flags: DIFlagPrototyped, spFlags: 0)
!125 = !DISubroutineType(types: !126)
!126 = !{!25, !119, !122, !47}
!127 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !20, entity: !128, file: !30, line: 157)
!128 = !DISubprogram(name: "qsort", scope: !22, file: !22, line: 830, type: !129, flags: DIFlagPrototyped, spFlags: 0)
!129 = !DISubroutineType(types: !130)
!130 = !{null, !46, !47, !47, !76}
!131 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !20, entity: !132, file: !30, line: 160)
!132 = !DISubprogram(name: "quick_exit", scope: !22, file: !22, line: 623, type: !88, flags: DIFlagPrototyped | DIFlagNoReturn, spFlags: 0)
!133 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !20, entity: !134, file: !30, line: 163)
!134 = !DISubprogram(name: "rand", scope: !22, file: !22, line: 453, type: !135, flags: DIFlagPrototyped, spFlags: 0)
!135 = !DISubroutineType(types: !136)
!136 = !{!25}
!137 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !20, entity: !138, file: !30, line: 164)
!138 = !DISubprogram(name: "realloc", scope: !22, file: !22, line: 550, type: !139, flags: DIFlagPrototyped, spFlags: 0)
!139 = !DISubroutineType(types: !140)
!140 = !{!46, !46, !47}
!141 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !20, entity: !142, file: !30, line: 165)
!142 = !DISubprogram(name: "srand", scope: !22, file: !22, line: 455, type: !143, flags: DIFlagPrototyped, spFlags: 0)
!143 = !DISubroutineType(types: !144)
!144 = !{null, !145}
!145 = !DIBasicType(name: "unsigned int", size: 32, encoding: DW_ATE_unsigned)
!146 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !20, entity: !147, file: !30, line: 166)
!147 = !DISubprogram(name: "strtod", scope: !22, file: !22, line: 117, type: !148, flags: DIFlagPrototyped, spFlags: 0)
!148 = !DISubroutineType(types: !149)
!149 = !{!60, !122, !150}
!150 = !DIDerivedType(tag: DW_TAG_restrict_type, baseType: !151)
!151 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !98, size: 64)
!152 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !20, entity: !153, file: !30, line: 167)
!153 = !DISubprogram(name: "strtol", scope: !22, file: !22, line: 176, type: !154, flags: DIFlagPrototyped, spFlags: 0)
!154 = !DISubroutineType(types: !155)
!155 = !{!36, !122, !150, !25}
!156 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !20, entity: !157, file: !30, line: 168)
!157 = !DISubprogram(name: "strtoul", scope: !22, file: !22, line: 180, type: !158, flags: DIFlagPrototyped, spFlags: 0)
!158 = !DISubroutineType(types: !159)
!159 = !{!10, !122, !150, !25}
!160 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !20, entity: !161, file: !30, line: 169)
!161 = !DISubprogram(name: "system", scope: !22, file: !22, line: 784, type: !64, flags: DIFlagPrototyped, spFlags: 0)
!162 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !20, entity: !163, file: !30, line: 171)
!163 = !DISubprogram(name: "wcstombs", scope: !22, file: !22, line: 936, type: !164, flags: DIFlagPrototyped, spFlags: 0)
!164 = !DISubroutineType(types: !165)
!165 = !{!47, !166, !167, !47}
!166 = !DIDerivedType(tag: DW_TAG_restrict_type, baseType: !98)
!167 = !DIDerivedType(tag: DW_TAG_restrict_type, baseType: !168)
!168 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !169, size: 64)
!169 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !121)
!170 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !20, entity: !171, file: !30, line: 172)
!171 = !DISubprogram(name: "wctomb", scope: !22, file: !22, line: 929, type: !172, flags: DIFlagPrototyped, spFlags: 0)
!172 = !DISubroutineType(types: !173)
!173 = !{!25, !98, !121}
!174 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !175, entity: !176, file: !30, line: 200)
!175 = !DINamespace(name: "__gnu_cxx", scope: null)
!176 = !DIDerivedType(tag: DW_TAG_typedef, name: "lldiv_t", file: !22, line: 80, baseType: !177)
!177 = distinct !DICompositeType(tag: DW_TAG_structure_type, file: !22, line: 76, size: 128, flags: DIFlagTypePassByValue, elements: !178, identifier: "_ZTS7lldiv_t")
!178 = !{!179, !181}
!179 = !DIDerivedType(tag: DW_TAG_member, name: "quot", scope: !177, file: !22, line: 78, baseType: !180, size: 64)
!180 = !DIBasicType(name: "long long", size: 64, encoding: DW_ATE_signed)
!181 = !DIDerivedType(tag: DW_TAG_member, name: "rem", scope: !177, file: !22, line: 79, baseType: !180, size: 64, offset: 64)
!182 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !175, entity: !183, file: !30, line: 206)
!183 = !DISubprogram(name: "_Exit", scope: !22, file: !22, line: 629, type: !88, flags: DIFlagPrototyped | DIFlagNoReturn, spFlags: 0)
!184 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !175, entity: !185, file: !30, line: 210)
!185 = !DISubprogram(name: "llabs", scope: !22, file: !22, line: 844, type: !186, flags: DIFlagPrototyped, spFlags: 0)
!186 = !DISubroutineType(types: !187)
!187 = !{!180, !180}
!188 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !175, entity: !189, file: !30, line: 216)
!189 = !DISubprogram(name: "lldiv", scope: !22, file: !22, line: 858, type: !190, flags: DIFlagPrototyped, spFlags: 0)
!190 = !DISubroutineType(types: !191)
!191 = !{!176, !180, !180}
!192 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !175, entity: !193, file: !30, line: 227)
!193 = !DISubprogram(name: "atoll", scope: !22, file: !22, line: 112, type: !194, flags: DIFlagPrototyped, spFlags: 0)
!194 = !DISubroutineType(types: !195)
!195 = !{!180, !61}
!196 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !175, entity: !197, file: !30, line: 228)
!197 = !DISubprogram(name: "strtoll", scope: !22, file: !22, line: 200, type: !198, flags: DIFlagPrototyped, spFlags: 0)
!198 = !DISubroutineType(types: !199)
!199 = !{!180, !122, !150, !25}
!200 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !175, entity: !201, file: !30, line: 229)
!201 = !DISubprogram(name: "strtoull", scope: !22, file: !22, line: 205, type: !202, flags: DIFlagPrototyped, spFlags: 0)
!202 = !DISubroutineType(types: !203)
!203 = !{!204, !122, !150, !25}
!204 = !DIBasicType(name: "unsigned long long", size: 64, encoding: DW_ATE_unsigned)
!205 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !175, entity: !206, file: !30, line: 231)
!206 = !DISubprogram(name: "strtof", scope: !22, file: !22, line: 123, type: !207, flags: DIFlagPrototyped, spFlags: 0)
!207 = !DISubroutineType(types: !208)
!208 = !{!209, !122, !150}
!209 = !DIBasicType(name: "float", size: 32, encoding: DW_ATE_float)
!210 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !175, entity: !211, file: !30, line: 232)
!211 = !DISubprogram(name: "strtold", scope: !22, file: !22, line: 126, type: !212, flags: DIFlagPrototyped, spFlags: 0)
!212 = !DISubroutineType(types: !213)
!213 = !{!214, !122, !150}
!214 = !DIBasicType(name: "long double", size: 128, encoding: DW_ATE_float)
!215 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !20, entity: !176, file: !30, line: 240)
!216 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !20, entity: !183, file: !30, line: 242)
!217 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !20, entity: !185, file: !30, line: 244)
!218 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !20, entity: !219, file: !30, line: 245)
!219 = !DISubprogram(name: "div", linkageName: "_ZN9__gnu_cxx3divExx", scope: !175, file: !30, line: 213, type: !190, flags: DIFlagPrototyped, spFlags: 0)
!220 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !20, entity: !189, file: !30, line: 246)
!221 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !20, entity: !193, file: !30, line: 248)
!222 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !20, entity: !206, file: !30, line: 249)
!223 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !20, entity: !197, file: !30, line: 250)
!224 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !20, entity: !201, file: !30, line: 251)
!225 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !20, entity: !211, file: !30, line: 252)
!226 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !39, file: !227, line: 38)
!227 = !DIFile(filename: "/usr/lib/gcc/x86_64-linux-gnu/9/../../../../include/c++/9/stdlib.h", directory: "", checksumkind: CSK_MD5, checksum: "4cd0241d66f1b357b386fcd60bc71b0f")
!228 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !50, file: !227, line: 39)
!229 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !87, file: !227, line: 40)
!230 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !55, file: !227, line: 43)
!231 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !132, file: !227, line: 46)
!232 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !28, file: !227, line: 51)
!233 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !32, file: !227, line: 52)
!234 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !235, file: !227, line: 54)
!235 = !DISubprogram(name: "abs", linkageName: "_ZSt3absg", scope: !20, file: !26, line: 103, type: !236, flags: DIFlagPrototyped, spFlags: 0)
!236 = !DISubroutineType(types: !237)
!237 = !{!238, !238}
!238 = !DIBasicType(name: "__float128", size: 128, encoding: DW_ATE_float)
!239 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !57, file: !227, line: 55)
!240 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !63, file: !227, line: 56)
!241 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !67, file: !227, line: 57)
!242 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !71, file: !227, line: 58)
!243 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !81, file: !227, line: 59)
!244 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !219, file: !227, line: 60)
!245 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !91, file: !227, line: 61)
!246 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !95, file: !227, line: 62)
!247 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !100, file: !227, line: 63)
!248 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !104, file: !227, line: 64)
!249 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !108, file: !227, line: 65)
!250 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !112, file: !227, line: 67)
!251 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !116, file: !227, line: 68)
!252 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !124, file: !227, line: 69)
!253 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !128, file: !227, line: 71)
!254 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !134, file: !227, line: 72)
!255 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !138, file: !227, line: 73)
!256 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !142, file: !227, line: 74)
!257 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !147, file: !227, line: 75)
!258 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !153, file: !227, line: 76)
!259 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !157, file: !227, line: 77)
!260 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !161, file: !227, line: 78)
!261 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !163, file: !227, line: 80)
!262 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !171, file: !227, line: 81)
!263 = !{i32 7, !"Dwarf Version", i32 5}
!264 = !{i32 2, !"Debug Info Version", i32 3}
!265 = !{i32 1, !"wchar_size", i32 4}
!266 = !{i32 8, !"PIC Level", i32 2}
!267 = !{i32 7, !"PIE Level", i32 2}
!268 = !{i32 7, !"uwtable", i32 2}
!269 = !{i32 7, !"frame-pointer", i32 2}
!270 = !{!"clang version 17.0.0 (https://github.com/llvm/llvm-project.git 88bf774c565080e30e0a073676c316ab175303af)"}
!271 = distinct !DISubprogram(name: "threadFunction2", linkageName: "_Z15threadFunction2Pv", scope: !7, file: !7, line: 5, type: !272, scopeLine: 5, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !274)
!272 = !DISubroutineType(types: !273)
!273 = !{!46, !46}
!274 = !{}
!275 = !DILocalVariable(name: "arg", arg: 1, scope: !271, file: !7, line: 5, type: !46)
!276 = !DILocation(line: 5, column: 29, scope: !271)
!277 = !DILocation(line: 6, column: 5, scope: !271)
!278 = !DILocation(line: 7, column: 5, scope: !271)
!279 = distinct !DISubprogram(name: "fun4", linkageName: "_Z4fun4Pi", scope: !7, file: !7, line: 11, type: !280, scopeLine: 11, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !274)
!280 = !DISubroutineType(types: !281)
!281 = !{null, !282}
!282 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !25, size: 64)
!283 = !DILocalVariable(name: "fun4_i", arg: 1, scope: !279, file: !7, line: 11, type: !282)
!284 = !DILocation(line: 11, column: 16, scope: !279)
!285 = !DILocalVariable(name: "fun4_a", scope: !279, file: !7, line: 13, type: !282)
!286 = !DILocation(line: 13, column: 10, scope: !279)
!287 = !DILocation(line: 14, column: 12, scope: !279)
!288 = !DILocation(line: 14, column: 11, scope: !279)
!289 = !DILocation(line: 15, column: 5, scope: !279)
!290 = distinct !DISubprogram(name: "fun3", linkageName: "_Z4fun3PPi", scope: !7, file: !7, line: 19, type: !291, scopeLine: 19, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !274)
!291 = !DISubroutineType(types: !292)
!292 = !{null, !293}
!293 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !282, size: 64)
!294 = !DILocalVariable(name: "fun3_i", arg: 1, scope: !290, file: !7, line: 19, type: !293)
!295 = !DILocation(line: 19, column: 17, scope: !290)
!296 = !DILocalVariable(name: "fun3_a", scope: !290, file: !7, line: 21, type: !282)
!297 = !DILocation(line: 21, column: 10, scope: !290)
!298 = !DILocation(line: 22, column: 13, scope: !290)
!299 = !DILocation(line: 22, column: 12, scope: !290)
!300 = !DILocation(line: 22, column: 11, scope: !290)
!301 = !DILocalVariable(name: "thread2", scope: !290, file: !7, line: 23, type: !8)
!302 = !DILocation(line: 23, column: 23, scope: !290)
!303 = !DILocation(line: 24, column: 12, scope: !290)
!304 = !DILocation(line: 24, column: 11, scope: !290)
!305 = !DILocation(line: 24, column: 6, scope: !290)
!306 = !DILocation(line: 25, column: 5, scope: !290)
!307 = distinct !DISubprogram(name: "fun2", linkageName: "_Z4fun2PPi", scope: !7, file: !7, line: 28, type: !291, scopeLine: 28, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !274)
!308 = !DILocalVariable(name: "fun2_i", arg: 1, scope: !307, file: !7, line: 28, type: !293)
!309 = !DILocation(line: 28, column: 17, scope: !307)
!310 = !DILocalVariable(name: "fun2_a", scope: !307, file: !7, line: 30, type: !282)
!311 = !DILocation(line: 30, column: 10, scope: !307)
!312 = !DILocation(line: 33, column: 10, scope: !307)
!313 = !DILocation(line: 33, column: 5, scope: !307)
!314 = !DILocation(line: 35, column: 17, scope: !307)
!315 = !DILocation(line: 35, column: 16, scope: !307)
!316 = !DILocation(line: 35, column: 15, scope: !307)
!317 = !DILocation(line: 36, column: 10, scope: !307)
!318 = !DILocation(line: 36, column: 5, scope: !307)
!319 = !DILocation(line: 37, column: 5, scope: !307)
!320 = distinct !DISubprogram(name: "fun", linkageName: "_Z3funPi", scope: !7, file: !7, line: 40, type: !280, scopeLine: 40, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !274)
!321 = !DILocalVariable(name: "fun_i", arg: 1, scope: !320, file: !7, line: 40, type: !282)
!322 = !DILocation(line: 40, column: 15, scope: !320)
!323 = !DILocalVariable(name: "fun_a", scope: !320, file: !7, line: 42, type: !282)
!324 = !DILocation(line: 42, column: 10, scope: !320)
!325 = !DILocation(line: 43, column: 11, scope: !320)
!326 = !DILocation(line: 43, column: 10, scope: !320)
!327 = !DILocation(line: 44, column: 5, scope: !320)
!328 = !DILocation(line: 45, column: 5, scope: !320)
!329 = distinct !DISubprogram(name: "main", scope: !7, file: !7, line: 49, type: !135, scopeLine: 49, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !274)
!330 = !DILocalVariable(name: "a", scope: !329, file: !7, line: 50, type: !25)
!331 = !DILocation(line: 50, column: 9, scope: !329)
!332 = !DILocation(line: 51, column: 4, scope: !329)
!333 = !DILocation(line: 52, column: 1, scope: !329)
