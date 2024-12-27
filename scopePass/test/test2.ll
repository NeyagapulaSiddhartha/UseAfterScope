; ModuleID = '/home/cs23mtech12010/CCM/CCMutator/llvm-project/llvm/lib/Transforms/scopePass/test/test2.ll'
source_filename = "/home/cs23mtech12010/CCM/CCMutator/llvm-project/llvm/lib/Transforms/scopePass/test/test2.cpp"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@.str = private unnamed_addr constant [26 x i8] c"Hello from Thread 2! ID:\0A\00", align 1, !dbg !0
@.str.1 = private unnamed_addr constant [27 x i8] c"Hello from Thread 1! ID: \0A\00", align 1, !dbg !8

; Function Attrs: mustprogress noinline nounwind optnone uwtable
define dso_local void @_Z3funPi(ptr noundef %0) #0 !dbg !270 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  call void @llvm.dbg.declare(metadata ptr %2, metadata !275, metadata !DIExpression()), !dbg !276
  ret void, !dbg !277
}

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: mustprogress noinline optnone uwtable
define dso_local noundef ptr @_Z15threadFunction2Pv(ptr noundef %0) #2 !dbg !278 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  call void @llvm.dbg.declare(metadata ptr %2, metadata !281, metadata !DIExpression()), !dbg !282
  %3 = call i32 (ptr, ...) @printf(ptr noundef @.str), !dbg !283
  ret ptr null, !dbg !284
}

declare i32 @printf(ptr noundef, ...) #3

; Function Attrs: mustprogress noinline optnone uwtable
define dso_local noundef ptr @_Z15threadFunction1Pv(ptr noundef %0) #2 !dbg !285 {
  %2 = alloca ptr, align 8
  %3 = alloca i64, align 8
  %4 = alloca i32, align 4
  store ptr %0, ptr %2, align 8
  call void @llvm.dbg.declare(metadata ptr %2, metadata !286, metadata !DIExpression()), !dbg !287
  call void @llvm.dbg.declare(metadata ptr %3, metadata !288, metadata !DIExpression()), !dbg !291
  call void @llvm.dbg.declare(metadata ptr %4, metadata !292, metadata !DIExpression()), !dbg !293
  store i32 10, ptr %4, align 4, !dbg !293
  %5 = call i32 (ptr, ...) @printf(ptr noundef @.str.1), !dbg !294
  %6 = call i32 @pthread_create(ptr noundef %3, ptr noundef null, ptr noundef @_Z15threadFunction2Pv, ptr noundef %4) #6, !dbg !295
  %7 = load i64, ptr %3, align 8, !dbg !296
  %8 = call i32 @pthread_join(i64 noundef %7, ptr noundef null), !dbg !297
  ret ptr null, !dbg !298
}

; Function Attrs: nounwind
declare i32 @pthread_create(ptr noundef, ptr noundef, ptr noundef, ptr noundef) #4

declare i32 @pthread_join(i64 noundef, ptr noundef) #3

; Function Attrs: mustprogress noinline norecurse optnone uwtable
define dso_local noundef i32 @main() #5 !dbg !299 {
  %1 = alloca i32, align 4
  %2 = alloca i64, align 8
  %3 = alloca ptr, align 8
  %4 = alloca i32, align 4
  store i32 0, ptr %1, align 4
  call void @llvm.dbg.declare(metadata ptr %2, metadata !300, metadata !DIExpression()), !dbg !301
  call void @llvm.dbg.declare(metadata ptr %3, metadata !302, metadata !DIExpression()), !dbg !303
  %5 = load ptr, ptr %3, align 8, !dbg !304
  call void @_Z3funPi(ptr noundef %5), !dbg !305
  call void @llvm.dbg.declare(metadata ptr %4, metadata !306, metadata !DIExpression()), !dbg !307
  store i32 9, ptr %4, align 4, !dbg !307
  %6 = load i32, ptr %4, align 4, !dbg !308
  %7 = icmp sgt i32 %6, 0, !dbg !310
  br i1 %7, label %8, label %10, !dbg !311

8:                                                ; preds = %0
  %9 = call i32 @pthread_create(ptr noundef %2, ptr noundef null, ptr noundef @_Z15threadFunction1Pv, ptr noundef null) #6, !dbg !312
  br label %10, !dbg !314

10:                                               ; preds = %8, %0
  %11 = load i64, ptr %2, align 8, !dbg !315
  %12 = call i32 @pthread_join(i64 noundef %11, ptr noundef null), !dbg !316
  ret i32 0, !dbg !317
}

attributes #0 = { mustprogress noinline nounwind optnone uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #2 = { mustprogress noinline optnone uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #3 = { "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #4 = { nounwind "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #5 = { mustprogress noinline norecurse optnone uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #6 = { nounwind }

!llvm.dbg.cu = !{!13}
!llvm.module.flags = !{!262, !263, !264, !265, !266, !267, !268}
!llvm.ident = !{!269}

!0 = !DIGlobalVariableExpression(var: !1, expr: !DIExpression())
!1 = distinct !DIGlobalVariable(scope: null, file: !2, line: 14, type: !3, isLocal: true, isDefinition: true)
!2 = !DIFile(filename: "llvm/lib/Transforms/scopePass/test/test2.cpp", directory: "/home/cs23mtech12010/CCM/CCMutator/llvm-project", checksumkind: CSK_MD5, checksum: "c40d3c78adfc3823b3ccf4a487a0ff5c")
!3 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 208, elements: !6)
!4 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !5)
!5 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!6 = !{!7}
!7 = !DISubrange(count: 26)
!8 = !DIGlobalVariableExpression(var: !9, expr: !DIExpression())
!9 = distinct !DIGlobalVariable(scope: null, file: !2, line: 22, type: !10, isLocal: true, isDefinition: true)
!10 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 216, elements: !11)
!11 = !{!12}
!12 = !DISubrange(count: 27)
!13 = distinct !DICompileUnit(language: DW_LANG_C_plus_plus_14, file: !14, producer: "clang version 17.0.0 (https://github.com/llvm/llvm-project.git 88bf774c565080e30e0a073676c316ab175303af)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, globals: !15, imports: !16, splitDebugInlining: false, nameTableKind: None)
!14 = !DIFile(filename: "/home/cs23mtech12010/CCM/CCMutator/llvm-project/llvm/lib/Transforms/scopePass/test/test2.cpp", directory: "/home/cs23mtech12010/CCM/CCMutator/llvm-project/build", checksumkind: CSK_MD5, checksum: "c40d3c78adfc3823b3ccf4a487a0ff5c")
!15 = !{!0, !8}
!16 = !{!17, !25, !29, !36, !40, !48, !53, !55, !61, !65, !69, !79, !81, !85, !89, !93, !98, !102, !106, !110, !114, !122, !126, !130, !132, !136, !140, !145, !151, !155, !159, !161, !169, !173, !181, !183, !187, !191, !195, !199, !204, !209, !214, !215, !216, !217, !219, !220, !221, !222, !223, !224, !225, !227, !228, !229, !230, !231, !232, !233, !238, !239, !240, !241, !242, !243, !244, !245, !246, !247, !248, !249, !250, !251, !252, !253, !254, !255, !256, !257, !258, !259, !260, !261}
!17 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !18, entity: !19, file: !24, line: 52)
!18 = !DINamespace(name: "std", scope: null)
!19 = !DISubprogram(name: "abs", scope: !20, file: !20, line: 840, type: !21, flags: DIFlagPrototyped, spFlags: 0)
!20 = !DIFile(filename: "/usr/include/stdlib.h", directory: "", checksumkind: CSK_MD5, checksum: "f0db66726d35051e5af2525f5b33bd81")
!21 = !DISubroutineType(types: !22)
!22 = !{!23, !23}
!23 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!24 = !DIFile(filename: "/usr/lib/gcc/x86_64-linux-gnu/9/../../../../include/c++/9/bits/std_abs.h", directory: "")
!25 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !18, entity: !26, file: !28, line: 127)
!26 = !DIDerivedType(tag: DW_TAG_typedef, name: "div_t", file: !20, line: 62, baseType: !27)
!27 = distinct !DICompositeType(tag: DW_TAG_structure_type, file: !20, line: 58, size: 64, flags: DIFlagFwdDecl, identifier: "_ZTS5div_t")
!28 = !DIFile(filename: "/usr/lib/gcc/x86_64-linux-gnu/9/../../../../include/c++/9/cstdlib", directory: "")
!29 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !18, entity: !30, file: !28, line: 128)
!30 = !DIDerivedType(tag: DW_TAG_typedef, name: "ldiv_t", file: !20, line: 70, baseType: !31)
!31 = distinct !DICompositeType(tag: DW_TAG_structure_type, file: !20, line: 66, size: 128, flags: DIFlagTypePassByValue, elements: !32, identifier: "_ZTS6ldiv_t")
!32 = !{!33, !35}
!33 = !DIDerivedType(tag: DW_TAG_member, name: "quot", scope: !31, file: !20, line: 68, baseType: !34, size: 64)
!34 = !DIBasicType(name: "long", size: 64, encoding: DW_ATE_signed)
!35 = !DIDerivedType(tag: DW_TAG_member, name: "rem", scope: !31, file: !20, line: 69, baseType: !34, size: 64, offset: 64)
!36 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !18, entity: !37, file: !28, line: 130)
!37 = !DISubprogram(name: "abort", scope: !20, file: !20, line: 591, type: !38, flags: DIFlagPrototyped | DIFlagNoReturn, spFlags: 0)
!38 = !DISubroutineType(types: !39)
!39 = !{null}
!40 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !18, entity: !41, file: !28, line: 132)
!41 = !DISubprogram(name: "aligned_alloc", scope: !20, file: !20, line: 586, type: !42, flags: DIFlagPrototyped, spFlags: 0)
!42 = !DISubroutineType(types: !43)
!43 = !{!44, !45, !45}
!44 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: null, size: 64)
!45 = !DIDerivedType(tag: DW_TAG_typedef, name: "size_t", file: !46, line: 46, baseType: !47)
!46 = !DIFile(filename: "lib/clang/17/include/stddef.h", directory: "/home/cs23mtech12010/CCM/CCMutator/llvm-project/build", checksumkind: CSK_MD5, checksum: "d1776268f398bd1ca997c840ad581432")
!47 = !DIBasicType(name: "unsigned long", size: 64, encoding: DW_ATE_unsigned)
!48 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !18, entity: !49, file: !28, line: 134)
!49 = !DISubprogram(name: "atexit", scope: !20, file: !20, line: 595, type: !50, flags: DIFlagPrototyped, spFlags: 0)
!50 = !DISubroutineType(types: !51)
!51 = !{!23, !52}
!52 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !38, size: 64)
!53 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !18, entity: !54, file: !28, line: 137)
!54 = !DISubprogram(name: "at_quick_exit", scope: !20, file: !20, line: 600, type: !50, flags: DIFlagPrototyped, spFlags: 0)
!55 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !18, entity: !56, file: !28, line: 140)
!56 = !DISubprogram(name: "atof", scope: !20, file: !20, line: 101, type: !57, flags: DIFlagPrototyped, spFlags: 0)
!57 = !DISubroutineType(types: !58)
!58 = !{!59, !60}
!59 = !DIBasicType(name: "double", size: 64, encoding: DW_ATE_float)
!60 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !4, size: 64)
!61 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !18, entity: !62, file: !28, line: 141)
!62 = !DISubprogram(name: "atoi", scope: !20, file: !20, line: 104, type: !63, flags: DIFlagPrototyped, spFlags: 0)
!63 = !DISubroutineType(types: !64)
!64 = !{!23, !60}
!65 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !18, entity: !66, file: !28, line: 142)
!66 = !DISubprogram(name: "atol", scope: !20, file: !20, line: 107, type: !67, flags: DIFlagPrototyped, spFlags: 0)
!67 = !DISubroutineType(types: !68)
!68 = !{!34, !60}
!69 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !18, entity: !70, file: !28, line: 143)
!70 = !DISubprogram(name: "bsearch", scope: !20, file: !20, line: 820, type: !71, flags: DIFlagPrototyped, spFlags: 0)
!71 = !DISubroutineType(types: !72)
!72 = !{!44, !73, !73, !45, !45, !75}
!73 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !74, size: 64)
!74 = !DIDerivedType(tag: DW_TAG_const_type, baseType: null)
!75 = !DIDerivedType(tag: DW_TAG_typedef, name: "__compar_fn_t", file: !20, line: 808, baseType: !76)
!76 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !77, size: 64)
!77 = !DISubroutineType(types: !78)
!78 = !{!23, !73, !73}
!79 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !18, entity: !80, file: !28, line: 144)
!80 = !DISubprogram(name: "calloc", scope: !20, file: !20, line: 542, type: !42, flags: DIFlagPrototyped, spFlags: 0)
!81 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !18, entity: !82, file: !28, line: 145)
!82 = !DISubprogram(name: "div", scope: !20, file: !20, line: 852, type: !83, flags: DIFlagPrototyped, spFlags: 0)
!83 = !DISubroutineType(types: !84)
!84 = !{!26, !23, !23}
!85 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !18, entity: !86, file: !28, line: 146)
!86 = !DISubprogram(name: "exit", scope: !20, file: !20, line: 617, type: !87, flags: DIFlagPrototyped | DIFlagNoReturn, spFlags: 0)
!87 = !DISubroutineType(types: !88)
!88 = !{null, !23}
!89 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !18, entity: !90, file: !28, line: 147)
!90 = !DISubprogram(name: "free", scope: !20, file: !20, line: 565, type: !91, flags: DIFlagPrototyped, spFlags: 0)
!91 = !DISubroutineType(types: !92)
!92 = !{null, !44}
!93 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !18, entity: !94, file: !28, line: 148)
!94 = !DISubprogram(name: "getenv", scope: !20, file: !20, line: 634, type: !95, flags: DIFlagPrototyped, spFlags: 0)
!95 = !DISubroutineType(types: !96)
!96 = !{!97, !60}
!97 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !5, size: 64)
!98 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !18, entity: !99, file: !28, line: 149)
!99 = !DISubprogram(name: "labs", scope: !20, file: !20, line: 841, type: !100, flags: DIFlagPrototyped, spFlags: 0)
!100 = !DISubroutineType(types: !101)
!101 = !{!34, !34}
!102 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !18, entity: !103, file: !28, line: 150)
!103 = !DISubprogram(name: "ldiv", scope: !20, file: !20, line: 854, type: !104, flags: DIFlagPrototyped, spFlags: 0)
!104 = !DISubroutineType(types: !105)
!105 = !{!30, !34, !34}
!106 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !18, entity: !107, file: !28, line: 151)
!107 = !DISubprogram(name: "malloc", scope: !20, file: !20, line: 539, type: !108, flags: DIFlagPrototyped, spFlags: 0)
!108 = !DISubroutineType(types: !109)
!109 = !{!44, !45}
!110 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !18, entity: !111, file: !28, line: 153)
!111 = !DISubprogram(name: "mblen", scope: !20, file: !20, line: 922, type: !112, flags: DIFlagPrototyped, spFlags: 0)
!112 = !DISubroutineType(types: !113)
!113 = !{!23, !60, !45}
!114 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !18, entity: !115, file: !28, line: 154)
!115 = !DISubprogram(name: "mbstowcs", scope: !20, file: !20, line: 933, type: !116, flags: DIFlagPrototyped, spFlags: 0)
!116 = !DISubroutineType(types: !117)
!117 = !{!45, !118, !121, !45}
!118 = !DIDerivedType(tag: DW_TAG_restrict_type, baseType: !119)
!119 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !120, size: 64)
!120 = !DIBasicType(name: "wchar_t", size: 32, encoding: DW_ATE_signed)
!121 = !DIDerivedType(tag: DW_TAG_restrict_type, baseType: !60)
!122 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !18, entity: !123, file: !28, line: 155)
!123 = !DISubprogram(name: "mbtowc", scope: !20, file: !20, line: 925, type: !124, flags: DIFlagPrototyped, spFlags: 0)
!124 = !DISubroutineType(types: !125)
!125 = !{!23, !118, !121, !45}
!126 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !18, entity: !127, file: !28, line: 157)
!127 = !DISubprogram(name: "qsort", scope: !20, file: !20, line: 830, type: !128, flags: DIFlagPrototyped, spFlags: 0)
!128 = !DISubroutineType(types: !129)
!129 = !{null, !44, !45, !45, !75}
!130 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !18, entity: !131, file: !28, line: 160)
!131 = !DISubprogram(name: "quick_exit", scope: !20, file: !20, line: 623, type: !87, flags: DIFlagPrototyped | DIFlagNoReturn, spFlags: 0)
!132 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !18, entity: !133, file: !28, line: 163)
!133 = !DISubprogram(name: "rand", scope: !20, file: !20, line: 453, type: !134, flags: DIFlagPrototyped, spFlags: 0)
!134 = !DISubroutineType(types: !135)
!135 = !{!23}
!136 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !18, entity: !137, file: !28, line: 164)
!137 = !DISubprogram(name: "realloc", scope: !20, file: !20, line: 550, type: !138, flags: DIFlagPrototyped, spFlags: 0)
!138 = !DISubroutineType(types: !139)
!139 = !{!44, !44, !45}
!140 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !18, entity: !141, file: !28, line: 165)
!141 = !DISubprogram(name: "srand", scope: !20, file: !20, line: 455, type: !142, flags: DIFlagPrototyped, spFlags: 0)
!142 = !DISubroutineType(types: !143)
!143 = !{null, !144}
!144 = !DIBasicType(name: "unsigned int", size: 32, encoding: DW_ATE_unsigned)
!145 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !18, entity: !146, file: !28, line: 166)
!146 = !DISubprogram(name: "strtod", scope: !20, file: !20, line: 117, type: !147, flags: DIFlagPrototyped, spFlags: 0)
!147 = !DISubroutineType(types: !148)
!148 = !{!59, !121, !149}
!149 = !DIDerivedType(tag: DW_TAG_restrict_type, baseType: !150)
!150 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !97, size: 64)
!151 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !18, entity: !152, file: !28, line: 167)
!152 = !DISubprogram(name: "strtol", scope: !20, file: !20, line: 176, type: !153, flags: DIFlagPrototyped, spFlags: 0)
!153 = !DISubroutineType(types: !154)
!154 = !{!34, !121, !149, !23}
!155 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !18, entity: !156, file: !28, line: 168)
!156 = !DISubprogram(name: "strtoul", scope: !20, file: !20, line: 180, type: !157, flags: DIFlagPrototyped, spFlags: 0)
!157 = !DISubroutineType(types: !158)
!158 = !{!47, !121, !149, !23}
!159 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !18, entity: !160, file: !28, line: 169)
!160 = !DISubprogram(name: "system", scope: !20, file: !20, line: 784, type: !63, flags: DIFlagPrototyped, spFlags: 0)
!161 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !18, entity: !162, file: !28, line: 171)
!162 = !DISubprogram(name: "wcstombs", scope: !20, file: !20, line: 936, type: !163, flags: DIFlagPrototyped, spFlags: 0)
!163 = !DISubroutineType(types: !164)
!164 = !{!45, !165, !166, !45}
!165 = !DIDerivedType(tag: DW_TAG_restrict_type, baseType: !97)
!166 = !DIDerivedType(tag: DW_TAG_restrict_type, baseType: !167)
!167 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !168, size: 64)
!168 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !120)
!169 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !18, entity: !170, file: !28, line: 172)
!170 = !DISubprogram(name: "wctomb", scope: !20, file: !20, line: 929, type: !171, flags: DIFlagPrototyped, spFlags: 0)
!171 = !DISubroutineType(types: !172)
!172 = !{!23, !97, !120}
!173 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !174, entity: !175, file: !28, line: 200)
!174 = !DINamespace(name: "__gnu_cxx", scope: null)
!175 = !DIDerivedType(tag: DW_TAG_typedef, name: "lldiv_t", file: !20, line: 80, baseType: !176)
!176 = distinct !DICompositeType(tag: DW_TAG_structure_type, file: !20, line: 76, size: 128, flags: DIFlagTypePassByValue, elements: !177, identifier: "_ZTS7lldiv_t")
!177 = !{!178, !180}
!178 = !DIDerivedType(tag: DW_TAG_member, name: "quot", scope: !176, file: !20, line: 78, baseType: !179, size: 64)
!179 = !DIBasicType(name: "long long", size: 64, encoding: DW_ATE_signed)
!180 = !DIDerivedType(tag: DW_TAG_member, name: "rem", scope: !176, file: !20, line: 79, baseType: !179, size: 64, offset: 64)
!181 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !174, entity: !182, file: !28, line: 206)
!182 = !DISubprogram(name: "_Exit", scope: !20, file: !20, line: 629, type: !87, flags: DIFlagPrototyped | DIFlagNoReturn, spFlags: 0)
!183 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !174, entity: !184, file: !28, line: 210)
!184 = !DISubprogram(name: "llabs", scope: !20, file: !20, line: 844, type: !185, flags: DIFlagPrototyped, spFlags: 0)
!185 = !DISubroutineType(types: !186)
!186 = !{!179, !179}
!187 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !174, entity: !188, file: !28, line: 216)
!188 = !DISubprogram(name: "lldiv", scope: !20, file: !20, line: 858, type: !189, flags: DIFlagPrototyped, spFlags: 0)
!189 = !DISubroutineType(types: !190)
!190 = !{!175, !179, !179}
!191 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !174, entity: !192, file: !28, line: 227)
!192 = !DISubprogram(name: "atoll", scope: !20, file: !20, line: 112, type: !193, flags: DIFlagPrototyped, spFlags: 0)
!193 = !DISubroutineType(types: !194)
!194 = !{!179, !60}
!195 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !174, entity: !196, file: !28, line: 228)
!196 = !DISubprogram(name: "strtoll", scope: !20, file: !20, line: 200, type: !197, flags: DIFlagPrototyped, spFlags: 0)
!197 = !DISubroutineType(types: !198)
!198 = !{!179, !121, !149, !23}
!199 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !174, entity: !200, file: !28, line: 229)
!200 = !DISubprogram(name: "strtoull", scope: !20, file: !20, line: 205, type: !201, flags: DIFlagPrototyped, spFlags: 0)
!201 = !DISubroutineType(types: !202)
!202 = !{!203, !121, !149, !23}
!203 = !DIBasicType(name: "unsigned long long", size: 64, encoding: DW_ATE_unsigned)
!204 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !174, entity: !205, file: !28, line: 231)
!205 = !DISubprogram(name: "strtof", scope: !20, file: !20, line: 123, type: !206, flags: DIFlagPrototyped, spFlags: 0)
!206 = !DISubroutineType(types: !207)
!207 = !{!208, !121, !149}
!208 = !DIBasicType(name: "float", size: 32, encoding: DW_ATE_float)
!209 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !174, entity: !210, file: !28, line: 232)
!210 = !DISubprogram(name: "strtold", scope: !20, file: !20, line: 126, type: !211, flags: DIFlagPrototyped, spFlags: 0)
!211 = !DISubroutineType(types: !212)
!212 = !{!213, !121, !149}
!213 = !DIBasicType(name: "long double", size: 128, encoding: DW_ATE_float)
!214 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !18, entity: !175, file: !28, line: 240)
!215 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !18, entity: !182, file: !28, line: 242)
!216 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !18, entity: !184, file: !28, line: 244)
!217 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !18, entity: !218, file: !28, line: 245)
!218 = !DISubprogram(name: "div", linkageName: "_ZN9__gnu_cxx3divExx", scope: !174, file: !28, line: 213, type: !189, flags: DIFlagPrototyped, spFlags: 0)
!219 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !18, entity: !188, file: !28, line: 246)
!220 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !18, entity: !192, file: !28, line: 248)
!221 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !18, entity: !205, file: !28, line: 249)
!222 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !18, entity: !196, file: !28, line: 250)
!223 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !18, entity: !200, file: !28, line: 251)
!224 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !18, entity: !210, file: !28, line: 252)
!225 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !13, entity: !37, file: !226, line: 38)
!226 = !DIFile(filename: "/usr/lib/gcc/x86_64-linux-gnu/9/../../../../include/c++/9/stdlib.h", directory: "", checksumkind: CSK_MD5, checksum: "4cd0241d66f1b357b386fcd60bc71b0f")
!227 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !13, entity: !49, file: !226, line: 39)
!228 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !13, entity: !86, file: !226, line: 40)
!229 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !13, entity: !54, file: !226, line: 43)
!230 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !13, entity: !131, file: !226, line: 46)
!231 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !13, entity: !26, file: !226, line: 51)
!232 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !13, entity: !30, file: !226, line: 52)
!233 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !13, entity: !234, file: !226, line: 54)
!234 = !DISubprogram(name: "abs", linkageName: "_ZSt3absg", scope: !18, file: !24, line: 103, type: !235, flags: DIFlagPrototyped, spFlags: 0)
!235 = !DISubroutineType(types: !236)
!236 = !{!237, !237}
!237 = !DIBasicType(name: "__float128", size: 128, encoding: DW_ATE_float)
!238 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !13, entity: !56, file: !226, line: 55)
!239 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !13, entity: !62, file: !226, line: 56)
!240 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !13, entity: !66, file: !226, line: 57)
!241 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !13, entity: !70, file: !226, line: 58)
!242 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !13, entity: !80, file: !226, line: 59)
!243 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !13, entity: !218, file: !226, line: 60)
!244 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !13, entity: !90, file: !226, line: 61)
!245 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !13, entity: !94, file: !226, line: 62)
!246 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !13, entity: !99, file: !226, line: 63)
!247 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !13, entity: !103, file: !226, line: 64)
!248 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !13, entity: !107, file: !226, line: 65)
!249 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !13, entity: !111, file: !226, line: 67)
!250 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !13, entity: !115, file: !226, line: 68)
!251 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !13, entity: !123, file: !226, line: 69)
!252 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !13, entity: !127, file: !226, line: 71)
!253 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !13, entity: !133, file: !226, line: 72)
!254 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !13, entity: !137, file: !226, line: 73)
!255 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !13, entity: !141, file: !226, line: 74)
!256 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !13, entity: !146, file: !226, line: 75)
!257 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !13, entity: !152, file: !226, line: 76)
!258 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !13, entity: !156, file: !226, line: 77)
!259 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !13, entity: !160, file: !226, line: 78)
!260 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !13, entity: !162, file: !226, line: 80)
!261 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !13, entity: !170, file: !226, line: 81)
!262 = !{i32 7, !"Dwarf Version", i32 5}
!263 = !{i32 2, !"Debug Info Version", i32 3}
!264 = !{i32 1, !"wchar_size", i32 4}
!265 = !{i32 8, !"PIC Level", i32 2}
!266 = !{i32 7, !"PIE Level", i32 2}
!267 = !{i32 7, !"uwtable", i32 2}
!268 = !{i32 7, !"frame-pointer", i32 2}
!269 = !{!"clang version 17.0.0 (https://github.com/llvm/llvm-project.git 88bf774c565080e30e0a073676c316ab175303af)"}
!270 = distinct !DISubprogram(name: "fun", linkageName: "_Z3funPi", scope: !2, file: !2, line: 7, type: !271, scopeLine: 7, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !13, retainedNodes: !274)
!271 = !DISubroutineType(types: !272)
!272 = !{null, !273}
!273 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !23, size: 64)
!274 = !{}
!275 = !DILocalVariable(name: "i", arg: 1, scope: !270, file: !2, line: 7, type: !273)
!276 = !DILocation(line: 7, column: 15, scope: !270)
!277 = !DILocation(line: 8, column: 5, scope: !270)
!278 = distinct !DISubprogram(name: "threadFunction2", linkageName: "_Z15threadFunction2Pv", scope: !2, file: !2, line: 13, type: !279, scopeLine: 13, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !13, retainedNodes: !274)
!279 = !DISubroutineType(types: !280)
!280 = !{!44, !44}
!281 = !DILocalVariable(name: "arg", arg: 1, scope: !278, file: !2, line: 13, type: !44)
!282 = !DILocation(line: 13, column: 29, scope: !278)
!283 = !DILocation(line: 14, column: 5, scope: !278)
!284 = !DILocation(line: 15, column: 5, scope: !278)
!285 = distinct !DISubprogram(name: "threadFunction1", linkageName: "_Z15threadFunction1Pv", scope: !2, file: !2, line: 19, type: !279, scopeLine: 19, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !13, retainedNodes: !274)
!286 = !DILocalVariable(name: "arg", arg: 1, scope: !285, file: !2, line: 19, type: !44)
!287 = !DILocation(line: 19, column: 29, scope: !285)
!288 = !DILocalVariable(name: "thread2", scope: !285, file: !2, line: 20, type: !289)
!289 = !DIDerivedType(tag: DW_TAG_typedef, name: "pthread_t", file: !290, line: 27, baseType: !47)
!290 = !DIFile(filename: "/usr/include/x86_64-linux-gnu/bits/pthreadtypes.h", directory: "", checksumkind: CSK_MD5, checksum: "2d764266ce95ab26d4a4767c2ec78176")
!291 = !DILocation(line: 20, column: 17, scope: !285)
!292 = !DILocalVariable(name: "a", scope: !285, file: !2, line: 21, type: !23)
!293 = !DILocation(line: 21, column: 10, scope: !285)
!294 = !DILocation(line: 22, column: 5, scope: !285)
!295 = !DILocation(line: 23, column: 5, scope: !285)
!296 = !DILocation(line: 25, column: 18, scope: !285)
!297 = !DILocation(line: 25, column: 5, scope: !285)
!298 = !DILocation(line: 27, column: 5, scope: !285)
!299 = distinct !DISubprogram(name: "main", scope: !2, file: !2, line: 31, type: !134, scopeLine: 31, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !13, retainedNodes: !274)
!300 = !DILocalVariable(name: "thread1", scope: !299, file: !2, line: 32, type: !289)
!301 = !DILocation(line: 32, column: 15, scope: !299)
!302 = !DILocalVariable(name: "p", scope: !299, file: !2, line: 34, type: !273)
!303 = !DILocation(line: 34, column: 6, scope: !299)
!304 = !DILocation(line: 36, column: 11, scope: !299)
!305 = !DILocation(line: 36, column: 7, scope: !299)
!306 = !DILocalVariable(name: "c", scope: !299, file: !2, line: 37, type: !23)
!307 = !DILocation(line: 37, column: 9, scope: !299)
!308 = !DILocation(line: 38, column: 8, scope: !309)
!309 = distinct !DILexicalBlock(scope: !299, file: !2, line: 38, column: 8)
!310 = !DILocation(line: 38, column: 9, scope: !309)
!311 = !DILocation(line: 38, column: 8, scope: !299)
!312 = !DILocation(line: 39, column: 9, scope: !313)
!313 = distinct !DILexicalBlock(scope: !309, file: !2, line: 38, column: 12)
!314 = !DILocation(line: 41, column: 5, scope: !313)
!315 = !DILocation(line: 46, column: 14, scope: !299)
!316 = !DILocation(line: 46, column: 1, scope: !299)
!317 = !DILocation(line: 51, column: 5, scope: !299)
