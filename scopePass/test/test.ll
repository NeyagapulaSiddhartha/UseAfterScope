; ModuleID = '/home/cs23mtech12010/CCM/CCMutator/llvm-project/llvm/lib/Transforms/scopePass/test/test.ll'
source_filename = "/home/cs23mtech12010/CCM/CCMutator/llvm-project/llvm/lib/Transforms/scopePass/test/test.cpp"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: mustprogress noinline nounwind optnone uwtable
define dso_local void @_Z3funPi(ptr noundef %0) #0 !dbg !10 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  call void @llvm.dbg.declare(metadata ptr %2, metadata !17, metadata !DIExpression()), !dbg !18
  ret void, !dbg !19
}

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: mustprogress noinline nounwind optnone uwtable
define dso_local noundef i32 @_Z3foov() #0 !dbg !20 {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  %3 = alloca ptr, align 8
  %4 = alloca ptr, align 8
  call void @llvm.dbg.declare(metadata ptr %1, metadata !23, metadata !DIExpression()), !dbg !24
  store i32 6, ptr %1, align 4, !dbg !24
  call void @llvm.dbg.declare(metadata ptr %2, metadata !25, metadata !DIExpression()), !dbg !26
  store i32 8, ptr %2, align 4, !dbg !26
  call void @llvm.dbg.declare(metadata ptr %3, metadata !27, metadata !DIExpression()), !dbg !28
  store ptr %1, ptr %3, align 8, !dbg !28
  call void @llvm.dbg.declare(metadata ptr %4, metadata !29, metadata !DIExpression()), !dbg !30
  store ptr %2, ptr %4, align 8, !dbg !30
  %5 = load ptr, ptr %3, align 8, !dbg !31
  %6 = load i32, ptr %5, align 4, !dbg !32
  %7 = add nsw i32 %6, 1, !dbg !32
  store i32 %7, ptr %5, align 4, !dbg !32
  %8 = load ptr, ptr %4, align 8, !dbg !33
  %9 = load i32, ptr %8, align 4, !dbg !34
  %10 = add nsw i32 %9, 1, !dbg !34
  store i32 %10, ptr %8, align 4, !dbg !34
  store ptr %2, ptr %3, align 8, !dbg !35
  %11 = load ptr, ptr %3, align 8, !dbg !36
  %12 = load i32, ptr %11, align 4, !dbg !37
  %13 = add nsw i32 %12, 1, !dbg !37
  store i32 %13, ptr %11, align 4, !dbg !37
  %14 = load ptr, ptr %3, align 8, !dbg !38
  call void @_Z3funPi(ptr noundef %14), !dbg !39
  ret i32 1, !dbg !40
}

attributes #0 = { mustprogress noinline nounwind optnone uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!2, !3, !4, !5, !6, !7, !8}
!llvm.ident = !{!9}

!0 = distinct !DICompileUnit(language: DW_LANG_C_plus_plus_14, file: !1, producer: "clang version 17.0.0 (https://github.com/llvm/llvm-project.git 88bf774c565080e30e0a073676c316ab175303af)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, splitDebugInlining: false, nameTableKind: None)
!1 = !DIFile(filename: "/home/cs23mtech12010/CCM/CCMutator/llvm-project/llvm/lib/Transforms/scopePass/test/test.cpp", directory: "/home/cs23mtech12010/CCM/CCMutator/llvm-project/build", checksumkind: CSK_MD5, checksum: "a3d35204eacc602e1a7de61142731065")
!2 = !{i32 7, !"Dwarf Version", i32 5}
!3 = !{i32 2, !"Debug Info Version", i32 3}
!4 = !{i32 1, !"wchar_size", i32 4}
!5 = !{i32 8, !"PIC Level", i32 2}
!6 = !{i32 7, !"PIE Level", i32 2}
!7 = !{i32 7, !"uwtable", i32 2}
!8 = !{i32 7, !"frame-pointer", i32 2}
!9 = !{!"clang version 17.0.0 (https://github.com/llvm/llvm-project.git 88bf774c565080e30e0a073676c316ab175303af)"}
!10 = distinct !DISubprogram(name: "fun", linkageName: "_Z3funPi", scope: !11, file: !11, line: 1, type: !12, scopeLine: 1, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !16)
!11 = !DIFile(filename: "llvm/lib/Transforms/scopePass/test/test.cpp", directory: "/home/cs23mtech12010/CCM/CCMutator/llvm-project", checksumkind: CSK_MD5, checksum: "a3d35204eacc602e1a7de61142731065")
!12 = !DISubroutineType(types: !13)
!13 = !{null, !14}
!14 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !15, size: 64)
!15 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!16 = !{}
!17 = !DILocalVariable(name: "i", arg: 1, scope: !10, file: !11, line: 1, type: !14)
!18 = !DILocation(line: 1, column: 15, scope: !10)
!19 = !DILocation(line: 2, column: 5, scope: !10)
!20 = distinct !DISubprogram(name: "foo", linkageName: "_Z3foov", scope: !11, file: !11, line: 4, type: !21, scopeLine: 4, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !16)
!21 = !DISubroutineType(types: !22)
!22 = !{!15}
!23 = !DILocalVariable(name: "i", scope: !20, file: !11, line: 6, type: !15)
!24 = !DILocation(line: 6, column: 9, scope: !20)
!25 = !DILocalVariable(name: "j", scope: !20, file: !11, line: 7, type: !15)
!26 = !DILocation(line: 7, column: 9, scope: !20)
!27 = !DILocalVariable(name: "p", scope: !20, file: !11, line: 9, type: !14)
!28 = !DILocation(line: 9, column: 10, scope: !20)
!29 = !DILocalVariable(name: "q", scope: !20, file: !11, line: 11, type: !14)
!30 = !DILocation(line: 11, column: 9, scope: !20)
!31 = !DILocation(line: 13, column: 6, scope: !20)
!32 = !DILocation(line: 13, column: 8, scope: !20)
!33 = !DILocation(line: 14, column: 6, scope: !20)
!34 = !DILocation(line: 14, column: 8, scope: !20)
!35 = !DILocation(line: 16, column: 6, scope: !20)
!36 = !DILocation(line: 18, column: 7, scope: !20)
!37 = !DILocation(line: 18, column: 9, scope: !20)
!38 = !DILocation(line: 20, column: 9, scope: !20)
!39 = !DILocation(line: 20, column: 5, scope: !20)
!40 = !DILocation(line: 21, column: 5, scope: !20)
