// Summary: removed unnecessary stipple + improved shadow filter + added PCSS thanks to robi29 + improved shadow fadeout
// Generated by Microsoft (R) HLSL Shader Compiler 9.26.952.2844
//
// Parameters:
//
//   sampler2D BumpSampler;
//   sampler2D StippleTexture;
//   sampler2D TextureSampler;
//   float bumpiness;
//   float4 gDirectionalColour;
//   float4 gDirectionalLight;
//   float4 gFacetCentre;
//   float4 gLightAmbient0;
//   float4 gLightAmbient1;
//   float4 gLightColB;
//   float4 gLightColG;
//   float4 gLightColR;
//   float4 gLightConeOffset;
//   float4 gLightConeOffset2;
//   float4 gLightConeScale;
//   float4 gLightConeScale2;
//   float4 gLightDir2X;
//   float4 gLightDir2Y;
//   float4 gLightDir2Z;
//   float4 gLightDirX;
//   float4 gLightDirY;
//   float4 gLightDirZ;
//   float4 gLightFallOff;
//   float4 gLightPointColB;
//   float4 gLightPointColG;
//   float4 gLightPointColR;
//   float4 gLightPointFallOff;
//   float4 gLightPointPosX;
//   float4 gLightPointPosY;
//   float4 gLightPointPosZ;
//   float4 gLightPosX;
//   float4 gLightPosY;
//   float4 gLightPosZ;
//   row_major float4x4 gShadowMatrix;
//   float4 gShadowParam0123;
//   float4 gShadowParam14151617;
//   float4 gShadowParam18192021;
//   float4 gShadowParam4567;
//   float4 gShadowParam891113;
//   sampler2D gShadowZSamplerDir;
//   row_major float4x4 gViewInverse;
//   float4 globalScalars;
//   float specularColorFactor;
//   float specularFactor;
//
//
// Registers:
//
//   Name                 Reg   Size
//   -------------------- ----- ----
//   gViewInverse         c12      4
//   gDirectionalLight    c17      1
//   gDirectionalColour   c18      1
//   gLightPosX           c19      1
//   gLightPosY           c20      1
//   gLightPosZ           c21      1
//   gLightDirX           c22      1
//   gLightDirY           c23      1
//   gLightDirZ           c24      1
//   gLightFallOff        c25      1
//   gLightConeScale      c26      1
//   gLightConeOffset     c27      1
//   gLightColR           c29      1
//   gLightColG           c30      1
//   gLightColB           c31      1
//   gLightPointPosX      c32      1
//   gLightPointPosY      c33      1
//   gLightPointPosZ      c34      1
//   gLightPointColR      c35      1
//   gLightPointFallOff   c36      1
//   gLightAmbient0       c37      1
//   gLightAmbient1       c38      1
//   globalScalars        c39      1
//   gShadowParam18192021 c53      1
//   gFacetCentre         c54      1
//   gShadowParam14151617 c56      1
//   gShadowParam0123     c57      1
//   gShadowParam4567     c58      1
//   gShadowParam891113   c59      1
//   gShadowMatrix        c60      4
//   gLightPointColG      c64      1
//   gLightPointColB      c65      1
//   specularFactor       c66      1
//   gLightDir2X          c67      1
//   gLightDir2Y          c68      1
//   gLightDir2Z          c69      1
//   gLightConeScale2     c70      1
//   gLightConeOffset2    c71      1
//   specularColorFactor  c72      1
//   bumpiness            c73      1
//   TextureSampler       s0       1
//   BumpSampler          s1       1
//   StippleTexture       s10      1
//   gShadowZSamplerDir   s15      1
//

    ps_3_0
	// ----------------------------------------------------- Improved Shadow Filter Constants -------------------------------------------------------
    def c110, -0.25, 1, -1, 0
    def c111, 0.159154937, 0.5, 6.28318548, -3.14159274
    def c112, 3, 7.13800001, 2, 0.3333333
    def c113, 0.75, -0.5, 0.5, 0
	def c114, -1.25, 2, -2, 0 // c114-c117 = offsets for extra samples
	def c115, 1.75, -1.5, 1.5, 0
	def c116, -2.25, 3, -3, 0
	def c117, 2.75, -2.5, 2.5, 0
	
    def c118, 0.1, 0.22, 0.5, 0.8 // c118-c121 = biases for each cascade of each quality setting
    def c119, 0.22, 0.42, 1.07, 1.22
    def c120, 0.28, 0.53, 0.98, 1.08
    def c121, 0.5, 0.8, 1.35, 1.5
	
	def c122, 4, 3, 2, 1 // quality ID's
	def c123, 0.15, 0, 0, 0 // end bias
	
	def c124, -17, 6, 0.045, 0 // PCSS constants
    defi i1, 6, 0, 0, 0
	// ----------------------------------------------------------------------------------------------------------------------------------------------
    def c219, 1.8395173895e+25, 3.9938258725e+24, 4.5435787456e+30, 1.9057659115e-43 // 136
    def c127, 0.9999999, 1, 0, 0	// LogDepth constants
    def c0, 1, -0.5, 9.99999975e-006, 0.5
    def c1, -0.25, 1.33333337, 1, 0
    def c2, 3.99600005, 4, 0.125, 9.99999975e-005
    def c3, 1.5, -0.326211989, -0.405809999, 0.0833333358
    def c4, -0.791558981, -0.597710013, -0.100000001, 1.11111116
    def c5, 1, -1, 0, -0
    def c6, 0.896420002, 0.412458003, -0.321940005, -0.932614982
    def c7, 0.185461, -0.893123984, 0.507430971, 0.0644249991
    def c8, 0.473434001, -0.480026007, 0.519456029, 0.767022014
    def c9, -0.203345001, 0.620715976, 0.962339997, -0.194983006
    def c10, -0.840143979, -0.0735799968, -0.69591397, 0.457136989
    dcl_texcoord v0.xy
    dcl_texcoord1 v1.xyz
    dcl_texcoord3 v2.xyz
    dcl_texcoord4 v3.xyz
    dcl_texcoord5 v4.xyz
    dcl_color v5
    dcl_texcoord6 v6.xyz
    dcl vPos.xy
    dcl_texcoord9 v9
    dcl_2d s0
    dcl_2d s1
    dcl_2d s10
    dcl_2d s15
    texld r0, v0, s1
    add r0.z, -r0.w, c0.x
    add r0.z, -r0.x, r0.z
    cmp r0.xy, r0.z, r0.wyzw, r0
    texld r1, v0, s0
    add r0.zw, r0.xyxy, c0.y
    mul r0.zw, r0, c73.x
    dp2add r0.x, r0, -r0, c0.x
    rsq r0.x, r0.x
    rcp r0.x, r0.x
    mul r2.xyz, r0.z, v3
    mad r0.xyz, v1, r0.x, r2
    mad r0.xyz, r0.w, v4, r0
    add r0.xyz, r0, c0.z
    nrm r2.xyz, r0
    mul r0, r1, v5
    mad_sat r1.x, r2.z, c0.y, c0.w
    mov r3.xyz, c38
    mad r1.xyz, r3, r1.x, c37
    mul r3.xyz, c18.w, c18
    dp3 r1.w, r2, -c17
    add r1.w, r1.w, c1.x
    mul_sat r1.w, r1.w, c1.y
    mul r4.xyz, c61.xyww, v6.y
    mad r4.xyz, v6.x, c60.xyww, r4
    mad r4.xyz, v6.z, c62.xyww, r4
    add r4.xyz, r4, c63.xyww
    dp3 r2.w, c14, v6
    add r5.xyz, -r2.w, -c54
    cmp r5.yzw, r5.xxyz, c1.z, c1.w
	// ---------------------------------------------------------------- Cascade Mask ----------------------------------------------------------------
	mov r21.x, c110.y
	mov r21.yzw, r5
	add r21.xyz, r21.xyz, -r21.yzw
	// ----------------------------------------------------------------------------------------------------------------------------------------------
    mov r5.x, c0.x
    dp4 r6.x, r5, c57
    dp4 r6.y, r5, c58
    dp4 r7.x, r5, c59
    dp4 r7.y, r5, c56
    mad r4.xy, r4, r6, r7
    add r5.xyz, c15, -v6
    dp3 r2.w, r5, r5
    rsq r2.w, r2.w
    rcp r2.w, r2.w
    rcp r3.w, c53.w
    mul r3.w, r2.w, r3.w
    mul r3.w, r3.w, r3.w // improved shadow fadeout
    mul r3.w, r3.w, r3.w
    mul r3.w, r3.w, c3.x
    /* removed 1.0.6.0 filter
    mov r5.y, c53.y
    mad r5.xz, r5.y, c3.yyzw, r4.xyyw
    texld r6, r5.xzzw, s15
    add r4.w, r4.z, -r6.x
    cmp r4.w, r4.w, c1.z, c1.w
    mad r5.xz, r5.y, c10.xyyw, r4.xyyw
    texld r6, r5.xzzw, s15
    add r5.x, r4.z, -r6.x
    cmp r5.x, r5.x, c1.z, c1.w
    add r4.w, r4.w, r5.x
    mad r5.xz, r5.y, c10.zyww, r4.xyyw
    texld r6, r5.xzzw, s15
    add r5.x, r4.z, -r6.x
    cmp r5.x, r5.x, c1.z, c1.w
    add r4.w, r4.w, r5.x
    mad r5.xz, r5.y, c9.xyyw, r4.xyyw
    texld r6, r5.xzzw, s15
    add r5.x, r4.z, -r6.x
    cmp r5.x, r5.x, c1.z, c1.w
    add r4.w, r4.w, r5.x
    mad r5.xz, r5.y, c9.zyww, r4.xyyw
    texld r6, r5.xzzw, s15
    add r5.x, r4.z, -r6.x
    cmp r5.x, r5.x, c1.z, c1.w
    add r4.w, r4.w, r5.x
    mad r5.xz, r5.y, c8.xyyw, r4.xyyw
    texld r6, r5.xzzw, s15
    add r5.x, r4.z, -r6.x
    cmp r5.x, r5.x, c1.z, c1.w
    add r4.w, r4.w, r5.x
    mad r5.xz, r5.y, c8.zyww, r4.xyyw
    texld r6, r5.xzzw, s15
    add r5.x, r4.z, -r6.x
    cmp r5.x, r5.x, c1.z, c1.w
    add r4.w, r4.w, r5.x
    mad r5.xz, r5.y, c7.xyyw, r4.xyyw
    texld r6, r5.xzzw, s15
    add r5.x, r4.z, -r6.x
    cmp r5.x, r5.x, c1.z, c1.w
    add r4.w, r4.w, r5.x
    mad r5.xz, r5.y, c7.zyww, r4.xyyw
    texld r6, r5.xzzw, s15
    add r5.x, r4.z, -r6.x
    cmp r5.x, r5.x, c1.z, c1.w
    add r4.w, r4.w, r5.x
    mad r5.xz, r5.y, c6.xyyw, r4.xyyw
    texld r6, r5.xzzw, s15
    add r5.x, r4.z, -r6.x
    cmp r5.x, r5.x, c1.z, c1.w
    add r4.w, r4.w, r5.x
    mad r5.xz, r5.y, c6.zyww, r4.xyyw
    texld r6, r5.xzzw, s15
    add r5.x, r4.z, -r6.x
    cmp r5.x, r5.x, c1.z, c1.w
    add r4.w, r4.w, r5.x
    mad r4.xy, r5.y, c4, r4
    texld r5, r4, s15
    add r4.x, r4.z, -r5.x
    cmp r4.x, r4.x, c1.z, c1.w
    add r4.x, r4.w, r4.x
    removed 1.0.6.0 filter */
	// ---------------------------------------------------------- Improved Shadow Filter ------------------------------------------------------------
	add r22, c54.w, -c54
	add r22, c53.w, -r22 // cascade distances
	rcp r23.x, r22.x
	dp4 r23.y, r22, r21
	rcp r23.y, r23.y
	mul r20.z, r23.y, r22.x
	mul r20.xy, c53.xy, r20.z // apply per cascade blur
	mov r24, c122
	add r24, r24, -c221.y
	add_sat r24, c110.y, -r24_abs
	m4x4 r25, r21, c118
	dp4 r20.w, r25, r24
	mov r24, c110.ywww
	add r4.z, r4.z, -r20.w // apply per cascade bias
	if_ne r24.z, c223.y // PCSS
		mov r24.xyw, c110.w // sum
		mul r25.xy, r20.z, c124.xy // pcss texel step
		mov r25.zw, r25.x // x - inner loop index, y - outer loop index
		rep i1
			mul r24.z, r25.w, c124.z
			rep i1
				mad r26.xy, c53.xy, r25.zw, r4.xy
				texldl r27, r26.xy, s15
				add r26.x, r27.x, -r4.z
				if_gt r26.x, r24.z
					min r26.x, r26.x, -c124.x
					add r24.x, r24.x, r26.x
					add r24.w, r24.w, c110.y // blockers
				endif
				add r25.z, r25.z, r25.y // j++
			endrep
			add r25.w, r25.w, r25.y // i++
			mov r25.z, r25.x // j = -33
		endrep
		if_gt r24.w, c110.w // avg if any blockers
			rcp r24.w, r24.w
			mul r24.x, r24.x, r24.w
			rsq r24.x, r24.x
			rcp r24.x, r24.x
			max r24.x, r24.x, c111.y // minimum factor
		else
			mov r24.x, c110.y
		endif
	endif
	add r22.x, r2.w, -r22.x
	add r22.y, c54.z, -c54.x
	rcp r22.y, r22.y
	mul_sat r22.x, r22.x, r22.y
	mul r22.x, r22.x, r22.x
	mul r22.y, r23.x, c53.w
	mov r22.z, c123.x
	lrp r23.xy, r22.x, r22.yz, r24.xy
	mul r20.xy, r20.xy, r23.x // apply depth based blur
	add r4.z, r4.z, r23.y // apply depth based bias
	
    mov r21.xy, c112.xy
    dp2add r21.y, vPos, r21, c110.w		// v0.x * r21.x + v0.y * r21.y
    mad r21.y, r21.y, c111.x, c111.y
    frc r21.y, r21.y
    mad r21.y, r21.y, c111.z, c111.w	// r21.y * 2pi - pi
    sincos r22.xy, r21.y				// cosine & sine of r21.y
    mul r23, r22.yxxy, c110.xxyz		// offsets for 1st and 4th samples, respectively
    mul r21, r22.yxxy, c113.xxyz        // offsets for 3rd and 2nd samples, respectively
	mul r20.xy, r20.xy, c112.z			// blur factor
	
    mad r24.xy, r23.xy, r20.xy, r4.xy	// offset * texel size + UV
    texld r24, r24, s15					// 1st sample
    mov r25.x, r24.x					// copy to r25
    mad r24.xy, r21.zw, r20.xy, r4.xy	// offset * texel size + UV
    texld r24, r24, s15					// 2nd sample
    mov r25.y, r24.x					// copy to r25
    mad r24.xy, r21.xy, r20.xy, r4.xy	// offset * texel size + UV
    texld r24, r24, s15					// 3rd sample
    mov r25.z, r24.x					// copy to r25
    mad r24.xy, r23.zw, r20.xy, r4.xy	// offset * texel size + UV
    texld r24, r24, s15					// 4th sample
    mov r25.w, r24.x					// copy to r25
	add r25, r4.z, -r25					// depth bias
	cmp r25, r25, c110.y, c110.w
	dp4 r26.x, r25, -c110.x				// average
	
    mul r23, r22.yxxy, c114.xxyz		// offsets for 5th and 8th samples, respectively
    mul r21, r22.yxxy, c115.xxyz        // offsets for 7th and 6th samples, respectively
	
    mad r24.xy, r23.xy, r20.xy, r4.xy	// offset * texel size + UV
    texld r24, r24, s15					// 5th sample
    mov r25.x, r24.x					// copy to r25
    mad r24.xy, r21.zw, r20.xy, r4.xy	// offset * texel size + UV
    texld r24, r24, s15					// 6th sample
    mov r25.y, r24.x					// copy to r25
    mad r24.xy, r21.xy, r20.xy, r4.xy	// offset * texel size + UV
    texld r24, r24, s15					// 7th sample
    mov r25.z, r24.x					// copy to r25
    mad r24.xy, r23.zw, r20.xy, r4.xy	// offset * texel size + UV
    texld r24, r24, s15					// 8th sample
    mov r25.w, r24.x					// copy to r25
	add r25, r4.z, -r25					// depth bias
	cmp r25, r25, c110.y, c110.w
	dp4 r26.y, r25, -c110.x				// average
	
    mul r23, r22.yxxy, c116.xxyz		// offsets for 9th and 12th samples, respectively
    mul r21, r22.yxxy, c117.xxyz        // offsets for 11th and 10th samples, respectively
	
    mad r24.xy, r23.xy, r20.xy, r4.xy	// offset * texel size + UV
    texld r24, r24, s15					// 9th sample
    mov r25.x, r24.x					// copy to r25
    mad r24.xy, r21.zw, r20.xy, r4.xy	// offset * texel size + UV
    texld r24, r24, s15					// 10th sample
    mov r25.y, r24.x					// copy to r25
    mad r24.xy, r21.xy, r20.xy, r4.xy	// offset * texel size + UV
    texld r24, r24, s15					// 11th sample
    mov r25.z, r24.x					// copy to r25
    mad r24.xy, r23.zw, r20.xy, r4.xy	// offset * texel size + UV
    texld r24, r24, s15					// 12th sample
    mov r25.w, r24.x					// copy to r25
	add r25, r4.z, -r25					// depth bias
	cmp r25, r25, c110.y, c110.w
	dp4 r26.z, r25, -c110.x				// average
	
	dp3 r4.x, r26, c112.w
	// ----------------------------------------------------------------------------------------------------------------------------------------------
    add r3.w, r4.x, r3.w // mad r3.w, r4.x, c3.w, r3.w 1.0.6.0 filter average
    add r2.w, r2.w, -c53.w
    cmp r4.xy, r2.w, c5, c5.zwzw
    add r2.w, r3.w, r4.y
    cmp_sat r2.w, r2.w, r3.w, r4.x
    mul r4.xyz, r3, r1.w
    mul r4.xyz, r2.w, r4
    mad r1.xyz, r1, v5.x, r4
    add r4, c19, -v6.x
    add r5, c20, -v6.y
    add r6, c21, -v6.z
    mul r7, r4, r4
    mad r7, r5, r5, r7
    mad r7, r6, r6, r7
    add r8, r7, c0.z
    rsq r9.x, r8.x
    rsq r9.y, r8.y
    rsq r9.z, r8.z
    rsq r9.w, r8.w
    mov r8.x, c0.x
    mad r7, r7, -c25, r8.x
    max r10, r7, c1.w
    mul r7, r10, r10
    mad r7, r7, r7, c4.z
    mul r10, r7, c4.w
    cmp r7, r7, r10, c1.w
    mul r10, r2.x, r4
    mad r10, r5, r2.y, r10
    mad r10, r6, r2.z, r10
    mul r7, r7, r10
    mul_sat r7, r9, r7
    mul r10, r4, -c22
    mad r10, r5, -c23, r10
    mad r10, r6, -c24, r10
    mul r10, r9, r10
    mov r11, c26
    mad_sat r10, r10, r11, c27
    mul r7, r7, r10
    dp4 r10.x, c29, r7
    dp4 r10.y, c30, r7
    dp4 r10.z, c31, r7
    add r1.xyz, r1, r10
    add r10, c32, -v6.x
    add r11, c33, -v6.y
    add r12, c34, -v6.z
    mul r13, r10, r10
    mad r13, r11, r11, r13
    mad r13, r12, r12, r13
    add r14, r13, c0.z
    rsq r15.x, r14.x
    rsq r15.y, r14.y
    rsq r15.z, r14.z
    rsq r15.w, r14.w
    mad r8, r13, -c36, r8.x
    max r13, r8, c1.w
    mul r8, r13, r13
    mad r8, r8, r8, c4.z
    mul r13, r8, c4.w
    cmp r8, r8, r13, c1.w
    mul r13, r2.x, r10
    mad r13, r11, r2.y, r13
    mad r13, r12, r2.z, r13
    mul r8, r8, r13
    mul_sat r8, r15, r8
    mul r13, r10, -c67
    mad r13, r11, -c68, r13
    mad r13, r12, -c69, r13
    mul r13, r15, r13
    mov r14, c70
    mad_sat r13, r13, r14, c71
    mul r8, r8, r13
    dp4 r13.x, c35, r8
    dp4 r13.y, c64, r8
    dp4 r13.z, c65, r8
    add r1.xyz, r1, r13
    mov r1.w, c0.x
    mul r0, r0, r1
    mul r0.w, r0.w, c39.x
    /* removed stipple
    mov_sat r1.x, r0.w
    mul r1.x, r1.x, c2.x
    frc r1.y, r1.x
    mul r1.z, r1.y, c2.y
    frc r1.w, r1.z
    add r13.xy, r1.zxzw, -r1.wyzw
    mul r1.xy, c2.z, vPos
    frc r1.xy, r1_abs
    cmp r1.xy, vPos, r1, -r1
    mul r1.xy, r1, -c1.x
    mad r1.xy, r13, -c1.x, r1
    mov r1.zw, c1.w
    texldl r1, r1, s10
    cmp r1, -r1.y, -c1.z, -c1.w
    texkill r1
    removed stipple */
    add r1.xyz, c0.z, v2
    nrm r13.xyz, r1
    dp3 r1.x, -r13, r2
    add r1.x, r1.x, r1.x
    mad r1.xyz, r2, -r1.x, -r13
    dp3_sat r1.w, -c17, r1
    add r1.w, r1.w, c2.w
    mov r3.w, c2.w
    add r2.x, r3.w, c66.x
    pow r3.w, r1.w, r2.x
    mul r2.xyz, r3, r3.w
    mul r2.xyz, r2.w, r2
    mov r3.x, c1.x
    mul r1.w, -r3.x, c66.x
    mul r3, r4, r1.x
    mad r3, r1.y, r5, r3
    mad r3, r1.z, r6, r3
    mul r3, r9, r3
    log r4.x, r3_abs.x
    log r4.y, r3_abs.y
    log r4.z, r3_abs.z
    log r4.w, r3_abs.w
    mul r3, r1.w, r4
    exp r4.x, r3.x
    exp r4.y, r3.y
    exp r4.z, r3.z
    exp r4.w, r3.w
    mul r3, r7, r4
    dp4 r4.x, c29, r3
    dp4 r4.y, c30, r3
    dp4 r4.z, c31, r3
    mad r2.xyz, r2, c17.w, r4
    mul r3, r10, r1.x
    mad r3, r1.y, r11, r3
    mad r3, r1.z, r12, r3
    mul r3, r15, r3
    log r4.x, r3_abs.x
    log r4.y, r3_abs.y
    log r4.z, r3_abs.z
    log r4.w, r3_abs.w
    mul r1, r1.w, r4
    exp r3.x, r1.x
    exp r3.y, r1.y
    exp r3.z, r1.z
    exp r3.w, r1.w
    mul r1, r8, r3
    dp4 r3.x, c35, r1
    dp4 r3.y, c64, r1
    dp4 r3.z, c65, r1
    add r1.xyz, r2, r3
    mad oC0.xyz, c72.x, r1, r0
    mov oC0.w, r0.w
	// ----------------------------------------------------------------- Linear2Log -----------------------------------------------------------------
	if_ne v9.y, c127.y
		rcp r20.z, c128.x
		mul r20.x, v9.w, r20.z
		mul r20.y, c128.y, r20.z
		log r20.x, r20.x
		log r20.y, r20.y
		rcp r20.y, r20.y
	else
		mov r20.x, v9.z
		rcp r20.y, v9.w
	endif
	mul oDepth, r20.x, r20.y
	// ----------------------------------------------------------------------------------------------------------------------------------------------

// approximately 257 instruction slots used (16 texture, 241 arithmetic)
