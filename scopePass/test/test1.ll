; ModuleID = '/home/cs23mtech12010/CCM/CCMutator/llvm-project/llvm/lib/Transforms/scopePass/test/testTWOJOINS.ll'
source_filename = "/home/cs23mtech12010/CCM/CCMutator/llvm-project/llvm/lib/Transforms/scopePass/test/testTWOJOINS.cpp"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@.str = private unnamed_addr constant [26 x i8] c"Hello from Thread 2! ID:\0A\00", align 1, !dbg !0

; Function Attrs: mustprogress noinline optnone uwtable
define dso_local noundef ptr @_Z15threadFunction2Pv(ptr noundef %0) #0 !dbg !265 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  call void @llvm.dbg.declare(metadata ptr %2, metadata !269, metadata !DIExpression()), !dbg !270
  %3 = call i32 (ptr, ...) @printf(ptr noundef @.str), !dbg !271
  ret ptr null, !dbg !272
}

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

declare i32 @printf(ptr noundef, ...) #2

; Function Attrs: mustprogress noinline nounwind optnone uwtable
define dso_local void @_Z4fun3PPi(ptr noundef %0) #3 !dbg !273 {
  %2 = alloca ptr, align 8
  %3 = alloca ptr, align 8
  %4 = alloca i64, align 8
  store ptr %0, ptr %2, align 8
  call void @llvm.dbg.declare(metadata ptr %2, metadata !278, metadata !DIExpression()), !dbg !279
  call void @llvm.dbg.declare(metadata ptr %3, metadata !280, metadata !DIExpression()), !dbg !281
  %5 = load ptr, ptr %2, align 8, !dbg !282
  %6 = load ptr, ptr %5, align 8, !dbg !283
  store ptr %6, ptr %3, align 8, !dbg !284
  call void @llvm.dbg.declare(metadata ptr %4, metadata !285, metadata !DIExpression()), !dbg !288
  %7 = load ptr, ptr %2, align 8, !dbg !289
  %8 = load ptr, ptr %7, align 8, !dbg !290
  %9 = call i32 @pthread_create(ptr noundef %4, ptr noundef null, ptr noundef @_Z15threadFunction2Pv, ptr noundef %8) #6, !dbg !291
  ret void, !dbg !292
}

; Function Attrs: nounwind
declare i32 @pthread_create(ptr noundef, ptr noundef, ptr noundef, ptr noundef) #4

; Function Attrs: mustprogress noinline nounwind optnone uwtable
define dso_local void @_Z3funPi(ptr noundef %0) #3 !dbg !293 {
  %2 = alloca ptr, align 8
  %3 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  call void @llvm.dbg.declare(metadata ptr %2, metadata !296, metadata !DIExpression()), !dbg !297
  call void @llvm.dbg.declare(metadata ptr %3, metadata !298, metadata !DIExpression()), !dbg !299
  %4 = load ptr, ptr %2, align 8, !dbg !300
  store ptr %4, ptr %3, align 8, !dbg !301
  ret void, !dbg !302
}

; Function Attrs: mustprogress noinline nounwind optnone uwtable
define dso_local void @_Z4fun2PPi(ptr noundef %0) #3 !dbg !303 {
  %2 = alloca ptr, align 8
  %3 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  call void @llvm.dbg.declare(metadata ptr %2, metadata !304, metadata !DIExpression()), !dbg !305
  call void @llvm.dbg.declare(metadata ptr %3, metadata !306, metadata !DIExpression()), !dbg !307
  %4 = load ptr, ptr %2, align 8, !dbg !308
  %5 = load ptr, ptr %4, align 8, !dbg !309
  store ptr %5, ptr %3, align 8, !dbg !310
  %6 = load ptr, ptr %2, align 8, !dbg !311
  call void @_Z4fun3PPi(ptr noundef %6), !dbg !312
  ret void, !dbg !313
}

; Function Attrs: mustprogress noinline norecurse optnone uwtable
define dso_local noundef i32 @main() #5 !dbg !314 {
  %1 = alloca i32, align 4
  %2 = alloca i64, align 8
  %3 = alloca i64, align 8
  %4 = alloca i32, align 4
  %5 = alloca ptr, align 8
  %6 = alloca ptr, align 8
  %7 = alloca ptr, align 8
  store i32 0, ptr %1, align 4
  call void @llvm.dbg.declare(metadata ptr %2, metadata !315, metadata !DIExpression()), !dbg !316
  call void @llvm.dbg.declare(metadata ptr %3, metadata !317, metadata !DIExpression()), !dbg !318
  call void @llvm.dbg.declare(metadata ptr %4, metadata !319, metadata !DIExpression()), !dbg !320
  store i32 9, ptr %4, align 4, !dbg !320
  call void @llvm.dbg.declare(metadata ptr %5, metadata !321, metadata !DIExpression()), !dbg !322
  call void @llvm.dbg.declare(metadata ptr %6, metadata !323, metadata !DIExpression()), !dbg !324
  store ptr %4, ptr %6, align 8, !dbg !325
  store ptr %6, ptr %5, align 8, !dbg !326
  %8 = load ptr, ptr %5, align 8, !dbg !327
  %9 = load ptr, ptr %8, align 8, !dbg !328
  %10 = load i32, ptr %9, align 4, !dbg !329
  %11 = add nsw i32 %10, 1, !dbg !329
  store i32 %11, ptr %9, align 4, !dbg !329
  call void @llvm.dbg.declare(metadata ptr %7, metadata !330, metadata !DIExpression()), !dbg !331
  %12 = load ptr, ptr %5, align 8, !dbg !332
  store ptr %12, ptr %7, align 8, !dbg !333
  %13 = load ptr, ptr %5, align 8, !dbg !334
  call void @_Z4fun2PPi(ptr noundef %13), !dbg !335
  %14 = call i32 @pthread_create(ptr noundef %2, ptr noundef null, ptr noundef @_Z15threadFunction2Pv, ptr noundef null) #6, !dbg !336
  %15 = call i32 @pthread_create(ptr noundef %3, ptr noundef null, ptr noundef @_Z15threadFunction2Pv, ptr noundef %4) #6, !dbg !337
  %16 = load i32, ptr %4, align 4, !dbg !338
  %17 = load i32, ptr %4, align 4, !dbg !340
  %18 = mul nsw i32 %16, %17, !dbg !341
  %19 = load i32, ptr %4, align 4, !dbg !342
  %20 = sub nsw i32 %19, 1, !dbg !343
  %21 = icmp sgt i32 %18, %20, !dbg !344
  br i1 %21, label %22, label %27, !dbg !345

22:                                               ; preds = %0
  %23 = load i64, ptr %2, align 8, !dbg !346
  %24 = call i32 @pthread_join(i64 noundef %23, ptr noundef null), !dbg !348
  %25 = load i64, ptr %3, align 8, !dbg !349
  %26 = call i32 @pthread_join(i64 noundef %25, ptr noundef null), !dbg !350
  br label %30, !dbg !351

27:                                               ; preds = %0
  %28 = load i64, ptr %2, align 8, !dbg !352
  %29 = call i32 @pthread_join(i64 noundef %28, ptr noundef null), !dbg !354
  br label %30

30:                                               ; preds = %27, %22
  ret i32 0, !dbg !355
}

declare i32 @pthread_join(i64 noundef, ptr noundef) #2

attributes #0 = { mustprogress noinline optnone uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #2 = { "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #3 = { mustprogress noinline nounwind optnone uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #4 = { nounwind "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #5 = { mustprogress noinline norecurse optnone uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #6 = { nounwind }

!llvm.dbg.cu = !{!8}
!llvm.module.flags = !{!257, !258, !259, !260, !261, !262, !263}
!llvm.ident = !{!264}

!0 = !DIGlobalVariableExpression(var: !1, expr: !DIExpression())
!1 = distinct !DIGlobalVariable(scope: null, file: !2, line: 6, type: !3, isLocal: true, isDefinition: true)
!2 = !DIFile(filename: "llvm/lib/Transforms/scopePass/test/testTWOJOINS.cpp", directory: "/home/cs23mtech12010/CCM/CCMutator/llvm-project", checksumkind: CSK_MD5, checksum: "2c3696142491555dce01144a6bd39929")
!3 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 208, elements: !6)
!4 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !5)
!5 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!6 = !{!7}
!7 = !DISubrange(count: 26)
!8 = distinct !DICompileUnit(language: DW_LANG_C_plus_plus_14, file: !9, producer: "clang version 17.0.0 (https://github.com/llvm/llvm-project.git 88bf774c565080e30e0a073676c316ab175303af)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, globals: !10, imports: !11, splitDebugInlining: false, nameTableKind: None)
!9 = !DIFile(filename: "/home/cs23mtech12010/CCM/CCMutator/llvm-project/llvm/lib/Transforms/scopePass/test/testTWOJOINS.cpp", directory: "/home/cs23mtech12010/CCM/CCMutator/llvm-project/build", checksumkind: CSK_MD5, checksum: "2c3696142491555dce01144a6bd39929")
!10 = !{!0}
!11 = !{!12, !20, !24, !31, !35, !43, !48, !50, !56, !60, !64, !74, !76, !80, !84, !88, !93, !97, !101, !105, !109, !117, !121, !125, !127, !131, !135, !140, !146, !150, !154, !156, !164, !168, !176, !178, !182, !186, !190, !194, !199, !204, !209, !210, !211, !212, !214, !215, !216, !217, !218, !219, !220, !222, !223, !224, !225, !226, !227, !228, !233, !234, !235, !236, !237, !238, !239, !240, !241, !242, !243, !244, !245, !246, !247, !248, !249, !250, !251, !252, !253, !254, !255, !256}
!12 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !13, entity: !14, file: !19, line: 52)
!13 = !DINamespace(name: "std", scope: null)
!14 = !DISubprogram(name: "abs", scope: !15, file: !15, line: 840, type: !16, flags: DIFlagPrototyped, spFlags: 0)
!15 = !DIFile(filename: "/usr/include/stdlib.h", directory: "", checksumkind: CSK_MD5, checksum: "f0db66726d35051e5af2525f5b33bd81")
!16 = !DISubroutineType(types: !17)
!17 = !{!18, !18}
!18 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!19 = !DIFile(filename: "/usr/lib/gcc/x86_64-linux-gnu/9/../../../../include/c++/9/bits/std_abs.h", directory: "")
!20 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !13, entity: !21, file: !23, line: 127)
!21 = !DIDerivedType(tag: DW_TAG_typedef, name: "div_t", file: !15, line: 62, baseType: !22)
!22 = distinct !DICompositeType(tag: DW_TAG_structure_type, file: !15, line: 58, size: 64, flags: DIFlagFwdDecl, identifier: "_ZTS5div_t")
!23 = !DIFile(filename: "/usr/lib/gcc/x86_64-linux-gnu/9/../../../../include/c++/9/cstdlib", directory: "")
!24 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !13, entity: !25, file: !23, line: 128)
!25 = !DIDerivedType(tag: DW_TAG_typedef, name: "ldiv_t", file: !15, line: 70, baseType: !26)
!26 = distinct !DICompositeType(tag: DW_TAG_structure_type, file: !15, line: 66, size: 128, flags: DIFlagTypePassByValue, elements: !27, identifier: "_ZTS6ldiv_t")
!27 = !{!28, !30}
!28 = !DIDerivedType(tag: DW_TAG_member, name: "quot", scope: !26, file: !15, line: 68, baseType: !29, size: 64)
!29 = !DIBasicType(name: "long", size: 64, encoding: DW_ATE_signed)
!30 = !DIDerivedType(tag: DW_TAG_member, name: "rem", scope: !26, file: !15, line: 69, baseType: !29, size: 64, offset: 64)
!31 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !13, entity: !32, file: !23, line: 130)
!32 = !DISubprogram(name: "abort", scope: !15, file: !15, line: 591, type: !33, flags: DIFlagPrototyped | DIFlagNoReturn, spFlags: 0)
!33 = !DISubroutineType(types: !34)
!34 = !{null}
!35 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !13, entity: !36, file: !23, line: 132)
!36 = !DISubprogram(name: "aligned_alloc", scope: !15, file: !15, line: 586, type: !37, flags: DIFlagPrototyped, spFlags: 0)
!37 = !DISubroutineType(types: !38)
!38 = !{!39, !40, !40}
!39 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: null, size: 64)
!40 = !DIDerivedType(tag: DW_TAG_typedef, name: "size_t", file: !41, line: 46, baseType: !42)
!41 = !DIFile(filename: "lib/clang/17/include/stddef.h", directory: "/home/cs23mtech12010/CCM/CCMutator/llvm-project/build", checksumkind: CSK_MD5, checksum: "d1776268f398bd1ca997c840ad581432")
!42 = !DIBasicType(name: "unsigned long", size: 64, encoding: DW_ATE_unsigned)
!43 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !13, entity: !44, file: !23, line: 134)
!44 = !DISubprogram(name: "atexit", scope: !15, file: !15, line: 595, type: !45, flags: DIFlagPrototyped, spFlags: 0)
!45 = !DISubroutineType(types: !46)
!46 = !{!18, !47}
!47 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !33, size: 64)
!48 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !13, entity: !49, file: !23, line: 137)
!49 = !DISubprogram(name: "at_quick_exit", scope: !15, file: !15, line: 600, type: !45, flags: DIFlagPrototyped, spFlags: 0)
!50 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !13, entity: !51, file: !23, line: 140)
!51 = !DISubprogram(name: "atof", scope: !15, file: !15, line: 101, type: !52, flags: DIFlagPrototyped, spFlags: 0)
!52 = !DISubroutineType(types: !53)
!53 = !{!54, !55}
!54 = !DIBasicType(name: "double", size: 64, encoding: DW_ATE_float)
!55 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !4, size: 64)
!56 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !13, entity: !57, file: !23, line: 141)
!57 = !DISubprogram(name: "atoi", scope: !15, file: !15, line: 104, type: !58, flags: DIFlagPrototyped, spFlags: 0)
!58 = !DISubroutineType(types: !59)
!59 = !{!18, !55}
!60 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !13, entity: !61, file: !23, line: 142)
!61 = !DISubprogram(name: "atol", scope: !15, file: !15, line: 107, type: !62, flags: DIFlagPrototyped, spFlags: 0)
!62 = !DISubroutineType(types: !63)
!63 = !{!29, !55}
!64 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !13, entity: !65, file: !23, line: 143)
!65 = !DISubprogram(name: "bsearch", scope: !15, file: !15, line: 820, type: !66, flags: DIFlagPrototyped, spFlags: 0)
!66 = !DISubroutineType(types: !67)
!67 = !{!39, !68, !68, !40, !40, !70}
!68 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !69, size: 64)
!69 = !DIDerivedType(tag: DW_TAG_const_type, baseType: null)
!70 = !DIDerivedType(tag: DW_TAG_typedef, name: "__compar_fn_t", file: !15, line: 808, baseType: !71)
!71 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !72, size: 64)
!72 = !DISubroutineType(types: !73)
!73 = !{!18, !68, !68}
!74 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !13, entity: !75, file: !23, line: 144)
!75 = !DISubprogram(name: "calloc", scope: !15, file: !15, line: 542, type: !37, flags: DIFlagPrototyped, spFlags: 0)
!76 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !13, entity: !77, file: !23, line: 145)
!77 = !DISubprogram(name: "div", scope: !15, file: !15, line: 852, type: !78, flags: DIFlagPrototyped, spFlags: 0)
!78 = !DISubroutineType(types: !79)
!79 = !{!21, !18, !18}
!80 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !13, entity: !81, file: !23, line: 146)
!81 = !DISubprogram(name: "exit", scope: !15, file: !15, line: 617, type: !82, flags: DIFlagPrototyped | DIFlagNoReturn, spFlags: 0)
!82 = !DISubroutineType(types: !83)
!83 = !{null, !18}
!84 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !13, entity: !85, file: !23, line: 147)
!85 = !DISubprogram(name: "free", scope: !15, file: !15, line: 565, type: !86, flags: DIFlagPrototyped, spFlags: 0)
!86 = !DISubroutineType(types: !87)
!87 = !{null, !39}
!88 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !13, entity: !89, file: !23, line: 148)
!89 = !DISubprogram(name: "getenv", scope: !15, file: !15, line: 634, type: !90, flags: DIFlagPrototyped, spFlags: 0)
!90 = !DISubroutineType(types: !91)
!91 = !{!92, !55}
!92 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !5, size: 64)
!93 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !13, entity: !94, file: !23, line: 149)
!94 = !DISubprogram(name: "labs", scope: !15, file: !15, line: 841, type: !95, flags: DIFlagPrototyped, spFlags: 0)
!95 = !DISubroutineType(types: !96)
!96 = !{!29, !29}
!97 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !13, entity: !98, file: !23, line: 150)
!98 = !DISubprogram(name: "ldiv", scope: !15, file: !15, line: 854, type: !99, flags: DIFlagPrototyped, spFlags: 0)
!99 = !DISubroutineType(types: !100)
!100 = !{!25, !29, !29}
!101 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !13, entity: !102, file: !23, line: 151)
!102 = !DISubprogram(name: "malloc", scope: !15, file: !15, line: 539, type: !103, flags: DIFlagPrototyped, spFlags: 0)
!103 = !DISubroutineType(types: !104)
!104 = !{!39, !40}
!105 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !13, entity: !106, file: !23, line: 153)
!106 = !DISubprogram(name: "mblen", scope: !15, file: !15, line: 922, type: !107, flags: DIFlagPrototyped, spFlags: 0)
!107 = !DISubroutineType(types: !108)
!108 = !{!18, !55, !40}
!109 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !13, entity: !110, file: !23, line: 154)
!110 = !DISubprogram(name: "mbstowcs", scope: !15, file: !15, line: 933, type: !111, flags: DIFlagPrototyped, spFlags: 0)
!111 = !DISubroutineType(types: !112)
!112 = !{!40, !113, !116, !40}
!113 = !DIDerivedType(tag: DW_TAG_restrict_type, baseType: !114)
!114 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !115, size: 64)
!115 = !DIBasicType(name: "wchar_t", size: 32, encoding: DW_ATE_signed)
!116 = !DIDerivedType(tag: DW_TAG_restrict_type, baseType: !55)
!117 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !13, entity: !118, file: !23, line: 155)
!118 = !DISubprogram(name: "mbtowc", scope: !15, file: !15, line: 925, type: !119, flags: DIFlagPrototyped, spFlags: 0)
!119 = !DISubroutineType(types: !120)
!120 = !{!18, !113, !116, !40}
!121 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !13, entity: !122, file: !23, line: 157)
!122 = !DISubprogram(name: "qsort", scope: !15, file: !15, line: 830, type: !123, flags: DIFlagPrototyped, spFlags: 0)
!123 = !DISubroutineType(types: !124)
!124 = !{null, !39, !40, !40, !70}
!125 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !13, entity: !126, file: !23, line: 160)
!126 = !DISubprogram(name: "quick_exit", scope: !15, file: !15, line: 623, type: !82, flags: DIFlagPrototyped | DIFlagNoReturn, spFlags: 0)
!127 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !13, entity: !128, file: !23, line: 163)
!128 = !DISubprogram(name: "rand", scope: !15, file: !15, line: 453, type: !129, flags: DIFlagPrototyped, spFlags: 0)
!129 = !DISubroutineType(types: !130)
!130 = !{!18}
!131 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !13, entity: !132, file: !23, line: 164)
!132 = !DISubprogram(name: "realloc", scope: !15, file: !15, line: 550, type: !133, flags: DIFlagPrototyped, spFlags: 0)
!133 = !DISubroutineType(types: !134)
!134 = !{!39, !39, !40}
!135 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !13, entity: !136, file: !23, line: 165)
!136 = !DISubprogram(name: "srand", scope: !15, file: !15, line: 455, type: !137, flags: DIFlagPrototyped, spFlags: 0)
!137 = !DISubroutineType(types: !138)
!138 = !{null, !139}
!139 = !DIBasicType(name: "unsigned int", size: 32, encoding: DW_ATE_unsigned)
!140 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !13, entity: !141, file: !23, line: 166)
!141 = !DISubprogram(name: "strtod", scope: !15, file: !15, line: 117, type: !142, flags: DIFlagPrototyped, spFlags: 0)
!142 = !DISubroutineType(types: !143)
!143 = !{!54, !116, !144}
!144 = !DIDerivedType(tag: DW_TAG_restrict_type, baseType: !145)
!145 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !92, size: 64)
!146 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !13, entity: !147, file: !23, line: 167)
!147 = !DISubprogram(name: "strtol", scope: !15, file: !15, line: 176, type: !148, flags: DIFlagPrototyped, spFlags: 0)
!148 = !DISubroutineType(types: !149)
!149 = !{!29, !116, !144, !18}
!150 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !13, entity: !151, file: !23, line: 168)
!151 = !DISubprogram(name: "strtoul", scope: !15, file: !15, line: 180, type: !152, flags: DIFlagPrototyped, spFlags: 0)
!152 = !DISubroutineType(types: !153)
!153 = !{!42, !116, !144, !18}
!154 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !13, entity: !155, file: !23, line: 169)
!155 = !DISubprogram(name: "system", scope: !15, file: !15, line: 784, type: !58, flags: DIFlagPrototyped, spFlags: 0)
!156 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !13, entity: !157, file: !23, line: 171)
!157 = !DISubprogram(name: "wcstombs", scope: !15, file: !15, line: 936, type: !158, flags: DIFlagPrototyped, spFlags: 0)
!158 = !DISubroutineType(types: !159)
!159 = !{!40, !160, !161, !40}
!160 = !DIDerivedType(tag: DW_TAG_restrict_type, baseType: !92)
!161 = !DIDerivedType(tag: DW_TAG_restrict_type, baseType: !162)
!162 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !163, size: 64)
!163 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !115)
!164 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !13, entity: !165, file: !23, line: 172)
!165 = !DISubprogram(name: "wctomb", scope: !15, file: !15, line: 929, type: !166, flags: DIFlagPrototyped, spFlags: 0)
!166 = !DISubroutineType(types: !167)
!167 = !{!18, !92, !115}
!168 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !169, entity: !170, file: !23, line: 200)
!169 = !DINamespace(name: "__gnu_cxx", scope: null)
!170 = !DIDerivedType(tag: DW_TAG_typedef, name: "lldiv_t", file: !15, line: 80, baseType: !171)
!171 = distinct !DICompositeType(tag: DW_TAG_structure_type, file: !15, line: 76, size: 128, flags: DIFlagTypePassByValue, elements: !172, identifier: "_ZTS7lldiv_t")
!172 = !{!173, !175}
!173 = !DIDerivedType(tag: DW_TAG_member, name: "quot", scope: !171, file: !15, line: 78, baseType: !174, size: 64)
!174 = !DIBasicType(name: "long long", size: 64, encoding: DW_ATE_signed)
!175 = !DIDerivedType(tag: DW_TAG_member, name: "rem", scope: !171, file: !15, line: 79, baseType: !174, size: 64, offset: 64)
!176 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !169, entity: !177, file: !23, line: 206)
!177 = !DISubprogram(name: "_Exit", scope: !15, file: !15, line: 629, type: !82, flags: DIFlagPrototyped | DIFlagNoReturn, spFlags: 0)
!178 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !169, entity: !179, file: !23, line: 210)
!179 = !DISubprogram(name: "llabs", scope: !15, file: !15, line: 844, type: !180, flags: DIFlagPrototyped, spFlags: 0)
!180 = !DISubroutineType(types: !181)
!181 = !{!174, !174}
!182 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !169, entity: !183, file: !23, line: 216)
!183 = !DISubprogram(name: "lldiv", scope: !15, file: !15, line: 858, type: !184, flags: DIFlagPrototyped, spFlags: 0)
!184 = !DISubroutineType(types: !185)
!185 = !{!170, !174, !174}
!186 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !169, entity: !187, file: !23, line: 227)
!187 = !DISubprogram(name: "atoll", scope: !15, file: !15, line: 112, type: !188, flags: DIFlagPrototyped, spFlags: 0)
!188 = !DISubroutineType(types: !189)
!189 = !{!174, !55}
!190 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !169, entity: !191, file: !23, line: 228)
!191 = !DISubprogram(name: "strtoll", scope: !15, file: !15, line: 200, type: !192, flags: DIFlagPrototyped, spFlags: 0)
!192 = !DISubroutineType(types: !193)
!193 = !{!174, !116, !144, !18}
!194 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !169, entity: !195, file: !23, line: 229)
!195 = !DISubprogram(name: "strtoull", scope: !15, file: !15, line: 205, type: !196, flags: DIFlagPrototyped, spFlags: 0)
!196 = !DISubroutineType(types: !197)
!197 = !{!198, !116, !144, !18}
!198 = !DIBasicType(name: "unsigned long long", size: 64, encoding: DW_ATE_unsigned)
!199 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !169, entity: !200, file: !23, line: 231)
!200 = !DISubprogram(name: "strtof", scope: !15, file: !15, line: 123, type: !201, flags: DIFlagPrototyped, spFlags: 0)
!201 = !DISubroutineType(types: !202)
!202 = !{!203, !116, !144}
!203 = !DIBasicType(name: "float", size: 32, encoding: DW_ATE_float)
!204 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !169, entity: !205, file: !23, line: 232)
!205 = !DISubprogram(name: "strtold", scope: !15, file: !15, line: 126, type: !206, flags: DIFlagPrototyped, spFlags: 0)
!206 = !DISubroutineType(types: !207)
!207 = !{!208, !116, !144}
!208 = !DIBasicType(name: "long double", size: 128, encoding: DW_ATE_float)
!209 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !13, entity: !170, file: !23, line: 240)
!210 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !13, entity: !177, file: !23, line: 242)
!211 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !13, entity: !179, file: !23, line: 244)
!212 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !13, entity: !213, file: !23, line: 245)
!213 = !DISubprogram(name: "div", linkageName: "_ZN9__gnu_cxx3divExx", scope: !169, file: !23, line: 213, type: !184, flags: DIFlagPrototyped, spFlags: 0)
!214 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !13, entity: !183, file: !23, line: 246)
!215 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !13, entity: !187, file: !23, line: 248)
!216 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !13, entity: !200, file: !23, line: 249)
!217 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !13, entity: !191, file: !23, line: 250)
!218 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !13, entity: !195, file: !23, line: 251)
!219 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !13, entity: !205, file: !23, line: 252)
!220 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !8, entity: !32, file: !221, line: 38)
!221 = !DIFile(filename: "/usr/lib/gcc/x86_64-linux-gnu/9/../../../../include/c++/9/stdlib.h", directory: "", checksumkind: CSK_MD5, checksum: "4cd0241d66f1b357b386fcd60bc71b0f")
!222 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !8, entity: !44, file: !221, line: 39)
!223 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !8, entity: !81, file: !221, line: 40)
!224 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !8, entity: !49, file: !221, line: 43)
!225 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !8, entity: !126, file: !221, line: 46)
!226 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !8, entity: !21, file: !221, line: 51)
!227 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !8, entity: !25, file: !221, line: 52)
!228 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !8, entity: !229, file: !221, line: 54)
!229 = !DISubprogram(name: "abs", linkageName: "_ZSt3absg", scope: !13, file: !19, line: 103, type: !230, flags: DIFlagPrototyped, spFlags: 0)
!230 = !DISubroutineType(types: !231)
!231 = !{!232, !232}
!232 = !DIBasicType(name: "__float128", size: 128, encoding: DW_ATE_float)
!233 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !8, entity: !51, file: !221, line: 55)
!234 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !8, entity: !57, file: !221, line: 56)
!235 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !8, entity: !61, file: !221, line: 57)
!236 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !8, entity: !65, file: !221, line: 58)
!237 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !8, entity: !75, file: !221, line: 59)
!238 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !8, entity: !213, file: !221, line: 60)
!239 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !8, entity: !85, file: !221, line: 61)
!240 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !8, entity: !89, file: !221, line: 62)
!241 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !8, entity: !94, file: !221, line: 63)
!242 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !8, entity: !98, file: !221, line: 64)
!243 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !8, entity: !102, file: !221, line: 65)
!244 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !8, entity: !106, file: !221, line: 67)
!245 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !8, entity: !110, file: !221, line: 68)
!246 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !8, entity: !118, file: !221, line: 69)
!247 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !8, entity: !122, file: !221, line: 71)
!248 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !8, entity: !128, file: !221, line: 72)
!249 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !8, entity: !132, file: !221, line: 73)
!250 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !8, entity: !136, file: !221, line: 74)
!251 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !8, entity: !141, file: !221, line: 75)
!252 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !8, entity: !147, file: !221, line: 76)
!253 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !8, entity: !151, file: !221, line: 77)
!254 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !8, entity: !155, file: !221, line: 78)
!255 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !8, entity: !157, file: !221, line: 80)
!256 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !8, entity: !165, file: !221, line: 81)
!257 = !{i32 7, !"Dwarf Version", i32 5}
!258 = !{i32 2, !"Debug Info Version", i32 3}
!259 = !{i32 1, !"wchar_size", i32 4}
!260 = !{i32 8, !"PIC Level", i32 2}
!261 = !{i32 7, !"PIE Level", i32 2}
!262 = !{i32 7, !"uwtable", i32 2}
!263 = !{i32 7, !"frame-pointer", i32 2}
!264 = !{!"clang version 17.0.0 (https://github.com/llvm/llvm-project.git 88bf774c565080e30e0a073676c316ab175303af)"}
!265 = distinct !DISubprogram(name: "threadFunction2", linkageName: "_Z15threadFunction2Pv", scope: !2, file: !2, line: 5, type: !266, scopeLine: 5, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !8, retainedNodes: !268)
!266 = !DISubroutineType(types: !267)
!267 = !{!39, !39}
!268 = !{}
!269 = !DILocalVariable(name: "arg", arg: 1, scope: !265, file: !2, line: 5, type: !39)
!270 = !DILocation(line: 5, column: 29, scope: !265)
!271 = !DILocation(line: 6, column: 5, scope: !265)
!272 = !DILocation(line: 7, column: 5, scope: !265)
!273 = distinct !DISubprogram(name: "fun3", linkageName: "_Z4fun3PPi", scope: !2, file: !2, line: 10, type: !274, scopeLine: 10, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !8, retainedNodes: !268)
!274 = !DISubroutineType(types: !275)
!275 = !{null, !276}
!276 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !277, size: 64)
!277 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !18, size: 64)
!278 = !DILocalVariable(name: "i", arg: 1, scope: !273, file: !2, line: 10, type: !276)
!279 = !DILocation(line: 10, column: 17, scope: !273)
!280 = !DILocalVariable(name: "a", scope: !273, file: !2, line: 12, type: !277)
!281 = !DILocation(line: 12, column: 10, scope: !273)
!282 = !DILocation(line: 13, column: 8, scope: !273)
!283 = !DILocation(line: 13, column: 7, scope: !273)
!284 = !DILocation(line: 13, column: 6, scope: !273)
!285 = !DILocalVariable(name: "thread2", scope: !273, file: !2, line: 14, type: !286)
!286 = !DIDerivedType(tag: DW_TAG_typedef, name: "pthread_t", file: !287, line: 27, baseType: !42)
!287 = !DIFile(filename: "/usr/include/x86_64-linux-gnu/bits/pthreadtypes.h", directory: "", checksumkind: CSK_MD5, checksum: "2d764266ce95ab26d4a4767c2ec78176")
!288 = !DILocation(line: 14, column: 23, scope: !273)
!289 = !DILocation(line: 15, column: 55, scope: !273)
!290 = !DILocation(line: 15, column: 54, scope: !273)
!291 = !DILocation(line: 15, column: 6, scope: !273)
!292 = !DILocation(line: 16, column: 5, scope: !273)
!293 = distinct !DISubprogram(name: "fun", linkageName: "_Z3funPi", scope: !2, file: !2, line: 20, type: !294, scopeLine: 20, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !8, retainedNodes: !268)
!294 = !DISubroutineType(types: !295)
!295 = !{null, !277}
!296 = !DILocalVariable(name: "i", arg: 1, scope: !293, file: !2, line: 20, type: !277)
!297 = !DILocation(line: 20, column: 15, scope: !293)
!298 = !DILocalVariable(name: "a", scope: !293, file: !2, line: 22, type: !277)
!299 = !DILocation(line: 22, column: 10, scope: !293)
!300 = !DILocation(line: 23, column: 7, scope: !293)
!301 = !DILocation(line: 23, column: 6, scope: !293)
!302 = !DILocation(line: 25, column: 5, scope: !293)
!303 = distinct !DISubprogram(name: "fun2", linkageName: "_Z4fun2PPi", scope: !2, file: !2, line: 28, type: !274, scopeLine: 28, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !8, retainedNodes: !268)
!304 = !DILocalVariable(name: "i", arg: 1, scope: !303, file: !2, line: 28, type: !276)
!305 = !DILocation(line: 28, column: 17, scope: !303)
!306 = !DILocalVariable(name: "a", scope: !303, file: !2, line: 30, type: !277)
!307 = !DILocation(line: 30, column: 10, scope: !303)
!308 = !DILocation(line: 31, column: 8, scope: !303)
!309 = !DILocation(line: 31, column: 7, scope: !303)
!310 = !DILocation(line: 31, column: 6, scope: !303)
!311 = !DILocation(line: 33, column: 10, scope: !303)
!312 = !DILocation(line: 33, column: 5, scope: !303)
!313 = !DILocation(line: 34, column: 5, scope: !303)
!314 = distinct !DISubprogram(name: "main", scope: !2, file: !2, line: 44, type: !129, scopeLine: 44, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !8, retainedNodes: !268)
!315 = !DILocalVariable(name: "thread1", scope: !314, file: !2, line: 45, type: !286)
!316 = !DILocation(line: 45, column: 15, scope: !314)
!317 = !DILocalVariable(name: "thread2", scope: !314, file: !2, line: 45, type: !286)
!318 = !DILocation(line: 45, column: 23, scope: !314)
!319 = !DILocalVariable(name: "c", scope: !314, file: !2, line: 46, type: !18)
!320 = !DILocation(line: 46, column: 5, scope: !314)
!321 = !DILocalVariable(name: "a", scope: !314, file: !2, line: 48, type: !276)
!322 = !DILocation(line: 48, column: 7, scope: !314)
!323 = !DILocalVariable(name: "b", scope: !314, file: !2, line: 48, type: !277)
!324 = !DILocation(line: 48, column: 10, scope: !314)
!325 = !DILocation(line: 50, column: 2, scope: !314)
!326 = !DILocation(line: 51, column: 2, scope: !314)
!327 = !DILocation(line: 53, column: 4, scope: !314)
!328 = !DILocation(line: 53, column: 3, scope: !314)
!329 = !DILocation(line: 53, column: 6, scope: !314)
!330 = !DILocalVariable(name: "d", scope: !314, file: !2, line: 57, type: !276)
!331 = !DILocation(line: 57, column: 7, scope: !314)
!332 = !DILocation(line: 59, column: 3, scope: !314)
!333 = !DILocation(line: 59, column: 2, scope: !314)
!334 = !DILocation(line: 60, column: 6, scope: !314)
!335 = !DILocation(line: 60, column: 1, scope: !314)
!336 = !DILocation(line: 63, column: 5, scope: !314)
!337 = !DILocation(line: 66, column: 5, scope: !314)
!338 = !DILocation(line: 68, column: 8, scope: !339)
!339 = distinct !DILexicalBlock(scope: !314, file: !2, line: 68, column: 8)
!340 = !DILocation(line: 68, column: 10, scope: !339)
!341 = !DILocation(line: 68, column: 9, scope: !339)
!342 = !DILocation(line: 68, column: 12, scope: !339)
!343 = !DILocation(line: 68, column: 13, scope: !339)
!344 = !DILocation(line: 68, column: 11, scope: !339)
!345 = !DILocation(line: 68, column: 8, scope: !314)
!346 = !DILocation(line: 71, column: 22, scope: !347)
!347 = distinct !DILexicalBlock(scope: !339, file: !2, line: 68, column: 16)
!348 = !DILocation(line: 71, column: 9, scope: !347)
!349 = !DILocation(line: 72, column: 22, scope: !347)
!350 = !DILocation(line: 72, column: 9, scope: !347)
!351 = !DILocation(line: 75, column: 5, scope: !347)
!352 = !DILocation(line: 79, column: 19, scope: !353)
!353 = distinct !DILexicalBlock(scope: !339, file: !2, line: 78, column: 9)
!354 = !DILocation(line: 79, column: 6, scope: !353)
!355 = !DILocation(line: 91, column: 5, scope: !314)
