// Summary: Disabled PC parameters that cause the dirt level in vehicle.ide to affect reflection intensity + improved shadow filter + added PCSS thanks to robi29 + improved shadow fadeout
// Generated by Microsoft (R) HLSL Shader Compiler 9.26.952.2844
//
// Parameters:
//
//   sampler2D BumpSampler;
//   sampler2D DirtSampler;
//   float3 LuminanceConstants;
//   sampler2D SpecSampler;
//   sampler2D TextureSampler;
//   float3 dirtColor;
//   float dirtLevel;
//   float4 gDepthFxParams;
//   float4 gDirectionalColour;
//   float4 gDirectionalLight;
//   float4 gFacetCentre;
//   float4 gLightAmbient0;
//   float4 gLightAmbient1;
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
//   float3 matDiffuseColor;
//   float reflectivePowerED;
//   float3 specMapIntMask;
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
//   matDiffuseColor      c66      1
//   dirtLevel            c72      1
//   dirtColor            c73      1
//   specMapIntMask       c74      1
//   reflectivePowerED    c75      1
//   LuminanceConstants   c76      1
//   TextureSampler       s0       1
//   DirtSampler          s1       1
//   BumpSampler          s2       1
//   SpecSampler          s4       1
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
    def c219, 1.8395173895e+25, 3.9938258725e+24, 4.5435787456e+30, 1.0355595651e-42 // 739
    def c127, 0.9999999, 1, 0, 0	// LogDepth constants
    def c0, 1, -0.5, 3, 9.99999975e-006
    def c1, 50, 9.99999975e-005, 1.5, 0.0833333358
    def c2, 1.39999998, 0, 1, -0.25
    def c3, -0.5, 0.5, 1.33333337, 9.99999975e-005
    def c4, 1, -1, 0, -0
    def c5, 0.212500006, 0.715399981, 0.0720999986, 1.00000001e-007
    def c6, -0.321940005, -0.932614982, -0.791558981, -0.597710013
    def c7, 0.507430971, 0.0644249991, 0.896420002, 0.412458003
    def c8, 0.519456029, 0.767022014, 0.185461, -0.893123984
    def c9, 0.962339997, -0.194983006, 0.473434001, -0.480026007
    def c10, -0.69591397, 0.457136989, -0.203345001, 0.620715976
    def c11, -0.326211989, -0.405809999, -0.840143979, -0.0735799968
    def c75, 1, 1, 1, 1 // disable IDE dirt influence
    dcl vPos.xy
    dcl_texcoord v0.xy
    dcl_texcoord1 v1
    dcl_texcoord3 v2.xyz
    dcl_texcoord4 v3.xyz
    dcl_texcoord5 v4.xyz
    dcl_color v5
    dcl_texcoord2 v6.xyz
    dcl_texcoord9 v9
    dcl_2d s0
    dcl_2d s1
    dcl_2d s2
    dcl_2d s4
    dcl_2d s15
    texld r0, v0, s2
    add r0.z, -r0.w, c0.x
    add r0.z, -r0.x, r0.z
    cmp r0.xy, r0.z, r0.wyzw, r0
    texld r1, v0, s0
    add r0.zw, r0.xyxy, c0.y
    mul r0.zw, r0, c0.z
    dp2add r0.x, r0, -r0, c0.x
    rsq r0.x, r0.x
    rcp r0.x, r0.x
    mul r2.xyz, r0.z, v3
    mad r0.xyz, v1, r0.x, r2
    mad r0.xyz, r0.w, v4, r0
    add r0.xyz, r0, c0.w
    nrm r2.xyz, r0
    texld r0, v0, s4
    mul r0.w, r0.w, c75.x
    dp3 r0.x, r0, c74
    mul r0.x, r0.x, c75.x
    mul r0.x, r0.x, c2.x
    mul r1.xyz, r1, c66
    mul r1, r1, v5
    dp3 r0.y, v5, c76
    mul r0.y, r0.y, c39.z
    mov r3.y, c2.y
    if_lt -c72.x, r3.y
      texld r3, v0, s1
      mul r0.z, r3.x, c72.x
      mov r4.x, c0.x
      mad r4.x, r3.x, -c72.x, r4.x
      lrp r4.yzw, r0.z, c73.xxyz, r1.xxyz
      mad r5, r1.xxyz, c2.yzzz, c2.zyyy
      cmp r3, -r3.x, r5, r4
      mov r1.xyz, r3.yzww
    else
      mov r3.x, c0.x
    endif
    mul r0.x, r0.x, r3.x
    add r3.xyz, c0.w, v2
    nrm r4.xyz, r3
    mad_sat r0.z, r2.z, c3.x, c3.y
    mov r3.xyz, c38
    mad r3.xyz, r3, r0.z, c37
    dp3 r0.z, -r4, r2
    add r0.z, r0.z, r0.z
    mad r5.xyz, r2, -r0.z, -r4
    mul r6.xyz, c18.w, c18
    dp3 r0.z, r2, -c17
    add r0.z, r0.z, c2.w
    mul_sat r0.z, r0.z, c3.z
    dp3_sat r2.w, -c17, r5
    add r2.w, r2.w, c3.w
    mad r0.w, r0.w, c1.x, c1.y
    pow r3.w, r2.w, r0.w
    mul r5.xyz, c61.xyww, v6.y
    mad r5.xyz, v6.x, c60.xyww, r5
    mad r5.xyz, v6.z, c62.xyww, r5
    add r5.xyz, r5, c63.xyww
    dp3 r0.w, c14, v6
    add r7.xyz, -r0.w, -c54
    cmp r7.yzw, r7.xxyz, c2.z, c2.y
	// ---------------------------------------------------------------- Cascade Mask ----------------------------------------------------------------
	mov r21.x, c110.y
	mov r21.yzw, r7
	add r21.xyz, r21.xyz, -r21.yzw
	// ----------------------------------------------------------------------------------------------------------------------------------------------
    mov r7.x, c0.x
    dp4 r8.x, r7, c57
    dp4 r8.y, r7, c58
    dp4 r9.x, r7, c59
    dp4 r9.y, r7, c56
    mad r5.xy, r5, r8, r9
    add r7.xyz, c15, -v6
    dp3 r0.w, r7, r7
    rsq r0.w, r0.w
    rcp r0.w, r0.w
    rcp r2.w, c53.w
    mul r2.w, r0.w, r2.w
    mul r2.w, r2.w, r2.w // improved shadow fadeout
    mul r2.w, r2.w, r2.w
    mul r2.w, r2.w, c1.z
    /* removed 1.0.6.0 filter
    mov r7.y, c53.y
    mad r7.xz, r7.y, c11.xyyw, r5.xyyw
    texld r8, r7.xzzw, s15
    add r4.w, r5.z, -r8.x
    cmp r4.w, r4.w, c2.z, c2.y
    mad r7.xz, r7.y, c11.zyww, r5.xyyw
    texld r8, r7.xzzw, s15
    add r5.w, r5.z, -r8.x
    cmp r5.w, r5.w, c2.z, c2.y
    add r4.w, r4.w, r5.w
    mad r7.xz, r7.y, c10.xyyw, r5.xyyw
    texld r8, r7.xzzw, s15
    add r5.w, r5.z, -r8.x
    cmp r5.w, r5.w, c2.z, c2.y
    add r4.w, r4.w, r5.w
    mad r7.xz, r7.y, c10.zyww, r5.xyyw
    texld r8, r7.xzzw, s15
    add r5.w, r5.z, -r8.x
    cmp r5.w, r5.w, c2.z, c2.y
    add r4.w, r4.w, r5.w
    mad r7.xz, r7.y, c9.xyyw, r5.xyyw
    texld r8, r7.xzzw, s15
    add r5.w, r5.z, -r8.x
    cmp r5.w, r5.w, c2.z, c2.y
    add r4.w, r4.w, r5.w
    mad r7.xz, r7.y, c9.zyww, r5.xyyw
    texld r8, r7.xzzw, s15
    add r5.w, r5.z, -r8.x
    cmp r5.w, r5.w, c2.z, c2.y
    add r4.w, r4.w, r5.w
    mad r7.xz, r7.y, c8.xyyw, r5.xyyw
    texld r8, r7.xzzw, s15
    add r5.w, r5.z, -r8.x
    cmp r5.w, r5.w, c2.z, c2.y
    add r4.w, r4.w, r5.w
    mad r7.xz, r7.y, c8.zyww, r5.xyyw
    texld r8, r7.xzzw, s15
    add r5.w, r5.z, -r8.x
    cmp r5.w, r5.w, c2.z, c2.y
    add r4.w, r4.w, r5.w
    mad r7.xz, r7.y, c7.xyyw, r5.xyyw
    texld r8, r7.xzzw, s15
    add r5.w, r5.z, -r8.x
    cmp r5.w, r5.w, c2.z, c2.y
    add r4.w, r4.w, r5.w
    mad r7.xz, r7.y, c7.zyww, r5.xyyw
    texld r8, r7.xzzw, s15
    add r5.w, r5.z, -r8.x
    cmp r5.w, r5.w, c2.z, c2.y
    add r4.w, r4.w, r5.w
    mad r7.xz, r7.y, c6.xyyw, r5.xyyw
    texld r8, r7.xzzw, s15
    add r5.w, r5.z, -r8.x
    cmp r5.w, r5.w, c2.z, c2.y
    add r4.w, r4.w, r5.w
    mad r5.xy, r7.y, c6.zwzw, r5
    texld r7, r5, s15
    add r5.x, r5.z, -r7.x
    cmp r5.x, r5.x, c2.z, c2.y
    add r4.w, r4.w, r5.x
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
	add r5.z, r5.z, -r20.w // apply per cascade bias
	if_ne r24.z, c223.y // PCSS
		mov r24.xyw, c110.w // sum
		mul r25.xy, r20.z, c124.xy // pcss texel step
		mov r25.zw, r25.x // x - inner loop index, y - outer loop index
		rep i1
			mul r24.z, r25.w, c124.z
			rep i1
				mad r26.xy, c53.xy, r25.zw, r5.xy
				texldl r27, r26.xy, s15
				add r26.x, r27.x, -r5.z
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
	add r22.x, r0.w, -r22.x
	add r22.y, c54.z, -c54.x
	rcp r22.y, r22.y
	mul_sat r22.x, r22.x, r22.y
	mul r22.x, r22.x, r22.x
	mul r22.y, r23.x, c53.w
	mov r22.z, c123.x
	lrp r23.xy, r22.x, r22.yz, r24.xy
	mul r20.xy, r20.xy, r23.x // apply depth based blur
	add r5.z, r5.z, r23.y // apply depth based bias
	
    mov r21.xy, c112.xy
    dp2add r21.y, vPos, r21, c110.w		// v0.x * r21.x + v0.y * r21.y
    mad r21.y, r21.y, c111.x, c111.y
    frc r21.y, r21.y
    mad r21.y, r21.y, c111.z, c111.w	// r21.y * 2pi - pi
    sincos r22.xy, r21.y				// cosine & sine of r21.y
    mul r23, r22.yxxy, c110.xxyz		// offsets for 1st and 4th samples, respectively
    mul r21, r22.yxxy, c113.xxyz        // offsets for 3rd and 2nd samples, respectively
	mul r20.xy, r20.xy, c221.w			// compensate for FixCascadedShadowMapResolution
	
    mad r24.xy, r23.xy, r20.xy, r5.xy	// offset * texel size + UV
    texld r24, r24, s15					// 1st sample
    mov r25.x, r24.x					// copy to r25
    mad r24.xy, r21.zw, r20.xy, r5.xy	// offset * texel size + UV
    texld r24, r24, s15					// 2nd sample
    mov r25.y, r24.x					// copy to r25
    mad r24.xy, r21.xy, r20.xy, r5.xy	// offset * texel size + UV
    texld r24, r24, s15					// 3rd sample
    mov r25.z, r24.x					// copy to r25
    mad r24.xy, r23.zw, r20.xy, r5.xy	// offset * texel size + UV
    texld r24, r24, s15					// 4th sample
    mov r25.w, r24.x					// copy to r25
	add r25, r5.z, -r25					// depth bias
	cmp r25, r25, c110.y, c110.w
	dp4 r26.x, r25, -c110.x				// average
	
    mul r23, r22.yxxy, c114.xxyz		// offsets for 5th and 8th samples, respectively
    mul r21, r22.yxxy, c115.xxyz        // offsets for 7th and 6th samples, respectively
	
    mad r24.xy, r23.xy, r20.xy, r5.xy	// offset * texel size + UV
    texld r24, r24, s15					// 5th sample
    mov r25.x, r24.x					// copy to r25
    mad r24.xy, r21.zw, r20.xy, r5.xy	// offset * texel size + UV
    texld r24, r24, s15					// 6th sample
    mov r25.y, r24.x					// copy to r25
    mad r24.xy, r21.xy, r20.xy, r5.xy	// offset * texel size + UV
    texld r24, r24, s15					// 7th sample
    mov r25.z, r24.x					// copy to r25
    mad r24.xy, r23.zw, r20.xy, r5.xy	// offset * texel size + UV
    texld r24, r24, s15					// 8th sample
    mov r25.w, r24.x					// copy to r25
	add r25, r5.z, -r25					// depth bias
	cmp r25, r25, c110.y, c110.w
	dp4 r26.y, r25, -c110.x				// average
	
    mul r23, r22.yxxy, c116.xxyz		// offsets for 9th and 12th samples, respectively
    mul r21, r22.yxxy, c117.xxyz        // offsets for 11th and 10th samples, respectively
	
    mad r24.xy, r23.xy, r20.xy, r5.xy	// offset * texel size + UV
    texld r24, r24, s15					// 9th sample
    mov r25.x, r24.x					// copy to r25
    mad r24.xy, r21.zw, r20.xy, r5.xy	// offset * texel size + UV
    texld r24, r24, s15					// 10th sample
    mov r25.y, r24.x					// copy to r25
    mad r24.xy, r21.xy, r20.xy, r5.xy	// offset * texel size + UV
    texld r24, r24, s15					// 11th sample
    mov r25.z, r24.x					// copy to r25
    mad r24.xy, r23.zw, r20.xy, r5.xy	// offset * texel size + UV
    texld r24, r24, s15					// 12th sample
    mov r25.w, r24.x					// copy to r25
	add r25, r5.z, -r25					// depth bias
	cmp r25, r25, c110.y, c110.w
	dp4 r26.z, r25, -c110.x				// average
	
	dp3 r4.w, r26, c112.w
	// ----------------------------------------------------------------------------------------------------------------------------------------------
    add r2.w, r4.w, r2.w // mad r2.w, r4.w, c1.w, r2.w 1.0.6.0 filter average
    add r0.w, r0.w, -c53.w
    cmp r5.xy, r0.w, c4, c4.zwzw
    add r0.w, r2.w, r5.y
    cmp_sat r0.w, r0.w, r2.w, r5.x
    mul r5.xyz, r6, r3.w
    mul r5.xyz, r0.w, r5
    mul r6.xyz, r6, r0.z
    mul r6.xyz, r0.w, r6
    mul r5.xyz, r5, c17.w
    mad r3.xyz, r3, r0.y, r6
    dp3 r0.y, r4, r2
    add r0.y, -r0_abs.y, c0.x
    mul r0.y, r0.y, r0.y
    mul r0.y, r0.y, r0.y
    mad_sat r0.y, r0.y, -c0.y, -c0.y
    mul r0.x, r0.x, r0.y
    mov r3.w, c0.x
    mul r1, r1, r3
    mad r0.xyz, r0.x, r5, r1
    mul oC0.w, r1.w, c39.x
    add r0.w, c16.w, -v1.w
    add r1.x, -c16.z, c16.w
    rcp r1.x, r1.x
    mul_sat r0.w, r0.w, r1.x
    add r0.w, -r0.w, c0.x
    mov r1.x, c0.x
    add r1.xy, -r1.x, c16
    mul r1.y, r0.w, r1.y
    mad r0.w, r0.w, r1.x, c0.x
    dp3 r1.x, r0, c5
    lrp r2.xyz, r0.w, r0, r1.x
    add r0.x, r1.x, c5.w
    pow r2.w, r0_abs.x, r1.y
    mul r0.xyz, r2, r2.w
    rcp r0.w, c41.x
    mul_sat r0.w, r0.w, v1.w
    add r1.x, -c41.x, v1.w
    add r1.y, -c41.x, c41.y
    rcp r1.y, r1.y
    mul_sat r1.x, r1.x, r1.y
    lrp r3.x, c41.w, r0.w, r1.x
    add r0.w, r3.x, c41.z
    mov r3.xyz, c43
    add r1.yzw, -r3.xxyz, c42.xxyz
    mad r1.xyz, r1.x, r1.yzww, c43
    mad r1.xyz, r2, -r2.w, r1
    mad oC0.xyz, r0.w, r1, r0
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

// approximately 194 instruction slots used (16 texture, 178 arithmetic)
