; ModuleID = '/home/cs23mtech12010/CCM/CCMutator/llvm-project/llvm/lib/Transforms/scopePass/test/testContext.cpp'
source_filename = "/home/cs23mtech12010/CCM/CCMutator/llvm-project/llvm/lib/Transforms/scopePass/test/testContext.cpp"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: mustprogress noinline nounwind optnone uwtable
define dso_local void @_Z2f2Pi(ptr noundef %0) #0 !dbg !10 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  call void @llvm.dbg.declare(metadata ptr %2, metadata !17, metadata !DIExpression()), !dbg !18
  %3 = load ptr, ptr %2, align 8, !dbg !19
  %4 = load i32, ptr %3, align 4, !dbg !20
  %5 = add nsw i32 %4, 1, !dbg !20
  store i32 %5, ptr %3, align 4, !dbg !20
  ret void, !dbg !21
}

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: mustprogress noinline nounwind optnone uwtable
define dso_local void @_Z2f1Pi(ptr noundef %0) #0 !dbg !22 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  call void @llvm.dbg.declare(metadata ptr %2, metadata !23, metadata !DIExpression()), !dbg !24
  %3 = load ptr, ptr %2, align 8, !dbg !25
  %4 = load i32, ptr %3, align 4, !dbg !26
  %5 = add nsw i32 %4, 1, !dbg !26
  store i32 %5, ptr %3, align 4, !dbg !26
  %6 = load ptr, ptr %2, align 8, !dbg !27
  call void @_Z2f2Pi(ptr noundef %6), !dbg !28
  ret void, !dbg !29
}

; Function Attrs: mustprogress noinline norecurse nounwind optnone uwtable
define dso_local noundef i32 @main() #2 !dbg !30 {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  %4 = alloca ptr, align 8
  %5 = alloca ptr, align 8
  %6 = alloca ptr, align 8
  store i32 0, ptr %1, align 4
  call void @llvm.dbg.declare(metadata ptr %2, metadata !33, metadata !DIExpression()), !dbg !34
  call void @llvm.dbg.declare(metadata ptr %3, metadata !35, metadata !DIExpression()), !dbg !36
  store i32 9, ptr %3, align 4, !dbg !36
  call void @llvm.dbg.declare(metadata ptr %4, metadata !37, metadata !DIExpression()), !dbg !39
  call void @llvm.dbg.declare(metadata ptr %5, metadata !40, metadata !DIExpression()), !dbg !41
  store ptr %3, ptr %5, align 8, !dbg !42
  store ptr %5, ptr %4, align 8, !dbg !43
  %7 = load ptr, ptr %4, align 8, !dbg !44
  %8 = load ptr, ptr %7, align 8, !dbg !45
  %9 = load i32, ptr %8, align 4, !dbg !46
  %10 = add nsw i32 %9, 1, !dbg !46
  store i32 %10, ptr %8, align 4, !dbg !46
  call void @llvm.dbg.declare(metadata ptr %6, metadata !47, metadata !DIExpression()), !dbg !48
  %11 = load ptr, ptr %4, align 8, !dbg !49
  store ptr %11, ptr %6, align 8, !dbg !50
  %12 = load i32, ptr %3, align 4, !dbg !51
  %13 = add nsw i32 %12, 1, !dbg !51
  store i32 %13, ptr %3, align 4, !dbg !51
  ret i32 0, !dbg !52
}

attributes #0 = { mustprogress noinline nounwind optnone uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #2 = { mustprogress noinline norecurse nounwind optnone uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!2, !3, !4, !5, !6, !7, !8}
!llvm.ident = !{!9}

!0 = distinct !DICompileUnit(language: DW_LANG_C_plus_plus_14, file: !1, producer: "clang version 17.0.0 (https://github.com/llvm/llvm-project.git 88bf774c565080e30e0a073676c316ab175303af)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, splitDebugInlining: false, nameTableKind: None)
!1 = !DIFile(filename: "/home/cs23mtech12010/CCM/CCMutator/llvm-project/llvm/lib/Transforms/scopePass/test/testContext.cpp", directory: "/home/cs23mtech12010/CCM/CCMutator/llvm-project/build", checksumkind: CSK_MD5, checksum: "7e136392adcd89ea68eacb2b59793082")
!2 = !{i32 7, !"Dwarf Version", i32 5}
!3 = !{i32 2, !"Debug Info Version", i32 3}
!4 = !{i32 1, !"wchar_size", i32 4}
!5 = !{i32 8, !"PIC Level", i32 2}
!6 = !{i32 7, !"PIE Level", i32 2}
!7 = !{i32 7, !"uwtable", i32 2}
!8 = !{i32 7, !"frame-pointer", i32 2}
!9 = !{!"clang version 17.0.0 (https://github.com/llvm/llvm-project.git 88bf774c565080e30e0a073676c316ab175303af)"}
!10 = distinct !DISubprogram(name: "f2", linkageName: "_Z2f2Pi", scope: !11, file: !11, line: 1, type: !12, scopeLine: 1, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !16)
!11 = !DIFile(filename: "llvm/lib/Transforms/scopePass/test/testContext.cpp", directory: "/home/cs23mtech12010/CCM/CCMutator/llvm-project", checksumkind: CSK_MD5, checksum: "7e136392adcd89ea68eacb2b59793082")
!12 = !DISubroutineType(types: !13)
!13 = !{null, !14}
!14 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !15, size: 64)
!15 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!16 = !{}
!17 = !DILocalVariable(name: "i", arg: 1, scope: !10, file: !11, line: 1, type: !14)
!18 = !DILocation(line: 1, column: 14, scope: !10)
!19 = !DILocation(line: 3, column: 7, scope: !10)
!20 = !DILocation(line: 3, column: 9, scope: !10)
!21 = !DILocation(line: 5, column: 1, scope: !10)
!22 = distinct !DISubprogram(name: "f1", linkageName: "_Z2f1Pi", scope: !11, file: !11, line: 7, type: !12, scopeLine: 7, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !16)
!23 = !DILocalVariable(name: "i", arg: 1, scope: !22, file: !11, line: 7, type: !14)
!24 = !DILocation(line: 7, column: 14, scope: !22)
!25 = !DILocation(line: 9, column: 7, scope: !22)
!26 = !DILocation(line: 9, column: 9, scope: !22)
!27 = !DILocation(line: 12, column: 8, scope: !22)
!28 = !DILocation(line: 12, column: 5, scope: !22)
!29 = !DILocation(line: 13, column: 1, scope: !22)
!30 = distinct !DISubprogram(name: "main", scope: !11, file: !11, line: 16, type: !31, scopeLine: 16, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !16)
!31 = !DISubroutineType(types: !32)
!32 = !{!15}
!33 = !DILocalVariable(name: "a1", scope: !30, file: !11, line: 17, type: !15)
!34 = !DILocation(line: 17, column: 5, scope: !30)
!35 = !DILocalVariable(name: "c", scope: !30, file: !11, line: 18, type: !15)
!36 = !DILocation(line: 18, column: 5, scope: !30)
!37 = !DILocalVariable(name: "a", scope: !30, file: !11, line: 20, type: !38)
!38 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !14, size: 64)
!39 = !DILocation(line: 20, column: 7, scope: !30)
!40 = !DILocalVariable(name: "b", scope: !30, file: !11, line: 20, type: !14)
!41 = !DILocation(line: 20, column: 10, scope: !30)
!42 = !DILocation(line: 22, column: 2, scope: !30)
!43 = !DILocation(line: 23, column: 2, scope: !30)
!44 = !DILocation(line: 25, column: 4, scope: !30)
!45 = !DILocation(line: 25, column: 3, scope: !30)
!46 = !DILocation(line: 25, column: 6, scope: !30)
!47 = !DILocalVariable(name: "d", scope: !30, file: !11, line: 28, type: !38)
!48 = !DILocation(line: 28, column: 7, scope: !30)
!49 = !DILocation(line: 30, column: 3, scope: !30)
!50 = !DILocation(line: 30, column: 2, scope: !30)
!51 = !DILocation(line: 32, column: 2, scope: !30)
!52 = !DILocation(line: 36, column: 5, scope: !30)
