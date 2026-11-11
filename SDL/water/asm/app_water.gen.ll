; ModuleID = 'app_water_full'
source_filename = "app_water_full"

@mem = internal global [262144 x i32] zeroinitializer

define void @app() {
entry:
  %regFile = alloca [32 x i32], align 4
  %0 = getelementptr [32 x i32], ptr %regFile, i32 0, i32 1
  store i32 0, ptr %0, align 4
  %1 = getelementptr [32 x i32], ptr %regFile, i32 0, i32 2
  store i32 131072, ptr %1, align 4
  %2 = getelementptr [32 x i32], ptr %regFile, i32 0, i32 3
  store i32 0, ptr %2, align 4
  %3 = getelementptr [32 x i32], ptr %regFile, i32 0, i32 16
  store i32 256, ptr %3, align 4
  %4 = getelementptr [32 x i32], ptr %regFile, i32 0, i32 17
  store i32 128, ptr %4, align 4
  %5 = getelementptr [32 x i32], ptr %regFile, i32 0, i32 19
  store i32 -3, ptr %5, align 4
  br label %d0_j

d0_j:                                             ; preds = %d0_jnext, %entry
  %6 = getelementptr [32 x i32], ptr %regFile, i32 0, i32 18
  store i32 -3, ptr %6, align 4
  br label %d0_i

d0_i:                                             ; preds = %d0_skip, %d0_j
  %7 = getelementptr [32 x i32], ptr %regFile, i32 0, i32 16
  %8 = load i32, ptr %7, align 4
  %9 = getelementptr [32 x i32], ptr %regFile, i32 0, i32 18
  %10 = load i32, ptr %9, align 4
  %11 = add i32 %8, %10
  %12 = getelementptr [32 x i32], ptr %regFile, i32 0, i32 8
  store i32 %11, ptr %12, align 4
  %13 = getelementptr [32 x i32], ptr %regFile, i32 0, i32 17
  %14 = load i32, ptr %13, align 4
  %15 = getelementptr [32 x i32], ptr %regFile, i32 0, i32 19
  %16 = load i32, ptr %15, align 4
  %17 = add i32 %14, %16
  %18 = getelementptr [32 x i32], ptr %regFile, i32 0, i32 9
  store i32 %17, ptr %18, align 4
  %19 = getelementptr [32 x i32], ptr %regFile, i32 0, i32 8
  %20 = load i32, ptr %19, align 4
  %21 = add i32 %20, -1
  %22 = getelementptr [32 x i32], ptr %regFile, i32 0, i32 10
  store i32 %21, ptr %22, align 4
  %23 = getelementptr [32 x i32], ptr %regFile, i32 0, i32 10
  %24 = load i32, ptr %23, align 4
  %25 = icmp ult i32 %24, 510
  %26 = zext i1 %25 to i32
  %27 = getelementptr [32 x i32], ptr %regFile, i32 0, i32 10
  store i32 %26, ptr %27, align 4
  %28 = getelementptr [32 x i32], ptr %regFile, i32 0, i32 9
  %29 = load i32, ptr %28, align 4
  %30 = add i32 %29, -1
  %31 = getelementptr [32 x i32], ptr %regFile, i32 0, i32 11
  store i32 %30, ptr %31, align 4
  %32 = getelementptr [32 x i32], ptr %regFile, i32 0, i32 11
  %33 = load i32, ptr %32, align 4
  %34 = icmp ult i32 %33, 254
  %35 = zext i1 %34 to i32
  %36 = getelementptr [32 x i32], ptr %regFile, i32 0, i32 11
  store i32 %35, ptr %36, align 4
  %37 = getelementptr [32 x i32], ptr %regFile, i32 0, i32 10
  %38 = load i32, ptr %37, align 4
  %39 = getelementptr [32 x i32], ptr %regFile, i32 0, i32 11
  %40 = load i32, ptr %39, align 4
  %41 = and i32 %38, %40
  %42 = getelementptr [32 x i32], ptr %regFile, i32 0, i32 10
  store i32 %41, ptr %42, align 4
  %43 = getelementptr [32 x i32], ptr %regFile, i32 0, i32 10
  %44 = load i32, ptr %43, align 4
  %45 = icmp eq i32 %44, 0
  br i1 %45, label %d0_skip, label %d0_add

d0_add:                                           ; preds = %d0_i
  %46 = getelementptr [32 x i32], ptr %regFile, i32 0, i32 9
  %47 = load i32, ptr %46, align 4
  %48 = shl i32 %47, 9
  %49 = getelementptr [32 x i32], ptr %regFile, i32 0, i32 12
  store i32 %48, ptr %49, align 4
  %50 = getelementptr [32 x i32], ptr %regFile, i32 0, i32 12
  %51 = load i32, ptr %50, align 4
  %52 = getelementptr [32 x i32], ptr %regFile, i32 0, i32 8
  %53 = load i32, ptr %52, align 4
  %54 = add i32 %51, %53
  %55 = getelementptr [32 x i32], ptr %regFile, i32 0, i32 12
  store i32 %54, ptr %55, align 4
  %56 = getelementptr [32 x i32], ptr %regFile, i32 0, i32 12
  %57 = load i32, ptr %56, align 4
  %58 = getelementptr [32 x i32], ptr %regFile, i32 0, i32 1
  %59 = load i32, ptr %58, align 4
  %60 = add i32 %57, %59
  %61 = getelementptr [32 x i32], ptr %regFile, i32 0, i32 12
  store i32 %60, ptr %61, align 4
  %62 = getelementptr [32 x i32], ptr %regFile, i32 0, i32 12
  %63 = load i32, ptr %62, align 4
  %64 = add i32 %63, 0
  %65 = getelementptr inbounds i32, ptr @mem, i32 %64
  %66 = load i32, ptr %65, align 4
  %67 = getelementptr [32 x i32], ptr %regFile, i32 0, i32 13
  store i32 %66, ptr %67, align 4
  %68 = getelementptr [32 x i32], ptr %regFile, i32 0, i32 13
  %69 = load i32, ptr %68, align 4
  %70 = add i32 %69, 640
  %71 = getelementptr [32 x i32], ptr %regFile, i32 0, i32 13
  store i32 %70, ptr %71, align 4
  %72 = getelementptr [32 x i32], ptr %regFile, i32 0, i32 13
  %73 = load i32, ptr %72, align 4
  %74 = getelementptr [32 x i32], ptr %regFile, i32 0, i32 12
  %75 = load i32, ptr %74, align 4
  %76 = add i32 %75, 0
  %77 = getelementptr inbounds i32, ptr @mem, i32 %76
  store i32 %73, ptr %77, align 4
  br label %d0_skip

d0_skip:                                          ; preds = %d0_add, %d0_i
  %78 = getelementptr [32 x i32], ptr %regFile, i32 0, i32 18
  %79 = load i32, ptr %78, align 4
  %80 = add i32 %79, 1
  %81 = getelementptr [32 x i32], ptr %regFile, i32 0, i32 18
  store i32 %80, ptr %81, align 4
  %82 = icmp ne i32 %80, 4
  %83 = zext i1 %82 to i32
  %84 = getelementptr [32 x i32], ptr %regFile, i32 0, i32 4
  store i32 %83, ptr %84, align 4
  %85 = getelementptr [32 x i32], ptr %regFile, i32 0, i32 4
  %86 = load i32, ptr %85, align 4
  %87 = icmp ne i32 %86, 0
  br i1 %87, label %d0_i, label %d0_jnext

d0_jnext:                                         ; preds = %d0_skip
  %88 = getelementptr [32 x i32], ptr %regFile, i32 0, i32 19
  %89 = load i32, ptr %88, align 4
  %90 = add i32 %89, 1
  %91 = getelementptr [32 x i32], ptr %regFile, i32 0, i32 19
  store i32 %90, ptr %91, align 4
  %92 = icmp ne i32 %90, 4
  %93 = zext i1 %92 to i32
  %94 = getelementptr [32 x i32], ptr %regFile, i32 0, i32 4
  store i32 %93, ptr %94, align 4
  %95 = getelementptr [32 x i32], ptr %regFile, i32 0, i32 4
  %96 = load i32, ptr %95, align 4
  %97 = icmp ne i32 %96, 0
  br i1 %97, label %d0_j, label %main_loop

main_loop:                                        ; preds = %no_drop, %d0_jnext
  %98 = getelementptr [32 x i32], ptr %regFile, i32 0, i32 5
  store i32 1, ptr %98, align 4
  br label %st_y

st_y:                                             ; preds = %st_ynext, %main_loop
  %99 = getelementptr [32 x i32], ptr %regFile, i32 0, i32 6
  store i32 1, ptr %99, align 4
  %100 = getelementptr [32 x i32], ptr %regFile, i32 0, i32 5
  %101 = load i32, ptr %100, align 4
  %102 = shl i32 %101, 9
  %103 = getelementptr [32 x i32], ptr %regFile, i32 0, i32 7
  store i32 %102, ptr %103, align 4
  br label %st_x

st_x:                                             ; preds = %st_x, %st_y
  %104 = getelementptr [32 x i32], ptr %regFile, i32 0, i32 7
  %105 = load i32, ptr %104, align 4
  %106 = getelementptr [32 x i32], ptr %regFile, i32 0, i32 6
  %107 = load i32, ptr %106, align 4
  %108 = add i32 %105, %107
  %109 = getelementptr [32 x i32], ptr %regFile, i32 0, i32 8
  store i32 %108, ptr %109, align 4
  %110 = getelementptr [32 x i32], ptr %regFile, i32 0, i32 8
  %111 = load i32, ptr %110, align 4
  %112 = getelementptr [32 x i32], ptr %regFile, i32 0, i32 1
  %113 = load i32, ptr %112, align 4
  %114 = add i32 %111, %113
  %115 = getelementptr [32 x i32], ptr %regFile, i32 0, i32 9
  store i32 %114, ptr %115, align 4
  %116 = getelementptr [32 x i32], ptr %regFile, i32 0, i32 8
  %117 = load i32, ptr %116, align 4
  %118 = getelementptr [32 x i32], ptr %regFile, i32 0, i32 2
  %119 = load i32, ptr %118, align 4
  %120 = add i32 %117, %119
  %121 = getelementptr [32 x i32], ptr %regFile, i32 0, i32 10
  store i32 %120, ptr %121, align 4
  %122 = getelementptr [32 x i32], ptr %regFile, i32 0, i32 9
  %123 = load i32, ptr %122, align 4
  %124 = add i32 %123, -1
  %125 = getelementptr inbounds i32, ptr @mem, i32 %124
  %126 = load i32, ptr %125, align 4
  %127 = getelementptr [32 x i32], ptr %regFile, i32 0, i32 11
  store i32 %126, ptr %127, align 4
  %128 = getelementptr [32 x i32], ptr %regFile, i32 0, i32 9
  %129 = load i32, ptr %128, align 4
  %130 = add i32 %129, 1
  %131 = getelementptr inbounds i32, ptr @mem, i32 %130
  %132 = load i32, ptr %131, align 4
  %133 = getelementptr [32 x i32], ptr %regFile, i32 0, i32 12
  store i32 %132, ptr %133, align 4
  %134 = getelementptr [32 x i32], ptr %regFile, i32 0, i32 11
  %135 = load i32, ptr %134, align 4
  %136 = getelementptr [32 x i32], ptr %regFile, i32 0, i32 12
  %137 = load i32, ptr %136, align 4
  %138 = add i32 %135, %137
  %139 = getelementptr [32 x i32], ptr %regFile, i32 0, i32 11
  store i32 %138, ptr %139, align 4
  %140 = getelementptr [32 x i32], ptr %regFile, i32 0, i32 9
  %141 = load i32, ptr %140, align 4
  %142 = add i32 %141, -512
  %143 = getelementptr inbounds i32, ptr @mem, i32 %142
  %144 = load i32, ptr %143, align 4
  %145 = getelementptr [32 x i32], ptr %regFile, i32 0, i32 12
  store i32 %144, ptr %145, align 4
  %146 = getelementptr [32 x i32], ptr %regFile, i32 0, i32 11
  %147 = load i32, ptr %146, align 4
  %148 = getelementptr [32 x i32], ptr %regFile, i32 0, i32 12
  %149 = load i32, ptr %148, align 4
  %150 = add i32 %147, %149
  %151 = getelementptr [32 x i32], ptr %regFile, i32 0, i32 11
  store i32 %150, ptr %151, align 4
  %152 = getelementptr [32 x i32], ptr %regFile, i32 0, i32 9
  %153 = load i32, ptr %152, align 4
  %154 = add i32 %153, 512
  %155 = getelementptr inbounds i32, ptr @mem, i32 %154
  %156 = load i32, ptr %155, align 4
  %157 = getelementptr [32 x i32], ptr %regFile, i32 0, i32 12
  store i32 %156, ptr %157, align 4
  %158 = getelementptr [32 x i32], ptr %regFile, i32 0, i32 11
  %159 = load i32, ptr %158, align 4
  %160 = getelementptr [32 x i32], ptr %regFile, i32 0, i32 12
  %161 = load i32, ptr %160, align 4
  %162 = add i32 %159, %161
  %163 = getelementptr [32 x i32], ptr %regFile, i32 0, i32 11
  store i32 %162, ptr %163, align 4
  %164 = getelementptr [32 x i32], ptr %regFile, i32 0, i32 11
  %165 = load i32, ptr %164, align 4
  %166 = ashr i32 %165, 1
  %167 = getelementptr [32 x i32], ptr %regFile, i32 0, i32 11
  store i32 %166, ptr %167, align 4
  %168 = getelementptr [32 x i32], ptr %regFile, i32 0, i32 10
  %169 = load i32, ptr %168, align 4
  %170 = add i32 %169, 0
  %171 = getelementptr inbounds i32, ptr @mem, i32 %170
  %172 = load i32, ptr %171, align 4
  %173 = getelementptr [32 x i32], ptr %regFile, i32 0, i32 12
  store i32 %172, ptr %173, align 4
  %174 = getelementptr [32 x i32], ptr %regFile, i32 0, i32 11
  %175 = load i32, ptr %174, align 4
  %176 = getelementptr [32 x i32], ptr %regFile, i32 0, i32 12
  %177 = load i32, ptr %176, align 4
  %178 = sub i32 %175, %177
  %179 = getelementptr [32 x i32], ptr %regFile, i32 0, i32 11
  store i32 %178, ptr %179, align 4
  %180 = getelementptr [32 x i32], ptr %regFile, i32 0, i32 11
  %181 = load i32, ptr %180, align 4
  %182 = ashr i32 %181, 6
  %183 = getelementptr [32 x i32], ptr %regFile, i32 0, i32 12
  store i32 %182, ptr %183, align 4
  %184 = getelementptr [32 x i32], ptr %regFile, i32 0, i32 11
  %185 = load i32, ptr %184, align 4
  %186 = getelementptr [32 x i32], ptr %regFile, i32 0, i32 12
  %187 = load i32, ptr %186, align 4
  %188 = sub i32 %185, %187
  %189 = getelementptr [32 x i32], ptr %regFile, i32 0, i32 11
  store i32 %188, ptr %189, align 4
  %190 = getelementptr [32 x i32], ptr %regFile, i32 0, i32 11
  %191 = load i32, ptr %190, align 4
  %192 = getelementptr [32 x i32], ptr %regFile, i32 0, i32 10
  %193 = load i32, ptr %192, align 4
  %194 = add i32 %193, 0
  %195 = getelementptr inbounds i32, ptr @mem, i32 %194
  store i32 %191, ptr %195, align 4
  %196 = getelementptr [32 x i32], ptr %regFile, i32 0, i32 6
  %197 = load i32, ptr %196, align 4
  %198 = add i32 %197, 1
  %199 = getelementptr [32 x i32], ptr %regFile, i32 0, i32 6
  store i32 %198, ptr %199, align 4
  %200 = icmp ne i32 %198, 511
  %201 = zext i1 %200 to i32
  %202 = getelementptr [32 x i32], ptr %regFile, i32 0, i32 4
  store i32 %201, ptr %202, align 4
  %203 = getelementptr [32 x i32], ptr %regFile, i32 0, i32 4
  %204 = load i32, ptr %203, align 4
  %205 = icmp ne i32 %204, 0
  br i1 %205, label %st_x, label %st_ynext

st_ynext:                                         ; preds = %st_x
  %206 = getelementptr [32 x i32], ptr %regFile, i32 0, i32 5
  %207 = load i32, ptr %206, align 4
  %208 = add i32 %207, 1
  %209 = getelementptr [32 x i32], ptr %regFile, i32 0, i32 5
  store i32 %208, ptr %209, align 4
  %210 = icmp ne i32 %208, 255
  %211 = zext i1 %210 to i32
  %212 = getelementptr [32 x i32], ptr %regFile, i32 0, i32 4
  store i32 %211, ptr %212, align 4
  %213 = getelementptr [32 x i32], ptr %regFile, i32 0, i32 4
  %214 = load i32, ptr %213, align 4
  %215 = icmp ne i32 %214, 0
  br i1 %215, label %st_y, label %swap

swap:                                             ; preds = %st_ynext
  %216 = getelementptr [32 x i32], ptr %regFile, i32 0, i32 1
  %217 = load i32, ptr %216, align 4
  %218 = getelementptr [32 x i32], ptr %regFile, i32 0, i32 8
  store i32 %217, ptr %218, align 4
  %219 = getelementptr [32 x i32], ptr %regFile, i32 0, i32 2
  %220 = load i32, ptr %219, align 4
  %221 = getelementptr [32 x i32], ptr %regFile, i32 0, i32 1
  store i32 %220, ptr %221, align 4
  %222 = getelementptr [32 x i32], ptr %regFile, i32 0, i32 8
  %223 = load i32, ptr %222, align 4
  %224 = getelementptr [32 x i32], ptr %regFile, i32 0, i32 2
  store i32 %223, ptr %224, align 4
  %225 = getelementptr [32 x i32], ptr %regFile, i32 0, i32 5
  store i32 0, ptr %225, align 4
  br label %rn_y

rn_y:                                             ; preds = %rn_ynext, %swap
  %226 = getelementptr [32 x i32], ptr %regFile, i32 0, i32 6
  store i32 0, ptr %226, align 4
  %227 = getelementptr [32 x i32], ptr %regFile, i32 0, i32 5
  %228 = load i32, ptr %227, align 4
  %229 = shl i32 %228, 9
  %230 = getelementptr [32 x i32], ptr %regFile, i32 0, i32 7
  store i32 %229, ptr %230, align 4
  br label %rn_x

rn_x:                                             ; preds = %rn_x, %rn_y
  %231 = getelementptr [32 x i32], ptr %regFile, i32 0, i32 7
  %232 = load i32, ptr %231, align 4
  %233 = getelementptr [32 x i32], ptr %regFile, i32 0, i32 6
  %234 = load i32, ptr %233, align 4
  %235 = add i32 %232, %234
  %236 = getelementptr [32 x i32], ptr %regFile, i32 0, i32 8
  store i32 %235, ptr %236, align 4
  %237 = getelementptr [32 x i32], ptr %regFile, i32 0, i32 8
  %238 = load i32, ptr %237, align 4
  %239 = getelementptr [32 x i32], ptr %regFile, i32 0, i32 1
  %240 = load i32, ptr %239, align 4
  %241 = add i32 %238, %240
  %242 = getelementptr [32 x i32], ptr %regFile, i32 0, i32 8
  store i32 %241, ptr %242, align 4
  %243 = getelementptr [32 x i32], ptr %regFile, i32 0, i32 6
  %244 = load i32, ptr %243, align 4
  %245 = add i32 %244, -1
  %246 = getelementptr [32 x i32], ptr %regFile, i32 0, i32 9
  store i32 %245, ptr %246, align 4
  %247 = getelementptr [32 x i32], ptr %regFile, i32 0, i32 9
  %248 = load i32, ptr %247, align 4
  %249 = icmp ult i32 %248, 511
  %250 = zext i1 %249 to i32
  %251 = getelementptr [32 x i32], ptr %regFile, i32 0, i32 9
  store i32 %250, ptr %251, align 4
  %252 = getelementptr [32 x i32], ptr %regFile, i32 0, i32 8
  %253 = load i32, ptr %252, align 4
  %254 = getelementptr [32 x i32], ptr %regFile, i32 0, i32 9
  %255 = load i32, ptr %254, align 4
  %256 = sub i32 %253, %255
  %257 = getelementptr [32 x i32], ptr %regFile, i32 0, i32 10
  store i32 %256, ptr %257, align 4
  %258 = getelementptr [32 x i32], ptr %regFile, i32 0, i32 6
  %259 = load i32, ptr %258, align 4
  %260 = icmp ult i32 %259, 511
  %261 = zext i1 %260 to i32
  %262 = getelementptr [32 x i32], ptr %regFile, i32 0, i32 9
  store i32 %261, ptr %262, align 4
  %263 = getelementptr [32 x i32], ptr %regFile, i32 0, i32 8
  %264 = load i32, ptr %263, align 4
  %265 = getelementptr [32 x i32], ptr %regFile, i32 0, i32 9
  %266 = load i32, ptr %265, align 4
  %267 = add i32 %264, %266
  %268 = getelementptr [32 x i32], ptr %regFile, i32 0, i32 11
  store i32 %267, ptr %268, align 4
  %269 = getelementptr [32 x i32], ptr %regFile, i32 0, i32 10
  %270 = load i32, ptr %269, align 4
  %271 = add i32 %270, 0
  %272 = getelementptr inbounds i32, ptr @mem, i32 %271
  %273 = load i32, ptr %272, align 4
  %274 = getelementptr [32 x i32], ptr %regFile, i32 0, i32 10
  store i32 %273, ptr %274, align 4
  %275 = getelementptr [32 x i32], ptr %regFile, i32 0, i32 11
  %276 = load i32, ptr %275, align 4
  %277 = add i32 %276, 0
  %278 = getelementptr inbounds i32, ptr @mem, i32 %277
  %279 = load i32, ptr %278, align 4
  %280 = getelementptr [32 x i32], ptr %regFile, i32 0, i32 11
  store i32 %279, ptr %280, align 4
  %281 = getelementptr [32 x i32], ptr %regFile, i32 0, i32 10
  %282 = load i32, ptr %281, align 4
  %283 = getelementptr [32 x i32], ptr %regFile, i32 0, i32 11
  %284 = load i32, ptr %283, align 4
  %285 = sub i32 %282, %284
  %286 = getelementptr [32 x i32], ptr %regFile, i32 0, i32 10
  store i32 %285, ptr %286, align 4
  %287 = getelementptr [32 x i32], ptr %regFile, i32 0, i32 8
  %288 = load i32, ptr %287, align 4
  %289 = add i32 %288, 0
  %290 = getelementptr inbounds i32, ptr @mem, i32 %289
  %291 = load i32, ptr %290, align 4
  %292 = getelementptr [32 x i32], ptr %regFile, i32 0, i32 12
  store i32 %291, ptr %292, align 4
  %293 = getelementptr [32 x i32], ptr %regFile, i32 0, i32 12
  %294 = load i32, ptr %293, align 4
  %295 = ashr i32 %294, 3
  %296 = getelementptr [32 x i32], ptr %regFile, i32 0, i32 12
  store i32 %295, ptr %296, align 4
  %297 = getelementptr [32 x i32], ptr %regFile, i32 0, i32 10
  %298 = load i32, ptr %297, align 4
  %299 = ashr i32 %298, 1
  %300 = getelementptr [32 x i32], ptr %regFile, i32 0, i32 10
  store i32 %299, ptr %300, align 4
  %301 = getelementptr [32 x i32], ptr %regFile, i32 0, i32 12
  %302 = load i32, ptr %301, align 4
  %303 = getelementptr [32 x i32], ptr %regFile, i32 0, i32 10
  %304 = load i32, ptr %303, align 4
  %305 = add i32 %302, %304
  %306 = getelementptr [32 x i32], ptr %regFile, i32 0, i32 12
  store i32 %305, ptr %306, align 4
  %307 = getelementptr [32 x i32], ptr %regFile, i32 0, i32 12
  %308 = load i32, ptr %307, align 4
  %309 = add i32 %308, 120
  %310 = getelementptr [32 x i32], ptr %regFile, i32 0, i32 12
  store i32 %309, ptr %310, align 4
  %311 = getelementptr [32 x i32], ptr %regFile, i32 0, i32 12
  %312 = load i32, ptr %311, align 4
  %313 = icmp slt i32 %312, 0
  %314 = select i1 %313, i32 0, i32 %312
  %315 = icmp sgt i32 %314, 255
  %316 = select i1 %315, i32 255, i32 %314
  %317 = getelementptr [32 x i32], ptr %regFile, i32 0, i32 12
  store i32 %316, ptr %317, align 4
  %318 = getelementptr [32 x i32], ptr %regFile, i32 0, i32 12
  %319 = load i32, ptr %318, align 4
  %320 = ashr i32 %319, 3
  %321 = getelementptr [32 x i32], ptr %regFile, i32 0, i32 13
  store i32 %320, ptr %321, align 4
  %322 = getelementptr [32 x i32], ptr %regFile, i32 0, i32 12
  %323 = load i32, ptr %322, align 4
  %324 = mul i32 %323, 5
  %325 = getelementptr [32 x i32], ptr %regFile, i32 0, i32 14
  store i32 %324, ptr %325, align 4
  %326 = getelementptr [32 x i32], ptr %regFile, i32 0, i32 14
  %327 = load i32, ptr %326, align 4
  %328 = ashr i32 %327, 3
  %329 = getelementptr [32 x i32], ptr %regFile, i32 0, i32 14
  store i32 %328, ptr %329, align 4
  %330 = getelementptr [32 x i32], ptr %regFile, i32 0, i32 13
  %331 = load i32, ptr %330, align 4
  %332 = shl i32 %331, 16
  %333 = getelementptr [32 x i32], ptr %regFile, i32 0, i32 13
  store i32 %332, ptr %333, align 4
  %334 = getelementptr [32 x i32], ptr %regFile, i32 0, i32 14
  %335 = load i32, ptr %334, align 4
  %336 = shl i32 %335, 8
  %337 = getelementptr [32 x i32], ptr %regFile, i32 0, i32 14
  store i32 %336, ptr %337, align 4
  %338 = getelementptr [32 x i32], ptr %regFile, i32 0, i32 13
  %339 = load i32, ptr %338, align 4
  %340 = getelementptr [32 x i32], ptr %regFile, i32 0, i32 14
  %341 = load i32, ptr %340, align 4
  %342 = or i32 %339, %341
  %343 = getelementptr [32 x i32], ptr %regFile, i32 0, i32 13
  store i32 %342, ptr %343, align 4
  %344 = getelementptr [32 x i32], ptr %regFile, i32 0, i32 13
  %345 = load i32, ptr %344, align 4
  %346 = getelementptr [32 x i32], ptr %regFile, i32 0, i32 12
  %347 = load i32, ptr %346, align 4
  %348 = or i32 %345, %347
  %349 = getelementptr [32 x i32], ptr %regFile, i32 0, i32 13
  store i32 %348, ptr %349, align 4
  %350 = getelementptr [32 x i32], ptr %regFile, i32 0, i32 13
  %351 = load i32, ptr %350, align 4
  %352 = or i32 %351, -16777216
  %353 = getelementptr [32 x i32], ptr %regFile, i32 0, i32 13
  store i32 %352, ptr %353, align 4
  %354 = getelementptr [32 x i32], ptr %regFile, i32 0, i32 6
  %355 = load i32, ptr %354, align 4
  %356 = mul i32 %355, 3
  %357 = getelementptr [32 x i32], ptr %regFile, i32 0, i32 5
  %358 = load i32, ptr %357, align 4
  %359 = mul i32 %358, 3
  %360 = getelementptr [32 x i32], ptr %regFile, i32 0, i32 13
  %361 = load i32, ptr %360, align 4
  %362 = add i32 %356, 0
  %363 = add i32 %359, 0
  call void @simPutPixel(i32 %362, i32 %363, i32 %361)
  %364 = add i32 %356, 1
  %365 = add i32 %359, 0
  call void @simPutPixel(i32 %364, i32 %365, i32 %361)
  %366 = add i32 %356, 2
  %367 = add i32 %359, 0
  call void @simPutPixel(i32 %366, i32 %367, i32 %361)
  %368 = add i32 %356, 0
  %369 = add i32 %359, 1
  call void @simPutPixel(i32 %368, i32 %369, i32 %361)
  %370 = add i32 %356, 1
  %371 = add i32 %359, 1
  call void @simPutPixel(i32 %370, i32 %371, i32 %361)
  %372 = add i32 %356, 2
  %373 = add i32 %359, 1
  call void @simPutPixel(i32 %372, i32 %373, i32 %361)
  %374 = add i32 %356, 0
  %375 = add i32 %359, 2
  call void @simPutPixel(i32 %374, i32 %375, i32 %361)
  %376 = add i32 %356, 1
  %377 = add i32 %359, 2
  call void @simPutPixel(i32 %376, i32 %377, i32 %361)
  %378 = add i32 %356, 2
  %379 = add i32 %359, 2
  call void @simPutPixel(i32 %378, i32 %379, i32 %361)
  %380 = getelementptr [32 x i32], ptr %regFile, i32 0, i32 6
  %381 = load i32, ptr %380, align 4
  %382 = add i32 %381, 1
  %383 = getelementptr [32 x i32], ptr %regFile, i32 0, i32 6
  store i32 %382, ptr %383, align 4
  %384 = icmp ne i32 %382, 512
  %385 = zext i1 %384 to i32
  %386 = getelementptr [32 x i32], ptr %regFile, i32 0, i32 4
  store i32 %385, ptr %386, align 4
  %387 = getelementptr [32 x i32], ptr %regFile, i32 0, i32 4
  %388 = load i32, ptr %387, align 4
  %389 = icmp ne i32 %388, 0
  br i1 %389, label %rn_x, label %rn_ynext

rn_ynext:                                         ; preds = %rn_x
  %390 = getelementptr [32 x i32], ptr %regFile, i32 0, i32 5
  %391 = load i32, ptr %390, align 4
  %392 = add i32 %391, 1
  %393 = getelementptr [32 x i32], ptr %regFile, i32 0, i32 5
  store i32 %392, ptr %393, align 4
  %394 = icmp ne i32 %392, 256
  %395 = zext i1 %394 to i32
  %396 = getelementptr [32 x i32], ptr %regFile, i32 0, i32 4
  store i32 %395, ptr %396, align 4
  %397 = getelementptr [32 x i32], ptr %regFile, i32 0, i32 4
  %398 = load i32, ptr %397, align 4
  %399 = icmp ne i32 %398, 0
  br i1 %399, label %rn_y, label %frame

frame:                                            ; preds = %rn_ynext
  call void @simFlush()
  %400 = getelementptr [32 x i32], ptr %regFile, i32 0, i32 3
  %401 = load i32, ptr %400, align 4
  %402 = and i32 %401, 15
  %403 = getelementptr [32 x i32], ptr %regFile, i32 0, i32 8
  store i32 %402, ptr %403, align 4
  %404 = getelementptr [32 x i32], ptr %regFile, i32 0, i32 8
  %405 = load i32, ptr %404, align 4
  %406 = icmp ne i32 %405, 0
  br i1 %406, label %no_drop, label %rnd

rnd:                                              ; preds = %frame
  %407 = call i32 @simRand()
  %408 = getelementptr [32 x i32], ptr %regFile, i32 0, i32 16
  store i32 %407, ptr %408, align 4
  %409 = getelementptr [32 x i32], ptr %regFile, i32 0, i32 16
  %410 = load i32, ptr %409, align 4
  %411 = and i32 %410, 1073741823
  %412 = getelementptr [32 x i32], ptr %regFile, i32 0, i32 16
  store i32 %411, ptr %412, align 4
  %413 = getelementptr [32 x i32], ptr %regFile, i32 0, i32 16
  %414 = load i32, ptr %413, align 4
  %415 = urem i32 %414, 504
  %416 = getelementptr [32 x i32], ptr %regFile, i32 0, i32 16
  store i32 %415, ptr %416, align 4
  %417 = getelementptr [32 x i32], ptr %regFile, i32 0, i32 16
  %418 = load i32, ptr %417, align 4
  %419 = add i32 %418, 4
  %420 = getelementptr [32 x i32], ptr %regFile, i32 0, i32 16
  store i32 %419, ptr %420, align 4
  %421 = call i32 @simRand()
  %422 = getelementptr [32 x i32], ptr %regFile, i32 0, i32 17
  store i32 %421, ptr %422, align 4
  %423 = getelementptr [32 x i32], ptr %regFile, i32 0, i32 17
  %424 = load i32, ptr %423, align 4
  %425 = and i32 %424, 1073741823
  %426 = getelementptr [32 x i32], ptr %regFile, i32 0, i32 17
  store i32 %425, ptr %426, align 4
  %427 = getelementptr [32 x i32], ptr %regFile, i32 0, i32 17
  %428 = load i32, ptr %427, align 4
  %429 = urem i32 %428, 248
  %430 = getelementptr [32 x i32], ptr %regFile, i32 0, i32 17
  store i32 %429, ptr %430, align 4
  %431 = getelementptr [32 x i32], ptr %regFile, i32 0, i32 17
  %432 = load i32, ptr %431, align 4
  %433 = add i32 %432, 4
  %434 = getelementptr [32 x i32], ptr %regFile, i32 0, i32 17
  store i32 %433, ptr %434, align 4
  %435 = getelementptr [32 x i32], ptr %regFile, i32 0, i32 19
  store i32 -3, ptr %435, align 4
  br label %d1_j

d1_j:                                             ; preds = %d1_jnext, %rnd
  %436 = getelementptr [32 x i32], ptr %regFile, i32 0, i32 18
  store i32 -3, ptr %436, align 4
  br label %d1_i

d1_i:                                             ; preds = %d1_skip, %d1_j
  %437 = getelementptr [32 x i32], ptr %regFile, i32 0, i32 16
  %438 = load i32, ptr %437, align 4
  %439 = getelementptr [32 x i32], ptr %regFile, i32 0, i32 18
  %440 = load i32, ptr %439, align 4
  %441 = add i32 %438, %440
  %442 = getelementptr [32 x i32], ptr %regFile, i32 0, i32 8
  store i32 %441, ptr %442, align 4
  %443 = getelementptr [32 x i32], ptr %regFile, i32 0, i32 17
  %444 = load i32, ptr %443, align 4
  %445 = getelementptr [32 x i32], ptr %regFile, i32 0, i32 19
  %446 = load i32, ptr %445, align 4
  %447 = add i32 %444, %446
  %448 = getelementptr [32 x i32], ptr %regFile, i32 0, i32 9
  store i32 %447, ptr %448, align 4
  %449 = getelementptr [32 x i32], ptr %regFile, i32 0, i32 8
  %450 = load i32, ptr %449, align 4
  %451 = add i32 %450, -1
  %452 = getelementptr [32 x i32], ptr %regFile, i32 0, i32 10
  store i32 %451, ptr %452, align 4
  %453 = getelementptr [32 x i32], ptr %regFile, i32 0, i32 10
  %454 = load i32, ptr %453, align 4
  %455 = icmp ult i32 %454, 510
  %456 = zext i1 %455 to i32
  %457 = getelementptr [32 x i32], ptr %regFile, i32 0, i32 10
  store i32 %456, ptr %457, align 4
  %458 = getelementptr [32 x i32], ptr %regFile, i32 0, i32 9
  %459 = load i32, ptr %458, align 4
  %460 = add i32 %459, -1
  %461 = getelementptr [32 x i32], ptr %regFile, i32 0, i32 11
  store i32 %460, ptr %461, align 4
  %462 = getelementptr [32 x i32], ptr %regFile, i32 0, i32 11
  %463 = load i32, ptr %462, align 4
  %464 = icmp ult i32 %463, 254
  %465 = zext i1 %464 to i32
  %466 = getelementptr [32 x i32], ptr %regFile, i32 0, i32 11
  store i32 %465, ptr %466, align 4
  %467 = getelementptr [32 x i32], ptr %regFile, i32 0, i32 10
  %468 = load i32, ptr %467, align 4
  %469 = getelementptr [32 x i32], ptr %regFile, i32 0, i32 11
  %470 = load i32, ptr %469, align 4
  %471 = and i32 %468, %470
  %472 = getelementptr [32 x i32], ptr %regFile, i32 0, i32 10
  store i32 %471, ptr %472, align 4
  %473 = getelementptr [32 x i32], ptr %regFile, i32 0, i32 10
  %474 = load i32, ptr %473, align 4
  %475 = icmp eq i32 %474, 0
  br i1 %475, label %d1_skip, label %d1_add

d1_add:                                           ; preds = %d1_i
  %476 = getelementptr [32 x i32], ptr %regFile, i32 0, i32 9
  %477 = load i32, ptr %476, align 4
  %478 = shl i32 %477, 9
  %479 = getelementptr [32 x i32], ptr %regFile, i32 0, i32 12
  store i32 %478, ptr %479, align 4
  %480 = getelementptr [32 x i32], ptr %regFile, i32 0, i32 12
  %481 = load i32, ptr %480, align 4
  %482 = getelementptr [32 x i32], ptr %regFile, i32 0, i32 8
  %483 = load i32, ptr %482, align 4
  %484 = add i32 %481, %483
  %485 = getelementptr [32 x i32], ptr %regFile, i32 0, i32 12
  store i32 %484, ptr %485, align 4
  %486 = getelementptr [32 x i32], ptr %regFile, i32 0, i32 12
  %487 = load i32, ptr %486, align 4
  %488 = getelementptr [32 x i32], ptr %regFile, i32 0, i32 1
  %489 = load i32, ptr %488, align 4
  %490 = add i32 %487, %489
  %491 = getelementptr [32 x i32], ptr %regFile, i32 0, i32 12
  store i32 %490, ptr %491, align 4
  %492 = getelementptr [32 x i32], ptr %regFile, i32 0, i32 12
  %493 = load i32, ptr %492, align 4
  %494 = add i32 %493, 0
  %495 = getelementptr inbounds i32, ptr @mem, i32 %494
  %496 = load i32, ptr %495, align 4
  %497 = getelementptr [32 x i32], ptr %regFile, i32 0, i32 13
  store i32 %496, ptr %497, align 4
  %498 = getelementptr [32 x i32], ptr %regFile, i32 0, i32 13
  %499 = load i32, ptr %498, align 4
  %500 = add i32 %499, 640
  %501 = getelementptr [32 x i32], ptr %regFile, i32 0, i32 13
  store i32 %500, ptr %501, align 4
  %502 = getelementptr [32 x i32], ptr %regFile, i32 0, i32 13
  %503 = load i32, ptr %502, align 4
  %504 = getelementptr [32 x i32], ptr %regFile, i32 0, i32 12
  %505 = load i32, ptr %504, align 4
  %506 = add i32 %505, 0
  %507 = getelementptr inbounds i32, ptr @mem, i32 %506
  store i32 %503, ptr %507, align 4
  br label %d1_skip

d1_skip:                                          ; preds = %d1_add, %d1_i
  %508 = getelementptr [32 x i32], ptr %regFile, i32 0, i32 18
  %509 = load i32, ptr %508, align 4
  %510 = add i32 %509, 1
  %511 = getelementptr [32 x i32], ptr %regFile, i32 0, i32 18
  store i32 %510, ptr %511, align 4
  %512 = icmp ne i32 %510, 4
  %513 = zext i1 %512 to i32
  %514 = getelementptr [32 x i32], ptr %regFile, i32 0, i32 4
  store i32 %513, ptr %514, align 4
  %515 = getelementptr [32 x i32], ptr %regFile, i32 0, i32 4
  %516 = load i32, ptr %515, align 4
  %517 = icmp ne i32 %516, 0
  br i1 %517, label %d1_i, label %d1_jnext

d1_jnext:                                         ; preds = %d1_skip
  %518 = getelementptr [32 x i32], ptr %regFile, i32 0, i32 19
  %519 = load i32, ptr %518, align 4
  %520 = add i32 %519, 1
  %521 = getelementptr [32 x i32], ptr %regFile, i32 0, i32 19
  store i32 %520, ptr %521, align 4
  %522 = icmp ne i32 %520, 4
  %523 = zext i1 %522 to i32
  %524 = getelementptr [32 x i32], ptr %regFile, i32 0, i32 4
  store i32 %523, ptr %524, align 4
  %525 = getelementptr [32 x i32], ptr %regFile, i32 0, i32 4
  %526 = load i32, ptr %525, align 4
  %527 = icmp ne i32 %526, 0
  br i1 %527, label %d1_j, label %no_drop

no_drop:                                          ; preds = %d1_jnext, %frame
  %528 = getelementptr [32 x i32], ptr %regFile, i32 0, i32 3
  %529 = load i32, ptr %528, align 4
  %530 = add i32 %529, 1
  %531 = getelementptr [32 x i32], ptr %regFile, i32 0, i32 3
  store i32 %530, ptr %531, align 4
  br label %main_loop
}

declare void @simPutPixel(i32, i32, i32)

declare void @simFlush()

declare i32 @simRand()
