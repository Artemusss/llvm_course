; ModuleID = 'app_water.c'
source_filename = "app_water.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

; Function Attrs: nounwind uwtable
define dso_local void @drawBlock(i32 noundef %0, i32 noundef %1, i32 noundef %2) local_unnamed_addr #0 {
  %4 = mul nsw i32 %0, 3
  %5 = mul nsw i32 %1, 3
  tail call void @simPutPixel(i32 noundef %4, i32 noundef %5, i32 noundef %2) #8
  %6 = add nsw i32 %4, 1
  tail call void @simPutPixel(i32 noundef %6, i32 noundef %5, i32 noundef %2) #8
  %7 = add nsw i32 %4, 2
  tail call void @simPutPixel(i32 noundef %7, i32 noundef %5, i32 noundef %2) #8
  %8 = add nsw i32 %5, 1
  tail call void @simPutPixel(i32 noundef %4, i32 noundef %8, i32 noundef %2) #8
  tail call void @simPutPixel(i32 noundef %6, i32 noundef %8, i32 noundef %2) #8
  tail call void @simPutPixel(i32 noundef %7, i32 noundef %8, i32 noundef %2) #8
  %9 = add nsw i32 %5, 2
  tail call void @simPutPixel(i32 noundef %4, i32 noundef %9, i32 noundef %2) #8
  tail call void @simPutPixel(i32 noundef %6, i32 noundef %9, i32 noundef %2) #8
  tail call void @simPutPixel(i32 noundef %7, i32 noundef %9, i32 noundef %2) #8
  ret void
}

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.start.p0(i64 immarg, ptr nocapture) #1

declare void @simPutPixel(i32 noundef, i32 noundef, i32 noundef) local_unnamed_addr #2

; Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(none) uwtable
define dso_local i32 @shade(i32 noundef %0, i32 noundef %1) local_unnamed_addr #3 {
  %3 = ashr i32 %0, 3
  %4 = add nsw i32 %3, 120
  %5 = ashr i32 %1, 1
  %6 = add nsw i32 %4, %5
  %7 = tail call i32 @llvm.smax.i32(i32 %6, i32 0)
  %8 = tail call i32 @llvm.umin.i32(i32 %7, i32 255)
  %9 = shl nuw nsw i32 %8, 13
  %10 = and i32 %9, 2031616
  %11 = mul nuw nsw i32 %8, 160
  %12 = and i32 %11, 65280
  %13 = or disjoint i32 %12, %10
  %14 = or disjoint i32 %13, %8
  %15 = or disjoint i32 %14, -16777216
  ret i32 %15
}

; Function Attrs: nounwind uwtable
define dso_local void @render(ptr nocapture noundef readonly %0) local_unnamed_addr #0 {
  br label %2

2:                                                ; preds = %31, %1
  %3 = phi i64 [ 0, %1 ], [ %32, %31 ]
  %4 = shl nuw nsw i64 %3, 9
  %5 = shl i64 %3, 41
  %6 = ashr exact i64 %5, 32
  %7 = getelementptr inbounds i32, ptr %0, i64 %6
  %8 = load i32, ptr %7, align 4, !tbaa !5
  %9 = and i64 %4, 4294966784
  %10 = or disjoint i64 %9, 1
  %11 = getelementptr inbounds i32, ptr %0, i64 %10
  %12 = load i32, ptr %11, align 4, !tbaa !5
  %13 = sub nsw i32 %8, %12
  %14 = getelementptr inbounds i32, ptr %0, i64 %4
  %15 = load i32, ptr %14, align 4, !tbaa !5
  %16 = ashr i32 %15, 3
  %17 = add nsw i32 %16, 120
  %18 = ashr i32 %13, 1
  %19 = add nsw i32 %17, %18
  %20 = tail call i32 @llvm.smax.i32(i32 %19, i32 0)
  %21 = tail call i32 @llvm.umin.i32(i32 %20, i32 255)
  %22 = shl nuw nsw i32 %21, 13
  %23 = and i32 %22, 2031616
  %24 = mul nuw nsw i32 %21, 160
  %25 = and i32 %24, 65280
  %26 = or disjoint i32 %23, %25
  %27 = or disjoint i32 %26, %21
  %28 = or disjoint i32 %27, -16777216
  %29 = trunc i64 %3 to i32
  tail call void @drawBlock(i32 noundef 0, i32 noundef %29, i32 noundef %28)
  br label %34

30:                                               ; preds = %31
  ret void

31:                                               ; preds = %34
  %32 = add nuw nsw i64 %3, 1
  %33 = icmp eq i64 %32, 256
  br i1 %33, label %30, label %2, !llvm.loop !9

34:                                               ; preds = %2, %34
  %35 = phi i64 [ 1, %2 ], [ %65, %34 ]
  %36 = or disjoint i64 %35, %4
  %37 = icmp ne i64 %35, 511
  %38 = zext i1 %37 to i64
  %39 = add nuw i64 %36, %38
  %40 = shl i64 %36, 32
  %41 = add i64 %40, -4294967296
  %42 = ashr exact i64 %41, 32
  %43 = getelementptr inbounds i32, ptr %0, i64 %42
  %44 = load i32, ptr %43, align 4, !tbaa !5
  %45 = and i64 %39, 4294967295
  %46 = getelementptr inbounds i32, ptr %0, i64 %45
  %47 = load i32, ptr %46, align 4, !tbaa !5
  %48 = sub nsw i32 %44, %47
  %49 = getelementptr inbounds i32, ptr %0, i64 %36
  %50 = load i32, ptr %49, align 4, !tbaa !5
  %51 = ashr i32 %50, 3
  %52 = add nsw i32 %51, 120
  %53 = ashr i32 %48, 1
  %54 = add nsw i32 %52, %53
  %55 = tail call i32 @llvm.smax.i32(i32 %54, i32 0)
  %56 = tail call i32 @llvm.umin.i32(i32 %55, i32 255)
  %57 = shl nuw nsw i32 %56, 13
  %58 = and i32 %57, 2031616
  %59 = mul nuw nsw i32 %56, 160
  %60 = and i32 %59, 65280
  %61 = or disjoint i32 %58, %60
  %62 = or disjoint i32 %61, %56
  %63 = or disjoint i32 %62, -16777216
  %64 = trunc i64 %35 to i32
  tail call void @drawBlock(i32 noundef %64, i32 noundef %29, i32 noundef %63)
  %65 = add nuw nsw i64 %35, 1
  %66 = icmp eq i64 %65, 512
  br i1 %66, label %31, label %34, !llvm.loop !11
}

; Function Attrs: nofree norecurse nosync nounwind memory(argmem: readwrite) uwtable
define dso_local void @step(ptr nocapture noundef readonly %0, ptr nocapture noundef %1) local_unnamed_addr #4 {
  %3 = getelementptr i8, ptr %1, i64 2052
  %4 = getelementptr i8, ptr %1, i64 522236
  %5 = getelementptr i8, ptr %0, i64 4
  %6 = getelementptr i8, ptr %0, i64 524284
  %7 = icmp ult ptr %3, %6
  %8 = icmp ult ptr %5, %4
  %9 = and i1 %7, %8
  br label %10

10:                                               ; preds = %2, %57
  %11 = phi i64 [ 1, %2 ], [ %58, %57 ]
  %12 = shl nuw nsw i64 %11, 9
  br i1 %9, label %13, label %15

13:                                               ; preds = %15, %10
  %14 = phi i64 [ 1, %10 ], [ 505, %15 ]
  br label %60

15:                                               ; preds = %10, %15
  %16 = phi i64 [ %54, %15 ], [ 0, %10 ]
  %17 = or disjoint i64 %16, 1
  %18 = add nuw nsw i64 %17, %12
  %19 = getelementptr i32, ptr %0, i64 %18
  %20 = getelementptr i32, ptr %19, i64 -1
  %21 = getelementptr i32, ptr %19, i64 3
  %22 = load <4 x i32>, ptr %20, align 4, !tbaa !5, !alias.scope !13
  %23 = load <4 x i32>, ptr %21, align 4, !tbaa !5, !alias.scope !13
  %24 = getelementptr i32, ptr %19, i64 1
  %25 = getelementptr i32, ptr %19, i64 5
  %26 = load <4 x i32>, ptr %24, align 4, !tbaa !5, !alias.scope !13
  %27 = load <4 x i32>, ptr %25, align 4, !tbaa !5, !alias.scope !13
  %28 = add nsw <4 x i32> %26, %22
  %29 = add nsw <4 x i32> %27, %23
  %30 = getelementptr i32, ptr %19, i64 -512
  %31 = getelementptr i32, ptr %19, i64 -508
  %32 = load <4 x i32>, ptr %30, align 4, !tbaa !5, !alias.scope !13
  %33 = load <4 x i32>, ptr %31, align 4, !tbaa !5, !alias.scope !13
  %34 = add nsw <4 x i32> %28, %32
  %35 = add nsw <4 x i32> %29, %33
  %36 = getelementptr i32, ptr %19, i64 512
  %37 = getelementptr i32, ptr %19, i64 516
  %38 = load <4 x i32>, ptr %36, align 4, !tbaa !5, !alias.scope !13
  %39 = load <4 x i32>, ptr %37, align 4, !tbaa !5, !alias.scope !13
  %40 = add nsw <4 x i32> %34, %38
  %41 = add nsw <4 x i32> %35, %39
  %42 = ashr <4 x i32> %40, <i32 1, i32 1, i32 1, i32 1>
  %43 = ashr <4 x i32> %41, <i32 1, i32 1, i32 1, i32 1>
  %44 = getelementptr inbounds i32, ptr %1, i64 %18
  %45 = getelementptr inbounds i32, ptr %44, i64 4
  %46 = load <4 x i32>, ptr %44, align 4, !tbaa !5, !alias.scope !16, !noalias !13
  %47 = load <4 x i32>, ptr %45, align 4, !tbaa !5, !alias.scope !16, !noalias !13
  %48 = sub nsw <4 x i32> %42, %46
  %49 = sub nsw <4 x i32> %43, %47
  %50 = ashr <4 x i32> %48, <i32 6, i32 6, i32 6, i32 6>
  %51 = ashr <4 x i32> %49, <i32 6, i32 6, i32 6, i32 6>
  %52 = sub nsw <4 x i32> %48, %50
  %53 = sub nsw <4 x i32> %49, %51
  store <4 x i32> %52, ptr %44, align 4, !tbaa !5, !alias.scope !16, !noalias !13
  store <4 x i32> %53, ptr %45, align 4, !tbaa !5, !alias.scope !16, !noalias !13
  %54 = add nuw i64 %16, 8
  %55 = icmp eq i64 %54, 504
  br i1 %55, label %13, label %15, !llvm.loop !18

56:                                               ; preds = %57
  ret void

57:                                               ; preds = %60
  %58 = add nuw nsw i64 %11, 1
  %59 = icmp eq i64 %58, 255
  br i1 %59, label %56, label %10, !llvm.loop !21

60:                                               ; preds = %13, %60
  %61 = phi i64 [ %81, %60 ], [ %14, %13 ]
  %62 = add nuw nsw i64 %61, %12
  %63 = getelementptr i32, ptr %0, i64 %62
  %64 = getelementptr i32, ptr %63, i64 -1
  %65 = load i32, ptr %64, align 4, !tbaa !5
  %66 = getelementptr i32, ptr %63, i64 1
  %67 = load i32, ptr %66, align 4, !tbaa !5
  %68 = add nsw i32 %67, %65
  %69 = getelementptr i32, ptr %63, i64 -512
  %70 = load i32, ptr %69, align 4, !tbaa !5
  %71 = add nsw i32 %68, %70
  %72 = getelementptr i32, ptr %63, i64 512
  %73 = load i32, ptr %72, align 4, !tbaa !5
  %74 = add nsw i32 %71, %73
  %75 = ashr i32 %74, 1
  %76 = getelementptr inbounds i32, ptr %1, i64 %62
  %77 = load i32, ptr %76, align 4, !tbaa !5
  %78 = sub nsw i32 %75, %77
  %79 = ashr i32 %78, 6
  %80 = sub nsw i32 %78, %79
  store i32 %80, ptr %76, align 4, !tbaa !5
  %81 = add nuw nsw i64 %61, 1
  %82 = icmp eq i64 %81, 511
  br i1 %82, label %57, label %60, !llvm.loop !22
}

; Function Attrs: nofree norecurse nosync nounwind memory(argmem: readwrite) uwtable
define dso_local void @drop(ptr nocapture noundef %0, i32 noundef %1, i32 noundef %2, i32 noundef %3) local_unnamed_addr #4 {
  %5 = add i32 %1, -4
  %6 = icmp ult i32 %5, 510
  %7 = add nsw i32 %1, -3
  %8 = add i32 %1, -3
  %9 = icmp ult i32 %8, 510
  %10 = add nsw i32 %1, -2
  %11 = add i32 %1, -1
  %12 = add i32 %1, -2
  %13 = icmp ult i32 %12, 510
  %14 = icmp ult i32 %11, 510
  %15 = icmp ult i32 %1, 510
  %16 = add nuw nsw i32 %1, 1
  %17 = add i32 %1, 1
  %18 = icmp ult i32 %17, 510
  %19 = add nsw i32 %1, 2
  %20 = add i32 %1, 2
  %21 = icmp ult i32 %20, 510
  %22 = add nsw i32 %1, 3
  br label %23

23:                                               ; preds = %4, %92
  %24 = phi i32 [ -3, %4 ], [ %93, %92 ]
  %25 = add nsw i32 %24, %2
  %26 = icmp sgt i32 %25, 0
  %27 = icmp slt i32 %25, 255
  %28 = shl nuw nsw i32 %25, 9
  %29 = select i1 %6, i1 %26, i1 false
  %30 = select i1 %29, i1 %27, i1 false
  br i1 %30, label %32, label %38

31:                                               ; preds = %92
  ret void

32:                                               ; preds = %23
  %33 = add nuw nsw i32 %7, %28
  %34 = zext nneg i32 %33 to i64
  %35 = getelementptr inbounds i32, ptr %0, i64 %34
  %36 = load i32, ptr %35, align 4, !tbaa !5
  %37 = add nsw i32 %36, %3
  store i32 %37, ptr %35, align 4, !tbaa !5
  br label %38

38:                                               ; preds = %32, %23
  %39 = select i1 %9, i1 %26, i1 false
  %40 = select i1 %39, i1 %27, i1 false
  br i1 %40, label %41, label %47

41:                                               ; preds = %38
  %42 = add nuw nsw i32 %10, %28
  %43 = zext nneg i32 %42 to i64
  %44 = getelementptr inbounds i32, ptr %0, i64 %43
  %45 = load i32, ptr %44, align 4, !tbaa !5
  %46 = add nsw i32 %45, %3
  store i32 %46, ptr %44, align 4, !tbaa !5
  br label %47

47:                                               ; preds = %41, %38
  %48 = select i1 %13, i1 %26, i1 false
  %49 = select i1 %48, i1 %27, i1 false
  br i1 %49, label %50, label %56

50:                                               ; preds = %47
  %51 = add nuw nsw i32 %11, %28
  %52 = zext nneg i32 %51 to i64
  %53 = getelementptr inbounds i32, ptr %0, i64 %52
  %54 = load i32, ptr %53, align 4, !tbaa !5
  %55 = add nsw i32 %54, %3
  store i32 %55, ptr %53, align 4, !tbaa !5
  br label %56

56:                                               ; preds = %50, %47
  %57 = select i1 %14, i1 %26, i1 false
  %58 = select i1 %57, i1 %27, i1 false
  br i1 %58, label %59, label %65

59:                                               ; preds = %56
  %60 = add nuw nsw i32 %28, %1
  %61 = zext nneg i32 %60 to i64
  %62 = getelementptr inbounds i32, ptr %0, i64 %61
  %63 = load i32, ptr %62, align 4, !tbaa !5
  %64 = add nsw i32 %63, %3
  store i32 %64, ptr %62, align 4, !tbaa !5
  br label %65

65:                                               ; preds = %59, %56
  %66 = select i1 %15, i1 %26, i1 false
  %67 = select i1 %66, i1 %27, i1 false
  br i1 %67, label %68, label %74

68:                                               ; preds = %65
  %69 = add nuw nsw i32 %16, %28
  %70 = zext nneg i32 %69 to i64
  %71 = getelementptr inbounds i32, ptr %0, i64 %70
  %72 = load i32, ptr %71, align 4, !tbaa !5
  %73 = add nsw i32 %72, %3
  store i32 %73, ptr %71, align 4, !tbaa !5
  br label %74

74:                                               ; preds = %68, %65
  %75 = select i1 %18, i1 %26, i1 false
  %76 = select i1 %75, i1 %27, i1 false
  br i1 %76, label %77, label %83

77:                                               ; preds = %74
  %78 = add nuw nsw i32 %19, %28
  %79 = zext nneg i32 %78 to i64
  %80 = getelementptr inbounds i32, ptr %0, i64 %79
  %81 = load i32, ptr %80, align 4, !tbaa !5
  %82 = add nsw i32 %81, %3
  store i32 %82, ptr %80, align 4, !tbaa !5
  br label %83

83:                                               ; preds = %77, %74
  %84 = select i1 %21, i1 %26, i1 false
  %85 = select i1 %84, i1 %27, i1 false
  br i1 %85, label %86, label %92

86:                                               ; preds = %83
  %87 = add nuw nsw i32 %22, %28
  %88 = zext nneg i32 %87 to i64
  %89 = getelementptr inbounds i32, ptr %0, i64 %88
  %90 = load i32, ptr %89, align 4, !tbaa !5
  %91 = add nsw i32 %90, %3
  store i32 %91, ptr %89, align 4, !tbaa !5
  br label %92

92:                                               ; preds = %86, %83
  %93 = add nsw i32 %24, 1
  %94 = icmp eq i32 %93, 4
  br i1 %94, label %31, label %23, !llvm.loop !23
}

; Function Attrs: noreturn nounwind uwtable
define dso_local void @app() local_unnamed_addr #5 {
  %1 = alloca [131072 x i32], align 16
  %2 = alloca [131072 x i32], align 16
  call void @llvm.lifetime.start.p0(i64 524288, ptr nonnull %1) #8
  call void @llvm.memset.p0.i64(ptr noundef nonnull align 16 dereferenceable(524288) %1, i8 0, i64 524288, i1 false)
  call void @llvm.lifetime.start.p0(i64 524288, ptr nonnull %2) #8
  call void @llvm.memset.p0.i64(ptr noundef nonnull align 16 dereferenceable(524288) %2, i8 0, i64 524288, i1 false)
  %3 = getelementptr inbounds i32, ptr %1, i64 64253
  store <4 x i32> <i32 640, i32 640, i32 640, i32 640>, ptr %3, align 4, !tbaa !5
  %4 = getelementptr inbounds i32, ptr %1, i64 64257
  store i32 640, ptr %4, align 4, !tbaa !5
  %5 = getelementptr inbounds i32, ptr %1, i64 64258
  store i32 640, ptr %5, align 8, !tbaa !5
  %6 = getelementptr inbounds i32, ptr %1, i64 64259
  store i32 640, ptr %6, align 4, !tbaa !5
  %7 = getelementptr inbounds i32, ptr %1, i64 64765
  store <4 x i32> <i32 640, i32 640, i32 640, i32 640>, ptr %7, align 4, !tbaa !5
  %8 = getelementptr inbounds i32, ptr %1, i64 64769
  store i32 640, ptr %8, align 4, !tbaa !5
  %9 = getelementptr inbounds i32, ptr %1, i64 64770
  store i32 640, ptr %9, align 8, !tbaa !5
  %10 = getelementptr inbounds i32, ptr %1, i64 64771
  store i32 640, ptr %10, align 4, !tbaa !5
  %11 = getelementptr inbounds i32, ptr %1, i64 65277
  store <4 x i32> <i32 640, i32 640, i32 640, i32 640>, ptr %11, align 4, !tbaa !5
  %12 = getelementptr inbounds i32, ptr %1, i64 65281
  store i32 640, ptr %12, align 4, !tbaa !5
  %13 = getelementptr inbounds i32, ptr %1, i64 65282
  store i32 640, ptr %13, align 8, !tbaa !5
  %14 = getelementptr inbounds i32, ptr %1, i64 65283
  store i32 640, ptr %14, align 4, !tbaa !5
  %15 = getelementptr inbounds i32, ptr %1, i64 65789
  store <4 x i32> <i32 640, i32 640, i32 640, i32 640>, ptr %15, align 4, !tbaa !5
  %16 = getelementptr inbounds i32, ptr %1, i64 65793
  store i32 640, ptr %16, align 4, !tbaa !5
  %17 = getelementptr inbounds i32, ptr %1, i64 65794
  store i32 640, ptr %17, align 8, !tbaa !5
  %18 = getelementptr inbounds i32, ptr %1, i64 65795
  store i32 640, ptr %18, align 4, !tbaa !5
  %19 = getelementptr inbounds i32, ptr %1, i64 66301
  store <4 x i32> <i32 640, i32 640, i32 640, i32 640>, ptr %19, align 4, !tbaa !5
  %20 = getelementptr inbounds i32, ptr %1, i64 66305
  store i32 640, ptr %20, align 4, !tbaa !5
  %21 = getelementptr inbounds i32, ptr %1, i64 66306
  store i32 640, ptr %21, align 8, !tbaa !5
  %22 = getelementptr inbounds i32, ptr %1, i64 66307
  store i32 640, ptr %22, align 4, !tbaa !5
  %23 = getelementptr inbounds i32, ptr %1, i64 66813
  store <4 x i32> <i32 640, i32 640, i32 640, i32 640>, ptr %23, align 4, !tbaa !5
  %24 = getelementptr inbounds i32, ptr %1, i64 66817
  store i32 640, ptr %24, align 4, !tbaa !5
  %25 = getelementptr inbounds i32, ptr %1, i64 66818
  store i32 640, ptr %25, align 8, !tbaa !5
  %26 = getelementptr inbounds i32, ptr %1, i64 66819
  store i32 640, ptr %26, align 4, !tbaa !5
  %27 = getelementptr inbounds i32, ptr %1, i64 67325
  store <4 x i32> <i32 640, i32 640, i32 640, i32 640>, ptr %27, align 4, !tbaa !5
  %28 = getelementptr inbounds i32, ptr %1, i64 67329
  store i32 640, ptr %28, align 4, !tbaa !5
  %29 = getelementptr inbounds i32, ptr %1, i64 67330
  store i32 640, ptr %29, align 8, !tbaa !5
  %30 = getelementptr inbounds i32, ptr %1, i64 67331
  store i32 640, ptr %30, align 4, !tbaa !5
  br label %31

31:                                               ; preds = %0, %208
  %32 = phi i32 [ %209, %208 ], [ 0, %0 ]
  %33 = phi ptr [ %34, %208 ], [ %2, %0 ]
  %34 = phi ptr [ %33, %208 ], [ %1, %0 ]
  br label %35

35:                                               ; preds = %79, %31
  %36 = phi i64 [ 1, %31 ], [ %194, %79 ]
  %37 = shl nuw nsw i64 %36, 9
  br label %38

38:                                               ; preds = %38, %35
  %39 = phi i64 [ 0, %35 ], [ %77, %38 ]
  %40 = or disjoint i64 %39, 1
  %41 = add nuw nsw i64 %40, %37
  %42 = getelementptr i32, ptr %34, i64 %41
  %43 = getelementptr i32, ptr %42, i64 -1
  %44 = getelementptr i32, ptr %42, i64 3
  %45 = load <4 x i32>, ptr %43, align 4, !tbaa !5
  %46 = load <4 x i32>, ptr %44, align 4, !tbaa !5
  %47 = getelementptr i32, ptr %42, i64 1
  %48 = getelementptr i32, ptr %42, i64 5
  %49 = load <4 x i32>, ptr %47, align 4, !tbaa !5
  %50 = load <4 x i32>, ptr %48, align 4, !tbaa !5
  %51 = add nsw <4 x i32> %49, %45
  %52 = add nsw <4 x i32> %50, %46
  %53 = getelementptr i32, ptr %42, i64 -512
  %54 = getelementptr i32, ptr %42, i64 -508
  %55 = load <4 x i32>, ptr %53, align 4, !tbaa !5
  %56 = load <4 x i32>, ptr %54, align 4, !tbaa !5
  %57 = add nsw <4 x i32> %51, %55
  %58 = add nsw <4 x i32> %52, %56
  %59 = getelementptr i32, ptr %42, i64 512
  %60 = getelementptr i32, ptr %42, i64 516
  %61 = load <4 x i32>, ptr %59, align 4, !tbaa !5
  %62 = load <4 x i32>, ptr %60, align 4, !tbaa !5
  %63 = add nsw <4 x i32> %57, %61
  %64 = add nsw <4 x i32> %58, %62
  %65 = ashr <4 x i32> %63, <i32 1, i32 1, i32 1, i32 1>
  %66 = ashr <4 x i32> %64, <i32 1, i32 1, i32 1, i32 1>
  %67 = getelementptr inbounds i32, ptr %33, i64 %41
  %68 = getelementptr inbounds i32, ptr %67, i64 4
  %69 = load <4 x i32>, ptr %67, align 4, !tbaa !5
  %70 = load <4 x i32>, ptr %68, align 4, !tbaa !5
  %71 = sub nsw <4 x i32> %65, %69
  %72 = sub nsw <4 x i32> %66, %70
  %73 = ashr <4 x i32> %71, <i32 6, i32 6, i32 6, i32 6>
  %74 = ashr <4 x i32> %72, <i32 6, i32 6, i32 6, i32 6>
  %75 = sub nsw <4 x i32> %71, %73
  %76 = sub nsw <4 x i32> %72, %74
  store <4 x i32> %75, ptr %67, align 4, !tbaa !5
  store <4 x i32> %76, ptr %68, align 4, !tbaa !5
  %77 = add nuw i64 %39, 8
  %78 = icmp eq i64 %77, 504
  br i1 %78, label %79, label %38, !llvm.loop !24

79:                                               ; preds = %38
  %80 = or disjoint i64 %37, 505
  %81 = getelementptr i32, ptr %34, i64 %80
  %82 = getelementptr i32, ptr %81, i64 -1
  %83 = load i32, ptr %82, align 4, !tbaa !5
  %84 = getelementptr i32, ptr %81, i64 1
  %85 = load i32, ptr %84, align 4, !tbaa !5
  %86 = add nsw i32 %85, %83
  %87 = getelementptr i32, ptr %81, i64 -512
  %88 = load i32, ptr %87, align 4, !tbaa !5
  %89 = add nsw i32 %86, %88
  %90 = getelementptr i32, ptr %81, i64 512
  %91 = load i32, ptr %90, align 4, !tbaa !5
  %92 = add nsw i32 %89, %91
  %93 = ashr i32 %92, 1
  %94 = getelementptr inbounds i32, ptr %33, i64 %80
  %95 = load i32, ptr %94, align 4, !tbaa !5
  %96 = sub nsw i32 %93, %95
  %97 = ashr i32 %96, 6
  %98 = sub nsw i32 %96, %97
  store i32 %98, ptr %94, align 4, !tbaa !5
  %99 = or disjoint i64 %37, 506
  %100 = getelementptr i32, ptr %34, i64 %99
  %101 = getelementptr i32, ptr %100, i64 -1
  %102 = load i32, ptr %101, align 4, !tbaa !5
  %103 = getelementptr i32, ptr %100, i64 1
  %104 = load i32, ptr %103, align 4, !tbaa !5
  %105 = add nsw i32 %104, %102
  %106 = getelementptr i32, ptr %100, i64 -512
  %107 = load i32, ptr %106, align 4, !tbaa !5
  %108 = add nsw i32 %105, %107
  %109 = getelementptr i32, ptr %100, i64 512
  %110 = load i32, ptr %109, align 4, !tbaa !5
  %111 = add nsw i32 %108, %110
  %112 = ashr i32 %111, 1
  %113 = getelementptr inbounds i32, ptr %33, i64 %99
  %114 = load i32, ptr %113, align 4, !tbaa !5
  %115 = sub nsw i32 %112, %114
  %116 = ashr i32 %115, 6
  %117 = sub nsw i32 %115, %116
  store i32 %117, ptr %113, align 4, !tbaa !5
  %118 = or disjoint i64 %37, 507
  %119 = getelementptr i32, ptr %34, i64 %118
  %120 = getelementptr i32, ptr %119, i64 -1
  %121 = load i32, ptr %120, align 4, !tbaa !5
  %122 = getelementptr i32, ptr %119, i64 1
  %123 = load i32, ptr %122, align 4, !tbaa !5
  %124 = add nsw i32 %123, %121
  %125 = getelementptr i32, ptr %119, i64 -512
  %126 = load i32, ptr %125, align 4, !tbaa !5
  %127 = add nsw i32 %124, %126
  %128 = getelementptr i32, ptr %119, i64 512
  %129 = load i32, ptr %128, align 4, !tbaa !5
  %130 = add nsw i32 %127, %129
  %131 = ashr i32 %130, 1
  %132 = getelementptr inbounds i32, ptr %33, i64 %118
  %133 = load i32, ptr %132, align 4, !tbaa !5
  %134 = sub nsw i32 %131, %133
  %135 = ashr i32 %134, 6
  %136 = sub nsw i32 %134, %135
  store i32 %136, ptr %132, align 4, !tbaa !5
  %137 = or disjoint i64 %37, 508
  %138 = getelementptr i32, ptr %34, i64 %137
  %139 = getelementptr i32, ptr %138, i64 -1
  %140 = load i32, ptr %139, align 4, !tbaa !5
  %141 = getelementptr i32, ptr %138, i64 1
  %142 = load i32, ptr %141, align 4, !tbaa !5
  %143 = add nsw i32 %142, %140
  %144 = getelementptr i32, ptr %138, i64 -512
  %145 = load i32, ptr %144, align 4, !tbaa !5
  %146 = add nsw i32 %143, %145
  %147 = getelementptr i32, ptr %138, i64 512
  %148 = load i32, ptr %147, align 4, !tbaa !5
  %149 = add nsw i32 %146, %148
  %150 = ashr i32 %149, 1
  %151 = getelementptr inbounds i32, ptr %33, i64 %137
  %152 = load i32, ptr %151, align 4, !tbaa !5
  %153 = sub nsw i32 %150, %152
  %154 = ashr i32 %153, 6
  %155 = sub nsw i32 %153, %154
  store i32 %155, ptr %151, align 4, !tbaa !5
  %156 = or disjoint i64 %37, 509
  %157 = getelementptr i32, ptr %34, i64 %156
  %158 = getelementptr i32, ptr %157, i64 -1
  %159 = load i32, ptr %158, align 4, !tbaa !5
  %160 = getelementptr i32, ptr %157, i64 1
  %161 = load i32, ptr %160, align 4, !tbaa !5
  %162 = add nsw i32 %161, %159
  %163 = getelementptr i32, ptr %157, i64 -512
  %164 = load i32, ptr %163, align 4, !tbaa !5
  %165 = add nsw i32 %162, %164
  %166 = getelementptr i32, ptr %157, i64 512
  %167 = load i32, ptr %166, align 4, !tbaa !5
  %168 = add nsw i32 %165, %167
  %169 = ashr i32 %168, 1
  %170 = getelementptr inbounds i32, ptr %33, i64 %156
  %171 = load i32, ptr %170, align 4, !tbaa !5
  %172 = sub nsw i32 %169, %171
  %173 = ashr i32 %172, 6
  %174 = sub nsw i32 %172, %173
  store i32 %174, ptr %170, align 4, !tbaa !5
  %175 = or disjoint i64 %37, 510
  %176 = getelementptr i32, ptr %34, i64 %175
  %177 = getelementptr i32, ptr %176, i64 -1
  %178 = load i32, ptr %177, align 4, !tbaa !5
  %179 = getelementptr i32, ptr %176, i64 1
  %180 = load i32, ptr %179, align 4, !tbaa !5
  %181 = add nsw i32 %180, %178
  %182 = getelementptr i32, ptr %176, i64 -512
  %183 = load i32, ptr %182, align 4, !tbaa !5
  %184 = add nsw i32 %181, %183
  %185 = getelementptr i32, ptr %176, i64 512
  %186 = load i32, ptr %185, align 4, !tbaa !5
  %187 = add nsw i32 %184, %186
  %188 = ashr i32 %187, 1
  %189 = getelementptr inbounds i32, ptr %33, i64 %175
  %190 = load i32, ptr %189, align 4, !tbaa !5
  %191 = sub nsw i32 %188, %190
  %192 = ashr i32 %191, 6
  %193 = sub nsw i32 %191, %192
  store i32 %193, ptr %189, align 4, !tbaa !5
  %194 = add nuw nsw i64 %36, 1
  %195 = icmp eq i64 %194, 255
  br i1 %195, label %196, label %35, !llvm.loop !21

196:                                              ; preds = %79
  call void @render(ptr noundef nonnull %33)
  tail call void (...) @simFlush() #8
  %197 = and i32 %32, 15
  %198 = icmp eq i32 %197, 0
  br i1 %198, label %199, label %208

199:                                              ; preds = %196
  %200 = tail call i32 (...) @simRand() #8
  %201 = and i32 %200, 1073741823
  %202 = urem i32 %201, 504
  %203 = add nuw nsw i32 %202, 4
  %204 = tail call i32 (...) @simRand() #8
  %205 = and i32 %204, 1073741823
  %206 = urem i32 %205, 248
  %207 = add nuw nsw i32 %206, 4
  call void @drop(ptr noundef nonnull %33, i32 noundef %203, i32 noundef %207, i32 noundef 640)
  br label %208

208:                                              ; preds = %199, %196
  %209 = add nuw nsw i32 %32, 1
  br label %31
}

; Function Attrs: mustprogress nocallback nofree nounwind willreturn memory(argmem: write)
declare void @llvm.memset.p0.i64(ptr nocapture writeonly, i8, i64, i1 immarg) #6

declare void @simFlush(...) local_unnamed_addr #2

declare i32 @simRand(...) local_unnamed_addr #2

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.smax.i32(i32, i32) #7

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.umin.i32(i32, i32) #7

attributes #0 = { nounwind uwtable "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { mustprogress nocallback nofree nosync nounwind willreturn memory(argmem: readwrite) }
attributes #2 = { "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #3 = { mustprogress nofree norecurse nosync nounwind willreturn memory(none) uwtable "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #4 = { nofree norecurse nosync nounwind memory(argmem: readwrite) uwtable "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #5 = { noreturn nounwind uwtable "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #6 = { mustprogress nocallback nofree nounwind willreturn memory(argmem: write) }
attributes #7 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #8 = { nounwind }

!llvm.module.flags = !{!0, !1, !2, !3}
!llvm.ident = !{!4}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 8, !"PIC Level", i32 2}
!2 = !{i32 7, !"PIE Level", i32 2}
!3 = !{i32 7, !"uwtable", i32 2}
!4 = !{!"Ubuntu clang version 18.1.3 (1ubuntu1)"}
!5 = !{!6, !6, i64 0}
!6 = !{!"int", !7, i64 0}
!7 = !{!"omnipotent char", !8, i64 0}
!8 = !{!"Simple C/C++ TBAA"}
!9 = distinct !{!9, !10}
!10 = !{!"llvm.loop.mustprogress"}
!11 = distinct !{!11, !10, !12}
!12 = !{!"llvm.loop.peeled.count", i32 1}
!13 = !{!14}
!14 = distinct !{!14, !15}
!15 = distinct !{!15, !"LVerDomain"}
!16 = !{!17}
!17 = distinct !{!17, !15}
!18 = distinct !{!18, !10, !19, !20}
!19 = !{!"llvm.loop.isvectorized", i32 1}
!20 = !{!"llvm.loop.unroll.runtime.disable"}
!21 = distinct !{!21, !10}
!22 = distinct !{!22, !10, !19}
!23 = distinct !{!23, !10}
!24 = distinct !{!24, !10, !19, !20}
