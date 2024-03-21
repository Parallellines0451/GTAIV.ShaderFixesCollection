// Summary: removed unnecessary stipple + improved shadow filter + added PCSS thanks to robi29 + improved shadow fadeout
// Generated by Microsoft (R) HLSL Shader Compiler 9.26.952.2844
//
// Parameters:
//
//   sampler2D BumpSampler;
//   sampler2D SpecSampler;
//   sampler2D StippleTexture;
//   sampler2D TextureSampler;
//   float bumpiness;
//   sampler2D damageSpecTextureSampler;
//   sampler2D damageTextureSampler;
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
//   float4 matMaterialColorScale;
//   float3 specMapIntMask;
//   float specularColorFactor;
//   float specularFactor;
//
//
// Registers:
//
//   Name                     Reg   Size
//   ------------------------ ----- ----
//   gViewInverse             c12      4
//   gDepthFxParams           c16      1
//   gDirectionalLight        c17      1
//   gDirectionalColour       c18      1
//   gLightAmbient0           c37      1
//   gLightAmbient1           c38      1
//   globalScalars            c39      1
//   globalFogParams          c41      1
//   globalFogColor           c42      1
//   globalFogColorN          c43      1
//   gShadowParam18192021     c53      1
//   gFacetCentre             c54      1
//   gShadowParam14151617     c56      1
//   gShadowParam0123         c57      1
//   gShadowParam4567         c58      1
//   gShadowParam891113       c59      1
//   gShadowMatrix            c60      4
//   matMaterialColorScale    c66      1
//   specularFactor           c72      1
//   specularColorFactor      c73      1
//   specMapIntMask           c74      1
//   bumpiness                c75      1
//   TextureSampler           s0       1
//   damageTextureSampler     s1       1
//   damageSpecTextureSampler s2       1
//   BumpSampler              s4       1
//   SpecSampler              s5       1
//   StippleTexture           s10      1
//   gShadowZSamplerDir       s15      1
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
    def c219, 1.8395173895e+25, 3.9938258725e+24, 4.5435787456e+30, 3.9096227155e-43 // 279
    def c127, 0.9999999, 1, 0, 0	// LogDepth constants
    def c0, 1, -0.5, 9.99999975e-006, 0
    def c1, 0.333333343, -0.5, 0.5, -0.25
    def c2, 1.33333337, 1.5, -0.326211989, -0.405809999
    def c3, 4, 0.125, 9.99999975e-005, 1.00000001e-007
    def c4, -0.791558981, -0.597710013, 0.0833333358, 3.99600005
    def c5, 0.212500006, 0.715399981, 0.0720999986, 0
    def c6, 1, -1, 0, -0
    def c7, 0.896420002, 0.412458003, -0.321940005, -0.932614982
    def c8, 0.185461, -0.893123984, 0.507430971, 0.0644249991
    def c9, 0.473434001, -0.480026007, 0.519456029, 0.767022014
    def c10, -0.203345001, 0.620715976, 0.962339997, -0.194983006
    def c11, -0.840143979, -0.0735799968, -0.69591397, 0.457136989
    dcl_texcoord v0.xy
    dcl_texcoord1 v1
    dcl_texcoord3 v2.xyz
    dcl_texcoord4 v3.xyz
    dcl_texcoord5 v4.xyz
    dcl_color v5.xw
    dcl_texcoord6 v6.x
    dcl_texcoord2 v7.xyz
    dcl vPos.xy
    dcl_texcoord9 v9
    dcl_2d s0
    dcl_2d s1
    dcl_2d s2
    dcl_2d s4
    dcl_2d s5
    dcl_2d s10
    dcl_2d s15
    texld r0, v0, s4
    add r0.z, -r0.w, c0.x
    add r0.z, -r0.x, r0.z
    cmp r0.xy, r0.z, r0.wyzw, r0
    texld r1, v0, s0
    add r0.zw, r0.xyxy, c0.y
    mul r0.zw, r0, c75.x
    dp2add r0.x, r0, -r0, c0.x
    rsq r0.x, r0.x
    rcp r0.x, r0.x
    mul r2.xyz, r0.z, v3
    mad r0.xyz, v1, r0.x, r2
    mad r0.xyz, r0.w, v4, r0
    add r0.xyz, r0, c0.z
    nrm r2.xyz, r0
    texld r0, v0, s5
    mul r0.w, r0.w, c72.x
    dp3 r0.x, r0, c74
    mul r0.x, r0.x, c73.x
    if_lt -v6.x, c0.w
      texld r3, v0, s1
      if_lt -r3.w, c0.w
        texld r4, v0, s2
        add r0.y, c0.x, -v6.x
        mul r0.z, r4.w, c72.x
        lrp r2.w, v6.x, r0.z, r0.w
        add r0.z, r4.y, r4.x
        add r0.z, r4.z, r0.z
        mul r0.z, r0.z, v6.x
        mul r0.z, r0.z, c73.x
        mul r0.z, r0.z, c1.x
        mad r0.x, r0.y, r0.x, r0.z
        mad r0.y, r3.w, -v6.x, c0.x
        mul r3.xyz, r3.w, r3
        mul r3.xyz, r3, v6.x
        mad r1.xyz, r1, r0.y, r3
        mov r0.w, r2.w
      endif
    endif
    mul r1.w, r1.w, v5.w
    mad_sat r0.y, r2.z, c1.y, c1.z
    mov r3.xyz, c38
    mad r3.xyz, r3, r0.y, c37
    mul r4.xyz, c18.w, c18
    dp3 r0.y, r2, -c17
    add r0.y, r0.y, c1.w
    mul_sat r0.y, r0.y, c2.x
    mul r5.xyz, c61.xyww, v7.y
    mad r5.xyz, v7.x, c60.xyww, r5
    mad r5.xyz, v7.z, c62.xyww, r5
    add r5.xyz, r5, c63.xyww
    dp3 r0.z, c14, v7
    add r6.xyz, -r0.z, -c54
    cmp r6.yzw, r6.xxyz, c0.x, c0.w
	// ---------------------------------------------------------------- Cascade Mask ----------------------------------------------------------------
	mov r21.x, c110.y
	mov r21.yzw, r6
	add r21.xyz, r21.xyz, -r21.yzw
	// ----------------------------------------------------------------------------------------------------------------------------------------------
    mov r6.x, c0.x
    dp4 r7.x, r6, c57
    dp4 r7.y, r6, c58
    dp4 r8.x, r6, c59
    dp4 r8.y, r6, c56
    mad r5.xy, r5, r7, r8
    add r6.xyz, c15, -v7
    dp3 r0.z, r6, r6
    rsq r0.z, r0.z
    rcp r0.z, r0.z
    rcp r2.w, c53.w
    mul r2.w, r0.z, r2.w
    mul r2.w, r2.w, r2.w // improved shadow fadeout
    mul r2.w, r2.w, r2.w
    mul r2.w, r2.w, c2.y
    /* removed 1.0.6.0 filter
    mov r6.y, c53.y
    mad r6.xz, r6.y, c2.zyww, r5.xyyw
    texld r7, r6.xzzw, s15
    add r3.w, r5.z, -r7.x
    cmp r3.w, r3.w, c0.x, c0.w
    mad r6.xz, r6.y, c11.xyyw, r5.xyyw
    texld r7, r6.xzzw, s15
    add r4.w, r5.z, -r7.x
    cmp r4.w, r4.w, c0.x, c0.w
    add r3.w, r3.w, r4.w
    mad r6.xz, r6.y, c11.zyww, r5.xyyw
    texld r7, r6.xzzw, s15
    add r4.w, r5.z, -r7.x
    cmp r4.w, r4.w, c0.x, c0.w
    add r3.w, r3.w, r4.w
    mad r6.xz, r6.y, c10.xyyw, r5.xyyw
    texld r7, r6.xzzw, s15
    add r4.w, r5.z, -r7.x
    cmp r4.w, r4.w, c0.x, c0.w
    add r3.w, r3.w, r4.w
    mad r6.xz, r6.y, c10.zyww, r5.xyyw
    texld r7, r6.xzzw, s15
    add r4.w, r5.z, -r7.x
    cmp r4.w, r4.w, c0.x, c0.w
    add r3.w, r3.w, r4.w
    mad r6.xz, r6.y, c9.xyyw, r5.xyyw
    texld r7, r6.xzzw, s15
    add r4.w, r5.z, -r7.x
    cmp r4.w, r4.w, c0.x, c0.w
    add r3.w, r3.w, r4.w
    mad r6.xz, r6.y, c9.zyww, r5.xyyw
    texld r7, r6.xzzw, s15
    add r4.w, r5.z, -r7.x
    cmp r4.w, r4.w, c0.x, c0.w
    add r3.w, r3.w, r4.w
    mad r6.xz, r6.y, c8.xyyw, r5.xyyw
    texld r7, r6.xzzw, s15
    add r4.w, r5.z, -r7.x
    cmp r4.w, r4.w, c0.x, c0.w
    add r3.w, r3.w, r4.w
    mad r6.xz, r6.y, c8.zyww, r5.xyyw
    texld r7, r6.xzzw, s15
    add r4.w, r5.z, -r7.x
    cmp r4.w, r4.w, c0.x, c0.w
    add r3.w, r3.w, r4.w
    mad r6.xz, r6.y, c7.xyyw, r5.xyyw
    texld r7, r6.xzzw, s15
    add r4.w, r5.z, -r7.x
    cmp r4.w, r4.w, c0.x, c0.w
    add r3.w, r3.w, r4.w
    mad r6.xz, r6.y, c7.zyww, r5.xyyw
    texld r7, r6.xzzw, s15
    add r4.w, r5.z, -r7.x
    cmp r4.w, r4.w, c0.x, c0.w
    add r3.w, r3.w, r4.w
    mad r5.xy, r6.y, c4, r5
    texld r6, r5, s15
    add r4.w, r5.z, -r6.x
    cmp r4.w, r4.w, c0.x, c0.w
    add r3.w, r3.w, r4.w
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
	add r22.x, r0.z, -r22.x
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
	mul r20.xy, r20.xy, c112.z			// blur factor
	
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
	
	dp3 r3.w, r26, c112.w
	// ----------------------------------------------------------------------------------------------------------------------------------------------
    add r2.w, r3.w, r2.w // mad r2.w, r3.w, c4.z, r2.w 1.0.6.0 filter average
    add r0.z, r0.z, -c53.w
    cmp r5.xy, r0.z, c6, c6.zwzw
    add r0.z, r2.w, r5.y
    cmp_sat r0.z, r0.z, r2.w, r5.x
    mul r5.xyz, r4, r0.y
    mul r5.xyz, r0.z, r5
    mad r3.xyz, r3, v5.x, r5
    mov r3.w, c0.x
    mul r1, r1, r3
    mul r0.y, r1.w, c39.x
    /* removed stipple
    mov_sat r1.w, r0.y
    mul r1.w, r1.w, c4.w
    frc r2.w, r1.w
    mul r3.x, r2.w, c3.x
    frc r3.y, r3.x
    add r3.x, r3.x, -r3.y
    add r3.y, r1.w, -r2.w
    mul r3.zw, c3.y, vPos.xyxy
    frc r3.zw, r3_abs
    cmp r3.zw, vPos.xyxy, r3, -r3
    mul r3.zw, r3, -c1.w
    mad r3.xy, r3, -c1.w, r3.zwzw
    mov r3.zw, c0.w
    texldl r3, r3, s10
    cmp r3, -r3.y, -c0.x, -c0.w
    texkill r3
    removed stipple */
    add r3.xyz, c0.z, v2
    nrm r5.xyz, r3
    dp3 r1.w, -r5, r2
    add r1.w, r1.w, r1.w
    mad r2.xyz, r2, -r1.w, -r5
    dp3_sat r1.w, -c17, r2
    add r1.w, r1.w, c3.z
    add r0.w, r0.w, c3.z
    pow r2.x, r1.w, r0.w
    mul r2.xyz, r4, r2.x
    mul r2.xyz, r0.z, r2
    mul r2.xyz, r2, c17.w
    mad r0.xzw, r0.x, r2.xyyz, r1.xyyz
    add r1.x, c16.w, -v1.w
    add r1.y, -c16.z, c16.w
    rcp r1.y, r1.y
    mul_sat r1.x, r1.x, r1.y
    add r1.x, -r1.x, c0.x
    mov r2.x, c0.x
    add r1.yz, -r2.x, c16.xxyw
    mul r1.z, r1.x, r1.z
    mad r1.x, r1.x, r1.y, c0.x
    dp3 r1.y, r0.xzww, c5
    lrp r2.xyz, r1.x, r0.xzww, r1.y
    add r0.x, r1.y, c3.w
    pow r2.w, r0_abs.x, r1.z
    mul r0.xzw, r2.xyyz, r2.w
    rcp r1.x, c41.x
    mul_sat r1.x, r1.x, v1.w
    add r1.y, -c41.x, v1.w
    add r1.z, -c41.x, c41.y
    rcp r1.z, r1.z
    mul_sat r1.y, r1.y, r1.z
    lrp r3.x, c41.w, r1.x, r1.y
    add r1.x, r3.x, c41.z
    mov r3.xyz, c43
    add r3.xyz, -r3, c42
    mad r1.yzw, r1.y, r3.xxyz, c43.xxyz
    mad r1.yzw, r2.xxyz, -r2.w, r1
    mad r0.xzw, r1.x, r1.yyzw, r0
    mul oC0.xyz, r0.xzww, c66.x
    mov oC0.w, r0.y
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

// approximately 211 instruction slots used (19 texture, 192 arithmetic)
