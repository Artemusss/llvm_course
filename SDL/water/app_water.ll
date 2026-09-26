; ModuleID = 'app_water.c'
source_filename = "app_water.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @drawBlock(i32 noundef %0, i32 noundef %1, i32 noundef %2) #0 {
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  %9 = alloca i32, align 4
  %10 = alloca i32, align 4
  store i32 %0, ptr %4, align 4
  store i32 %1, ptr %5, align 4
  store i32 %2, ptr %6, align 4
  %11 = load i32, ptr %4, align 4
  %12 = mul nsw i32 %11, 3
  store i32 %12, ptr %7, align 4
  %13 = load i32, ptr %5, align 4
  %14 = mul nsw i32 %13, 3
  store i32 %14, ptr %8, align 4
  store i32 0, ptr %9, align 4
  br label %15

15:                                               ; preds = %34, %3
  %16 = load i32, ptr %9, align 4
  %17 = icmp slt i32 %16, 3
  br i1 %17, label %18, label %37

18:                                               ; preds = %15
  store i32 0, ptr %10, align 4
  br label %19

19:                                               ; preds = %30, %18
  %20 = load i32, ptr %10, align 4
  %21 = icmp slt i32 %20, 3
  br i1 %21, label %22, label %33

22:                                               ; preds = %19
  %23 = load i32, ptr %7, align 4
  %24 = load i32, ptr %10, align 4
  %25 = add nsw i32 %23, %24
  %26 = load i32, ptr %8, align 4
  %27 = load i32, ptr %9, align 4
  %28 = add nsw i32 %26, %27
  %29 = load i32, ptr %6, align 4
  call void @simPutPixel(i32 noundef %25, i32 noundef %28, i32 noundef %29)
  br label %30

30:                                               ; preds = %22
  %31 = load i32, ptr %10, align 4
  %32 = add nsw i32 %31, 1
  store i32 %32, ptr %10, align 4
  br label %19, !llvm.loop !6

33:                                               ; preds = %19
  br label %34

34:                                               ; preds = %33
  %35 = load i32, ptr %9, align 4
  %36 = add nsw i32 %35, 1
  store i32 %36, ptr %9, align 4
  br label %15, !llvm.loop !8

37:                                               ; preds = %15
  ret void
}

declare void @simPutPixel(i32 noundef, i32 noundef, i32 noundef) #1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @shade(i32 noundef %0, i32 noundef %1) #0 {
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  store i32 %0, ptr %3, align 4
  store i32 %1, ptr %4, align 4
  %9 = load i32, ptr %3, align 4
  %10 = ashr i32 %9, 3
  %11 = add nsw i32 120, %10
  %12 = load i32, ptr %4, align 4
  %13 = ashr i32 %12, 1
  %14 = add nsw i32 %11, %13
  store i32 %14, ptr %5, align 4
  %15 = load i32, ptr %5, align 4
  %16 = icmp slt i32 %15, 0
  br i1 %16, label %17, label %18

17:                                               ; preds = %2
  store i32 0, ptr %5, align 4
  br label %18

18:                                               ; preds = %17, %2
  %19 = load i32, ptr %5, align 4
  %20 = icmp sgt i32 %19, 255
  br i1 %20, label %21, label %22

21:                                               ; preds = %18
  store i32 255, ptr %5, align 4
  br label %22

22:                                               ; preds = %21, %18
  %23 = load i32, ptr %5, align 4
  %24 = ashr i32 %23, 3
  store i32 %24, ptr %6, align 4
  %25 = load i32, ptr %5, align 4
  %26 = mul nsw i32 %25, 5
  %27 = ashr i32 %26, 3
  store i32 %27, ptr %7, align 4
  %28 = load i32, ptr %5, align 4
  store i32 %28, ptr %8, align 4
  %29 = load i32, ptr %6, align 4
  %30 = shl i32 %29, 16
  %31 = or i32 -16777216, %30
  %32 = load i32, ptr %7, align 4
  %33 = shl i32 %32, 8
  %34 = or i32 %31, %33
  %35 = load i32, ptr %8, align 4
  %36 = or i32 %34, %35
  ret i32 %36
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @render(ptr noundef %0) #0 {
  %2 = alloca ptr, align 8
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  store ptr %0, ptr %2, align 8
  store i32 0, ptr %3, align 4
  br label %9

9:                                                ; preds = %63, %1
  %10 = load i32, ptr %3, align 4
  %11 = icmp slt i32 %10, 256
  br i1 %11, label %12, label %66

12:                                               ; preds = %9
  store i32 0, ptr %4, align 4
  br label %13

13:                                               ; preds = %59, %12
  %14 = load i32, ptr %4, align 4
  %15 = icmp slt i32 %14, 512
  br i1 %15, label %16, label %62

16:                                               ; preds = %13
  %17 = load i32, ptr %3, align 4
  %18 = mul nsw i32 %17, 512
  %19 = load i32, ptr %4, align 4
  %20 = add nsw i32 %18, %19
  store i32 %20, ptr %5, align 4
  %21 = load i32, ptr %4, align 4
  %22 = icmp sgt i32 %21, 0
  br i1 %22, label %23, label %26

23:                                               ; preds = %16
  %24 = load i32, ptr %5, align 4
  %25 = sub nsw i32 %24, 1
  br label %28

26:                                               ; preds = %16
  %27 = load i32, ptr %5, align 4
  br label %28

28:                                               ; preds = %26, %23
  %29 = phi i32 [ %25, %23 ], [ %27, %26 ]
  store i32 %29, ptr %6, align 4
  %30 = load i32, ptr %4, align 4
  %31 = icmp slt i32 %30, 511
  br i1 %31, label %32, label %35

32:                                               ; preds = %28
  %33 = load i32, ptr %5, align 4
  %34 = add nsw i32 %33, 1
  br label %37

35:                                               ; preds = %28
  %36 = load i32, ptr %5, align 4
  br label %37

37:                                               ; preds = %35, %32
  %38 = phi i32 [ %34, %32 ], [ %36, %35 ]
  store i32 %38, ptr %7, align 4
  %39 = load ptr, ptr %2, align 8
  %40 = load i32, ptr %6, align 4
  %41 = sext i32 %40 to i64
  %42 = getelementptr inbounds i32, ptr %39, i64 %41
  %43 = load i32, ptr %42, align 4
  %44 = load ptr, ptr %2, align 8
  %45 = load i32, ptr %7, align 4
  %46 = sext i32 %45 to i64
  %47 = getelementptr inbounds i32, ptr %44, i64 %46
  %48 = load i32, ptr %47, align 4
  %49 = sub nsw i32 %43, %48
  store i32 %49, ptr %8, align 4
  %50 = load i32, ptr %4, align 4
  %51 = load i32, ptr %3, align 4
  %52 = load ptr, ptr %2, align 8
  %53 = load i32, ptr %5, align 4
  %54 = sext i32 %53 to i64
  %55 = getelementptr inbounds i32, ptr %52, i64 %54
  %56 = load i32, ptr %55, align 4
  %57 = load i32, ptr %8, align 4
  %58 = call i32 @shade(i32 noundef %56, i32 noundef %57)
  call void @drawBlock(i32 noundef %50, i32 noundef %51, i32 noundef %58)
  br label %59

59:                                               ; preds = %37
  %60 = load i32, ptr %4, align 4
  %61 = add nsw i32 %60, 1
  store i32 %61, ptr %4, align 4
  br label %13, !llvm.loop !9

62:                                               ; preds = %13
  br label %63

63:                                               ; preds = %62
  %64 = load i32, ptr %3, align 4
  %65 = add nsw i32 %64, 1
  store i32 %65, ptr %3, align 4
  br label %9, !llvm.loop !10

66:                                               ; preds = %9
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @step(ptr noundef %0, ptr noundef %1) #0 {
  %3 = alloca ptr, align 8
  %4 = alloca ptr, align 8
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  store ptr %0, ptr %3, align 8
  store ptr %1, ptr %4, align 8
  store i32 1, ptr %5, align 4
  br label %9

9:                                                ; preds = %68, %2
  %10 = load i32, ptr %5, align 4
  %11 = icmp slt i32 %10, 255
  br i1 %11, label %12, label %71

12:                                               ; preds = %9
  store i32 1, ptr %6, align 4
  br label %13

13:                                               ; preds = %64, %12
  %14 = load i32, ptr %6, align 4
  %15 = icmp slt i32 %14, 511
  br i1 %15, label %16, label %67

16:                                               ; preds = %13
  %17 = load i32, ptr %5, align 4
  %18 = mul nsw i32 %17, 512
  %19 = load i32, ptr %6, align 4
  %20 = add nsw i32 %18, %19
  store i32 %20, ptr %7, align 4
  %21 = load ptr, ptr %3, align 8
  %22 = load i32, ptr %7, align 4
  %23 = sub nsw i32 %22, 1
  %24 = sext i32 %23 to i64
  %25 = getelementptr inbounds i32, ptr %21, i64 %24
  %26 = load i32, ptr %25, align 4
  %27 = load ptr, ptr %3, align 8
  %28 = load i32, ptr %7, align 4
  %29 = add nsw i32 %28, 1
  %30 = sext i32 %29 to i64
  %31 = getelementptr inbounds i32, ptr %27, i64 %30
  %32 = load i32, ptr %31, align 4
  %33 = add nsw i32 %26, %32
  %34 = load ptr, ptr %3, align 8
  %35 = load i32, ptr %7, align 4
  %36 = sub nsw i32 %35, 512
  %37 = sext i32 %36 to i64
  %38 = getelementptr inbounds i32, ptr %34, i64 %37
  %39 = load i32, ptr %38, align 4
  %40 = add nsw i32 %33, %39
  %41 = load ptr, ptr %3, align 8
  %42 = load i32, ptr %7, align 4
  %43 = add nsw i32 %42, 512
  %44 = sext i32 %43 to i64
  %45 = getelementptr inbounds i32, ptr %41, i64 %44
  %46 = load i32, ptr %45, align 4
  %47 = add nsw i32 %40, %46
  %48 = ashr i32 %47, 1
  %49 = load ptr, ptr %4, align 8
  %50 = load i32, ptr %7, align 4
  %51 = sext i32 %50 to i64
  %52 = getelementptr inbounds i32, ptr %49, i64 %51
  %53 = load i32, ptr %52, align 4
  %54 = sub nsw i32 %48, %53
  store i32 %54, ptr %8, align 4
  %55 = load i32, ptr %8, align 4
  %56 = ashr i32 %55, 6
  %57 = load i32, ptr %8, align 4
  %58 = sub nsw i32 %57, %56
  store i32 %58, ptr %8, align 4
  %59 = load i32, ptr %8, align 4
  %60 = load ptr, ptr %4, align 8
  %61 = load i32, ptr %7, align 4
  %62 = sext i32 %61 to i64
  %63 = getelementptr inbounds i32, ptr %60, i64 %62
  store i32 %59, ptr %63, align 4
  br label %64

64:                                               ; preds = %16
  %65 = load i32, ptr %6, align 4
  %66 = add nsw i32 %65, 1
  store i32 %66, ptr %6, align 4
  br label %13, !llvm.loop !11

67:                                               ; preds = %13
  br label %68

68:                                               ; preds = %67
  %69 = load i32, ptr %5, align 4
  %70 = add nsw i32 %69, 1
  store i32 %70, ptr %5, align 4
  br label %9, !llvm.loop !12

71:                                               ; preds = %9
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @drop(ptr noundef %0, i32 noundef %1, i32 noundef %2, i32 noundef %3) #0 {
  %5 = alloca ptr, align 8
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  %9 = alloca i32, align 4
  %10 = alloca i32, align 4
  %11 = alloca i32, align 4
  %12 = alloca i32, align 4
  store ptr %0, ptr %5, align 8
  store i32 %1, ptr %6, align 4
  store i32 %2, ptr %7, align 4
  store i32 %3, ptr %8, align 4
  store i32 -3, ptr %9, align 4
  br label %13

13:                                               ; preds = %54, %4
  %14 = load i32, ptr %9, align 4
  %15 = icmp sle i32 %14, 3
  br i1 %15, label %16, label %57

16:                                               ; preds = %13
  store i32 -3, ptr %10, align 4
  br label %17

17:                                               ; preds = %50, %16
  %18 = load i32, ptr %10, align 4
  %19 = icmp sle i32 %18, 3
  br i1 %19, label %20, label %53

20:                                               ; preds = %17
  %21 = load i32, ptr %6, align 4
  %22 = load i32, ptr %10, align 4
  %23 = add nsw i32 %21, %22
  store i32 %23, ptr %11, align 4
  %24 = load i32, ptr %7, align 4
  %25 = load i32, ptr %9, align 4
  %26 = add nsw i32 %24, %25
  store i32 %26, ptr %12, align 4
  %27 = load i32, ptr %11, align 4
  %28 = icmp sgt i32 %27, 0
  br i1 %28, label %29, label %49

29:                                               ; preds = %20
  %30 = load i32, ptr %11, align 4
  %31 = icmp slt i32 %30, 511
  br i1 %31, label %32, label %49

32:                                               ; preds = %29
  %33 = load i32, ptr %12, align 4
  %34 = icmp sgt i32 %33, 0
  br i1 %34, label %35, label %49

35:                                               ; preds = %32
  %36 = load i32, ptr %12, align 4
  %37 = icmp slt i32 %36, 255
  br i1 %37, label %38, label %49

38:                                               ; preds = %35
  %39 = load i32, ptr %8, align 4
  %40 = load ptr, ptr %5, align 8
  %41 = load i32, ptr %12, align 4
  %42 = mul nsw i32 %41, 512
  %43 = load i32, ptr %11, align 4
  %44 = add nsw i32 %42, %43
  %45 = sext i32 %44 to i64
  %46 = getelementptr inbounds i32, ptr %40, i64 %45
  %47 = load i32, ptr %46, align 4
  %48 = add nsw i32 %47, %39
  store i32 %48, ptr %46, align 4
  br label %49

49:                                               ; preds = %38, %35, %32, %29, %20
  br label %50

50:                                               ; preds = %49
  %51 = load i32, ptr %10, align 4
  %52 = add nsw i32 %51, 1
  store i32 %52, ptr %10, align 4
  br label %17, !llvm.loop !13

53:                                               ; preds = %17
  br label %54

54:                                               ; preds = %53
  %55 = load i32, ptr %9, align 4
  %56 = add nsw i32 %55, 1
  store i32 %56, ptr %9, align 4
  br label %13, !llvm.loop !14

57:                                               ; preds = %13
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @app() #0 {
  %1 = alloca [131072 x i32], align 16
  %2 = alloca [131072 x i32], align 16
  %3 = alloca ptr, align 8
  %4 = alloca ptr, align 8
  %5 = alloca i32, align 4
  %6 = alloca ptr, align 8
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  call void @llvm.memset.p0.i64(ptr align 16 %1, i8 0, i64 524288, i1 false)
  call void @llvm.memset.p0.i64(ptr align 16 %2, i8 0, i64 524288, i1 false)
  %9 = getelementptr inbounds [131072 x i32], ptr %1, i64 0, i64 0
  store ptr %9, ptr %3, align 8
  %10 = getelementptr inbounds [131072 x i32], ptr %2, i64 0, i64 0
  store ptr %10, ptr %4, align 8
  store i32 0, ptr %5, align 4
  %11 = load ptr, ptr %3, align 8
  call void @drop(ptr noundef %11, i32 noundef 256, i32 noundef 128, i32 noundef 640)
  br label %12

12:                                               ; preds = %0, %36
  %13 = load ptr, ptr %3, align 8
  %14 = load ptr, ptr %4, align 8
  call void @step(ptr noundef %13, ptr noundef %14)
  %15 = load ptr, ptr %3, align 8
  store ptr %15, ptr %6, align 8
  %16 = load ptr, ptr %4, align 8
  store ptr %16, ptr %3, align 8
  %17 = load ptr, ptr %6, align 8
  store ptr %17, ptr %4, align 8
  %18 = load ptr, ptr %3, align 8
  call void @render(ptr noundef %18)
  call void (...) @simFlush()
  %19 = load i32, ptr %5, align 4
  %20 = srem i32 %19, 16
  %21 = icmp eq i32 %20, 0
  br i1 %21, label %22, label %36

22:                                               ; preds = %12
  %23 = call i32 (...) @simRand()
  %24 = and i32 %23, 1073741823
  %25 = srem i32 %24, 504
  %26 = add nsw i32 %25, 3
  %27 = add nsw i32 %26, 1
  store i32 %27, ptr %7, align 4
  %28 = call i32 (...) @simRand()
  %29 = and i32 %28, 1073741823
  %30 = srem i32 %29, 248
  %31 = add nsw i32 %30, 3
  %32 = add nsw i32 %31, 1
  store i32 %32, ptr %8, align 4
  %33 = load ptr, ptr %3, align 8
  %34 = load i32, ptr %7, align 4
  %35 = load i32, ptr %8, align 4
  call void @drop(ptr noundef %33, i32 noundef %34, i32 noundef %35, i32 noundef 640)
  br label %36

36:                                               ; preds = %22, %12
  %37 = load i32, ptr %5, align 4
  %38 = add nsw i32 %37, 1
  store i32 %38, ptr %5, align 4
  br label %12
}

; Function Attrs: nocallback nofree nounwind willreturn memory(argmem: write)
declare void @llvm.memset.p0.i64(ptr nocapture writeonly, i8, i64, i1 immarg) #2

declare void @simFlush(...) #1

declare i32 @simRand(...) #1

attributes #0 = { noinline nounwind optnone uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #2 = { nocallback nofree nounwind willreturn memory(argmem: write) }

!llvm.module.flags = !{!0, !1, !2, !3, !4}
!llvm.ident = !{!5}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 8, !"PIC Level", i32 2}
!2 = !{i32 7, !"PIE Level", i32 2}
!3 = !{i32 7, !"uwtable", i32 2}
!4 = !{i32 7, !"frame-pointer", i32 2}
!5 = !{!"Ubuntu clang version 18.1.3 (1ubuntu1)"}
!6 = distinct !{!6, !7}
!7 = !{!"llvm.loop.mustprogress"}
!8 = distinct !{!8, !7}
!9 = distinct !{!9, !7}
!10 = distinct !{!10, !7}
!11 = distinct !{!11, !7}
!12 = distinct !{!12, !7}
!13 = distinct !{!13, !7}
!14 = distinct !{!14, !7}
