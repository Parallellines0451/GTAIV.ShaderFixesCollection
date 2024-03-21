// Summary: removed unnecessary stipple + console-like ambient reflection intensity + improved shadow filter + added PCSS thanks to robi29 + improved shadow fadeout
// Generated by Microsoft (R) HLSL Shader Compiler 9.26.952.2844
//
// Parameters:
//
//   sampler2D BumpSampler;
//   samplerCUBE EnvironmentSampler;
//   sampler2D StippleTexture;
//   sampler2D TextureSampler;
//   float bumpiness;
//   float4 gDepthFxParams;
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
//   float4 globalFogColor;
//   float4 globalFogColorN;
//   float4 globalFogParams;
//   float4 globalScalars;
//   float reflectivePower;
//
//
// Registers:
//
//   Name                 Reg   Size
//   -------------------- ----- ----
//   gViewInverse         c12      4
//   gDepthFxParams       c16      1
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
//   globalFogParams      c41      1
//   globalFogColor       c42      1
//   globalFogColorN      c43      1
//   gShadowParam18192021 c53      1
//   gFacetCentre         c54      1
//   gShadowParam14151617 c56      1
//   gShadowParam0123     c57      1
//   gShadowParam4567     c58      1
//   gShadowParam891113   c59      1
//   gShadowMatrix        c60      4
//   gLightPointColG      c64      1
//   gLightPointColB      c65      1
//   bumpiness            c66      1
//   gLightDir2X          c67      1
//   gLightDir2Y          c68      1
//   gLightDir2Z          c69      1
//   gLightConeScale2     c70      1
//   gLightConeOffset2    c71      1
//   reflectivePower      c72      1
//   TextureSampler       s0       1
//   BumpSampler          s1       1
//   EnvironmentSampler   s2       1
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
    def c219, 1.8395173895e+25, 3.9938258725e+24, 4.5435787456e+30, 4.0637655465e-43 // 290
    def c127, 0.9999999, 1, 0, 0	// LogDepth constants
    def c0, -0.5, 9.99999975e-006, -0.00999999978, 100
    def c1, -0.5, 0.5, 1.33333337, 1.5
    def c2, 0.0833333358, -0.100000001, 1.11111116, 1.00000001e-007
    def c3, 3.99600005, 4, 0.125, 0.25
    def c4, 0.212500006, 0.715399981, 0.0720999986, 0
    def c5, 0, -1, -0, 1
    def c6, -0.321940005, -0.932614982, -0.791558981, -0.597710013
    def c7, 0.507430971, 0.0644249991, 0.896420002, 0.412458003
    def c8, 0.519456029, 0.767022014, 0.185461, -0.893123984
    def c9, 0.962339997, -0.194983006, 0.473434001, -0.480026007
    def c10, -0.69591397, 0.457136989, -0.203345001, 0.620715976
    def c11, -0.326211989, -0.405809999, -0.840143979, -0.0735799968
	def c100, 1.6666667, 0, 0, 0	// Reflection intensity multiplier
    dcl_texcoord v0.xy
    dcl_texcoord1 v1
    dcl_texcoord3 v2.xyz
    dcl_texcoord4 v3.xyz
    dcl_texcoord5 v4.xyz
    dcl_color v5.xw
    dcl_texcoord6 v6.xyz
    dcl vPos.xy
    dcl_texcoord9 v9
    dcl_2d s0
    dcl_2d s1
    dcl_cube s2
    dcl_2d s10
    dcl_2d s15
    /* removed stipple
    mov_sat r0.x, c39.x
    mul r0.x, r0.x, c3.x
    frc r0.y, r0.x
    mul r0.z, r0.y, c3.y
    frc r0.w, r0.z
    add r1.xy, r0.zxzw, -r0.wyzw
    mul r0.xy, c3.z, vPos
    frc r0.xy, r0_abs
    cmp r0.xy, vPos, r0, -r0
    mul r0.xy, r0, c3.w
    mad r0.xy, r1, c3.w, r0
    mov r0.zw, c5.x
    texldl r0, r0, s10
    cmp r0, -r0.y, c5.y, c5.z
    texkill r0
    removed stipple */
    texld r0, v0, s1
    add r0.z, -r0.w, c5.w
    add r0.z, -r0.x, r0.z
    cmp r0.xy, r0.z, r0.wyzw, r0
    texld r1, v0, s0
    add r0.zw, r0.xyxy, c0.x
    mul r0.zw, r0, c66.x
    dp2add r0.x, r0, -r0, c5.w
    rsq r0.x, r0.x
    rcp r0.x, r0.x
    mul r2.xyz, r0.z, v3
    mad r0.xyz, v1, r0.x, r2
    mad r0.xyz, r0.w, v4, r0
    add r0.xyz, r0, c0.y
    nrm r2.xyz, r0
    add r0.xyz, c0.y, v2.xzyw
    dp3 r0.w, r0, r0
    rsq r0.w, r0.w
    mul r0.xyz, r0, r0.w
    dp3 r0.w, -r0.xzyw, r2
    add r0.w, r0.w, r0.w
    mad r0.xyz, r2.xzyw, -r0.w, -r0
    add r0.xyz, r0, c0.y
    dp3 r0.w, r0, r0
    rsq r0.w, r0.w
    mul r0.xyz, r0, r0.w
    texld r0, r0, s2
	mul r0, r0, c100.x
    mul r0.xyz, r0, c72.x
    mul r3.w, r1.w, v5.w
    mad r0.w, r1.w, v5.w, c0.z
    rcp r1.w, r3.w
    cmp r0.w, r0.w, r1.w, c0.w
    mad r3.xyz, r0, r0.w, r1
    mad_sat r0.x, r2.z, c1.x, c1.y
    mov r1.xyz, c38
    mad r0.xyz, r1, r0.x, c37
    mul r1.xyz, c18.w, c18
    dp3 r0.w, r2, -c17
    add r0.w, r0.w, -c3.w
    mul_sat r0.w, r0.w, c1.z
    mul r4.xyz, c61.xyww, v6.y
    mad r4.xyz, v6.x, c60.xyww, r4
    mad r4.xyz, v6.z, c62.xyww, r4
    add r4.xyz, r4, c63.xyww
    dp3 r1.w, c14, v6
    add r5.xyz, -r1.w, -c54
    cmp r5.yzw, r5.xxyz, c5.w, c5.x
	// ---------------------------------------------------------------- Cascade Mask ----------------------------------------------------------------
	mov r21.x, c110.y
	mov r21.yzw, r5
	add r21.xyz, r21.xyz, -r21.yzw
	// ----------------------------------------------------------------------------------------------------------------------------------------------
    mov r5.x, c5.w
    dp4 r6.x, r5, c57
    dp4 r6.y, r5, c58
    dp4 r7.x, r5, c59
    dp4 r7.y, r5, c56
    mad r4.xy, r4, r6, r7
    add r5.xyz, c15, -v6
    dp3 r1.w, r5, r5
    rsq r1.w, r1.w
    rcp r1.w, r1.w
    rcp r2.w, c53.w
    mul r2.w, r1.w, r2.w
    mul r2.w, r2.w, r2.w // improved shadow fadeout
    mul r2.w, r2.w, r2.w
    mul r2.w, r2.w, c1.w
    /* removed 1.0.6.0 filter
    mov r5.y, c53.y
    mad r5.xz, r5.y, c11.xyyw, r4.xyyw
    texld r6, r5.xzzw, s15
    add r4.w, r4.z, -r6.x
    cmp r4.w, r4.w, c5.w, c5.x
    mad r5.xz, r5.y, c11.zyww, r4.xyyw
    texld r6, r5.xzzw, s15
    add r5.x, r4.z, -r6.x
    cmp r5.x, r5.x, c5.w, c5.x
    add r4.w, r4.w, r5.x
    mad r5.xz, r5.y, c10.xyyw, r4.xyyw
    texld r6, r5.xzzw, s15
    add r5.x, r4.z, -r6.x
    cmp r5.x, r5.x, c5.w, c5.x
    add r4.w, r4.w, r5.x
    mad r5.xz, r5.y, c10.zyww, r4.xyyw
    texld r6, r5.xzzw, s15
    add r5.x, r4.z, -r6.x
    cmp r5.x, r5.x, c5.w, c5.x
    add r4.w, r4.w, r5.x
    mad r5.xz, r5.y, c9.xyyw, r4.xyyw
    texld r6, r5.xzzw, s15
    add r5.x, r4.z, -r6.x
    cmp r5.x, r5.x, c5.w, c5.x
    add r4.w, r4.w, r5.x
    mad r5.xz, r5.y, c9.zyww, r4.xyyw
    texld r6, r5.xzzw, s15
    add r5.x, r4.z, -r6.x
    cmp r5.x, r5.x, c5.w, c5.x
    add r4.w, r4.w, r5.x
    mad r5.xz, r5.y, c8.xyyw, r4.xyyw
    texld r6, r5.xzzw, s15
    add r5.x, r4.z, -r6.x
    cmp r5.x, r5.x, c5.w, c5.x
    add r4.w, r4.w, r5.x
    mad r5.xz, r5.y, c8.zyww, r4.xyyw
    texld r6, r5.xzzw, s15
    add r5.x, r4.z, -r6.x
    cmp r5.x, r5.x, c5.w, c5.x
    add r4.w, r4.w, r5.x
    mad r5.xz, r5.y, c7.xyyw, r4.xyyw
    texld r6, r5.xzzw, s15
    add r5.x, r4.z, -r6.x
    cmp r5.x, r5.x, c5.w, c5.x
    add r4.w, r4.w, r5.x
    mad r5.xz, r5.y, c7.zyww, r4.xyyw
    texld r6, r5.xzzw, s15
    add r5.x, r4.z, -r6.x
    cmp r5.x, r5.x, c5.w, c5.x
    add r4.w, r4.w, r5.x
    mad r5.xz, r5.y, c6.xyyw, r4.xyyw
    texld r6, r5.xzzw, s15
    add r5.x, r4.z, -r6.x
    cmp r5.x, r5.x, c5.w, c5.x
    add r4.w, r4.w, r5.x
    mad r4.xy, r5.y, c6.zwzw, r4
    texld r5, r4, s15
    add r4.x, r4.z, -r5.x
    cmp r4.x, r4.x, c5.w, c5.x
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
	add r22.x, r1.w, -r22.x
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
    add r2.w, r4.x, r2.w // mad r2.w, r4.x, c2.x, r2.w 1.0.6.0 filter average
    add r1.w, r1.w, -c53.w
    cmp r4.xy, r1.w, c5.wyzw, c5.xzzw
    add r1.w, r2.w, r4.y
    cmp_sat r1.w, r1.w, r2.w, r4.x
    mul r1.xyz, r1, r0.w
    mul r1.xyz, r1.w, r1
    mad r0.xyz, r0, v5.x, r1
    add r1, c19, -v6.x
    add r4, c20, -v6.y
    add r5, c21, -v6.z
    mul r6, r1, r1
    mad r6, r4, r4, r6
    mad r6, r5, r5, r6
    add r7, r6, c0.y
    rsq r8.x, r7.x
    rsq r8.y, r7.y
    rsq r8.z, r7.z
    rsq r8.w, r7.w
    mov r7.yw, c5
    mad r6, r6, -c25, r7.w
    max r9, r6, c5.x
    mul r6, r9, r9
    mad r6, r6, r6, c2.y
    mul r9, r6, c2.z
    cmp r6, r6, r9, c5.x
    mul r9, r2.x, r1
    mad r9, r4, r2.y, r9
    mad r9, r5, r2.z, r9
    mul r6, r6, r9
    mul_sat r6, r8, r6
    mul r1, r1, -c22
    mad r1, r4, -c23, r1
    mad r1, r5, -c24, r1
    mul r1, r8, r1
    mov r4, c26
    mad_sat r1, r1, r4, c27
    mul r1, r6, r1
    dp4 r4.x, c29, r1
    dp4 r4.y, c30, r1
    dp4 r4.z, c31, r1
    add r0.xyz, r0, r4
    add r1, c32, -v6.x
    add r4, c33, -v6.y
    add r5, c34, -v6.z
    mul r6, r1, r1
    mad r6, r4, r4, r6
    mad r6, r5, r5, r6
    add r8, r6, c0.y
    rsq r9.x, r8.x
    rsq r9.y, r8.y
    rsq r9.z, r8.z
    rsq r9.w, r8.w
    mad r6, r6, -c36, r7.w
    max r8, r6, c5.x
    mul r6, r8, r8
    mad r6, r6, r6, c2.y
    mul r8, r6, c2.z
    cmp r6, r6, r8, c5.x
    mul r8, r2.x, r1
    mad r8, r4, r2.y, r8
    mad r2, r5, r2.z, r8
    mul r2, r6, r2
    mul_sat r2, r9, r2
    mul r1, r1, -c67
    mad r1, r4, -c68, r1
    mad r1, r5, -c69, r1
    mul r1, r9, r1
    mov r4, c70
    mad_sat r1, r1, r4, c71
    mul r1, r2, r1
    dp4 r2.x, c35, r1
    dp4 r2.y, c64, r1
    dp4 r2.z, c65, r1
    add r0.xyz, r0, r2
    mov r0.w, c5.w
    mul r1, r3, r0
    mul oC0.w, r1.w, c39.x
    add r0.w, c16.w, -v1.w
    add r1.w, -c16.z, c16.w
    rcp r1.w, r1.w
    mul_sat r0.w, r0.w, r1.w
    add r0.w, -r0.w, c5.w
    add r2.xy, r7.y, c16
    mul r1.w, r0.w, r2.y
    mad r0.w, r0.w, r2.x, c5.w
    dp3 r1.x, r1, c4
    mad r0.xyz, r3, r0, -r1.x
    mad r0.xyz, r0.w, r0, r1.x
    add r0.w, r1.x, c2.w
    pow r2.x, r0_abs.w, r1.w
    mul r1.xyz, r0, r2.x
    rcp r0.w, c41.x
    mul_sat r0.w, r0.w, v1.w
    add r1.w, -c41.x, v1.w
    add r2.y, -c41.x, c41.y
    rcp r2.y, r2.y
    mul_sat r1.w, r1.w, r2.y
    lrp r2.y, c41.w, r0.w, r1.w
    add r0.w, r2.y, c41.z
    mov r3.xyz, c43
    add r2.yzw, -r3.xxyz, c42.xxyz
    mad r2.yzw, r1.w, r2, c43.xxyz
    mad r0.xyz, r0, -r2.x, r2.yzww
    mad oC0.xyz, r0.w, r0, r1
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

// approximately 247 instruction slots used (17 texture, 230 arithmetic)
