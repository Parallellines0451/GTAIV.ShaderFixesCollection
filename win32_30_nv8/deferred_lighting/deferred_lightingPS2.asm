// Summary: Improved shadow filter + added PCSS thanks to robi29 + improved shadow fadeout + console-like ambient reflection intensity + console tree lighting thanks to AssaultKifle47 + dithering mask + fixed trees' orange glow
// Generated by Microsoft (R) HLSL Shader Compiler 9.26.952.2844
//
// Parameters:
//
//   sampler2D GBufferStencilTextureSampler;
//   sampler2D GBufferTextureSampler0;
//   sampler2D GBufferTextureSampler1;
//   sampler2D GBufferTextureSampler2;
//   sampler2D GBufferTextureSampler3;
//   sampler2D ParabSampler;
//   float4 dReflectionParams;
//   float4 gDeferredProjParams;
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
//   float4 globalScalars;
//
//
// Registers:
//
//   Name                         Reg   Size
//   ---------------------------- ----- ----
//   gViewInverse                 c12      4
//   gDirectionalLight            c17      1
//   gDirectionalColour           c18      1
//   gLightAmbient0               c37      1
//   gLightAmbient1               c38      1
//   globalScalars                c39      1
//   gShadowParam18192021         c53      1
//   gFacetCentre                 c54      1
//   gShadowParam14151617         c56      1
//   gShadowParam0123             c57      1
//   gShadowParam4567             c58      1
//   gShadowParam891113           c59      1
//   gShadowMatrix                c60      4
//   gDeferredProjParams          c66      1
//   dReflectionParams            c72      1
//   GBufferTextureSampler0       s0       1
//   GBufferTextureSampler1       s1       1
//   GBufferTextureSampler2       s2       1
//   GBufferTextureSampler3       s4       1
//   GBufferStencilTextureSampler s5       1
//   ParabSampler                 s6       1
//   gShadowZSamplerDir           s15      1
//

    ps_3_0
    def c219, 1.8395173895e+25, 3.9938258725e+24, 4.5435787456e+30, 9.8090892503e-45 // 7
    def c127, 0.9999999, 1, 0, 0	// LogDepth constants
    def c0, 0, 512, 4096, 0.00200000009
    def c1, 0.99609375, 7.96875, 63.75, 0.25
    def c2, 256, -127.999992, 0.000392156857, 4
    def c3, 2, 0.5, 1, 9.99999975e-006
    def c4, 1.33333337, 9.99999975e-005, 1, 0
    def c5, 1.5, -0.326211989, -0.405809999, 0.0833333358
    def c6, -0.791558981, -0.597710013, -0.5, 0.5
    def c7, 0.0199999996, 0.00999999978, 0.75, 0.25
    def c8, 5, 10, 0, 0
    def c9, 1, -1, 0, -0
    def c10, 0.896420002, 0.412458003, -0.321940005, -0.932614982
    def c11, 0.185461, -0.893123984, 0.507430971, 0.0644249991
    def c12, 0.473434001, -0.480026007, 0.519456029, 0.767022014
    def c13, -0.203345001, 0.620715976, 0.962339997, -0.194983006
    def c16, -0.840143979, -0.0735799968, -0.69591397, 0.457136989
	def c20, 1.6666667, 0.212500006, 0.715399981, 0.0720999986	// Reflection intensity multiplier
	def c21, 3, 2, 1, 0	// Console tree lighting constants
	def c22, 0.012156862745098, 0.023921568627451, 0.027843137254902, 0 // 3.1, 6.1, 7.1
	def c23, 0.35, 0.5, 0, 0.0007843137254902
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
    dcl_texcoord v0.xy
    dcl_texcoord1 v1
    dcl_2d s0
    dcl_2d s1
    dcl_2d s2
    dcl_2d s4
    dcl_2d s5
    dcl_2d s6
    dcl_2d s15
    texld r0, v0, s4
	// ----------------------------------------------------------------- Log2Linear -----------------------------------------------------------------
	if_ne r0.x, c127.y
		rcp r20.x, c128.x
		mul r20.x, r20.x, c128.y
		pow r20.x, r20.x, r0.x
		mul r20.x, r20.x, c128.x	// W_clip
		
		add r20.y, r20.x, -c128.x
		add r20.z, c128.y, -c128.x
		mul r20.y, r20.y, c128.y
		mul r20.z, r20.z, r20.x
		rcp r20.z, r20.z
		mul r20.w, r20.y, r20.z		// Linear depth
		
		min r0, r20.w, c127.x		// FP error hack
	endif
	// ----------------------------------------------------------------------------------------------------------------------------------------------
    mad r0.x, r0.x, c66.z, -c66.w
    mul r0.x, r0.x, v1.w
    rcp r0.x, r0.x
    mad r0.yzw, v1.xxyz, -r0.x, c15.xxyz
    dp3 r1.x, c14, r0.yzww
    add r1.xyz, -r1.x, -c54
    cmp r1.yzw, r1.xxyz, c4.z, c4.w
	// ---------------------------------------------------------------- Cascade Mask ----------------------------------------------------------------
	mov r21.x, c110.y
	mov r21.yzw, r1
	add r21.xyz, r21.xyz, -r21.yzw
	// ----------------------------------------------------------------------------------------------------------------------------------------------
    mov r1.x, c3.z
    dp4 r2.x, r1, c57
    dp4 r2.y, r1, c58
    dp4 r3.x, r1, c59
    dp4 r3.y, r1, c56
    mul r1.xyz, r0.z, c61.xyww
    mad r1.xyz, r0.y, c60.xyww, r1
    mad r1.xyz, r0.w, c62.xyww, r1
    add r0.yzw, -r0, c15.xxyz
    dp3 r0.y, r0.yzww, r0.yzww
    rsq r0.y, r0.y
    rcp r0.y, r0.y
    add r1.xyz, r1, c63.xyww
    mad r0.zw, r1.xyxy, r2.xyxy, r3.xyxy
    /* removed 1.0.6.0 filter
    mov r1.y, c53.y
    mad r1.xw, r1.y, c5.yyzz, r0.zyzw
    texld r2, r1.xwzw, s15
    add r1.x, r1.z, -r2.x
    cmp r1.x, r1.x, c4.z, c4.w
    mad r2.xy, r1.y, c16, r0.zwzw
    texld r2, r2, s15
    add r1.w, r1.z, -r2.x
    cmp r1.w, r1.w, c4.z, c4.w
    add r1.x, r1.x, r1.w
    mad r2.xy, r1.y, c16.zwzw, r0.zwzw
    texld r2, r2, s15
    add r1.w, r1.z, -r2.x
    cmp r1.w, r1.w, c4.z, c4.w
    add r1.x, r1.x, r1.w
    mad r2.xy, r1.y, c13, r0.zwzw
    texld r2, r2, s15
    add r1.w, r1.z, -r2.x
    cmp r1.w, r1.w, c4.z, c4.w
    add r1.x, r1.x, r1.w
    mad r2.xy, r1.y, c13.zwzw, r0.zwzw
    texld r2, r2, s15
    add r1.w, r1.z, -r2.x
    cmp r1.w, r1.w, c4.z, c4.w
    add r1.x, r1.x, r1.w
    mad r2.xy, r1.y, c12, r0.zwzw
    texld r2, r2, s15
    add r1.w, r1.z, -r2.x
    cmp r1.w, r1.w, c4.z, c4.w
    add r1.x, r1.x, r1.w
    mad r2.xy, r1.y, c12.zwzw, r0.zwzw
    texld r2, r2, s15
    add r1.w, r1.z, -r2.x
    cmp r1.w, r1.w, c4.z, c4.w
    add r1.x, r1.x, r1.w
    mad r2.xy, r1.y, c11, r0.zwzw
    texld r2, r2, s15
    add r1.w, r1.z, -r2.x
    cmp r1.w, r1.w, c4.z, c4.w
    add r1.x, r1.x, r1.w
    mad r2.xy, r1.y, c11.zwzw, r0.zwzw
    texld r2, r2, s15
    add r1.w, r1.z, -r2.x
    cmp r1.w, r1.w, c4.z, c4.w
    add r1.x, r1.x, r1.w
    mad r2.xy, r1.y, c10, r0.zwzw
    texld r2, r2, s15
    add r1.w, r1.z, -r2.x
    cmp r1.w, r1.w, c4.z, c4.w
    add r1.x, r1.x, r1.w
    mad r2.xy, r1.y, c10.zwzw, r0.zwzw
    mad r0.zw, r1.y, c6.xyxy, r0
    texld r3, r0.zwzw, s15
    add r0.z, r1.z, -r3.x
    cmp r0.z, r0.z, c4.z, c4.w
    texld r2, r2, s15
    add r0.w, r1.z, -r2.x
    cmp r0.w, r0.w, c4.z, c4.w
    add r0.w, r1.x, r0.w
    add r0.z, r0.z, r0.w
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
	add r1.z, r1.z, -r20.w // apply per cascade bias
	if_ne r24.z, c223.y // PCSS
		mov r24.xyw, c110.w // sum
		mul r25.xy, r20.z, c124.xy // pcss texel step
		mov r25.zw, r25.x // x - inner loop index, y - outer loop index
		rep i1
			mul r24.z, r25.w, c124.z
			rep i1
				mad r26.xy, c53.xy, r25.zw, r0.zw
				texldl r27, r26.xy, s15
				add r26.x, r27.x, -r1.z
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
	add r22.x, r0.y, -r22.x
	add r22.y, c54.z, -c54.x
	rcp r22.y, r22.y
	mul_sat r22.x, r22.x, r22.y
	mul r22.x, r22.x, r22.x
	mul r22.y, r23.x, c53.w
	mov r22.z, c123.x
	lrp r23.xy, r22.x, r22.yz, r24.xy
	mul r20.xy, r20.xy, r23.x // apply depth based blur
	add r1.z, r1.z, r23.y // apply depth based bias
	
    mov r21.xy, c112.xy
    mul r21.xy, r21.xy, c44.xy			// r21.xy * screen dimensions
    dp2add r21.y, v0, r21, c110.w		// v0.x * r21.x + v0.y * r21.y
    mad r21.y, r21.y, c111.x, c111.y
    frc r21.y, r21.y
    mad r21.y, r21.y, c111.z, c111.w	// r21.y * 2pi - pi
    sincos r22.xy, r21.y				// cosine & sine of r21.y
    mul r23, r22.yxxy, c110.xxyz		// offsets for 1st and 4th samples, respectively
    mul r21, r22.yxxy, c113.xxyz        // offsets for 3rd and 2nd samples, respectively
	mul r20.xy, r20.xy, c112.z			// blur factor
	
    mad r24.xy, r23.xy, r20.xy, r0.zw	// offset * texel size + UV
    texld r24, r24, s15					// 1st sample
    mov r25.x, r24.x					// copy to r25
    mad r24.xy, r21.zw, r20.xy, r0.zw	// offset * texel size + UV
    texld r24, r24, s15					// 2nd sample
    mov r25.y, r24.x					// copy to r25
    mad r24.xy, r21.xy, r20.xy, r0.zw	// offset * texel size + UV
    texld r24, r24, s15					// 3rd sample
    mov r25.z, r24.x					// copy to r25
    mad r24.xy, r23.zw, r20.xy, r0.zw	// offset * texel size + UV
    texld r24, r24, s15					// 4th sample
    mov r25.w, r24.x					// copy to r25
	add r25, r1.z, -r25					// depth bias
	cmp r25, r25, c110.y, c110.w
	dp4 r26.x, r25, -c110.x				// average
	
    mul r23, r22.yxxy, c114.xxyz		// offsets for 5th and 8th samples, respectively
    mul r21, r22.yxxy, c115.xxyz        // offsets for 7th and 6th samples, respectively
	
    mad r24.xy, r23.xy, r20.xy, r0.zw	// offset * texel size + UV
    texld r24, r24, s15					// 5th sample
    mov r25.x, r24.x					// copy to r25
    mad r24.xy, r21.zw, r20.xy, r0.zw	// offset * texel size + UV
    texld r24, r24, s15					// 6th sample
    mov r25.y, r24.x					// copy to r25
    mad r24.xy, r21.xy, r20.xy, r0.zw	// offset * texel size + UV
    texld r24, r24, s15					// 7th sample
    mov r25.z, r24.x					// copy to r25
    mad r24.xy, r23.zw, r20.xy, r0.zw	// offset * texel size + UV
    texld r24, r24, s15					// 8th sample
    mov r25.w, r24.x					// copy to r25
	add r25, r1.z, -r25					// depth bias
	cmp r25, r25, c110.y, c110.w
	dp4 r26.y, r25, -c110.x				// average
	
    mul r23, r22.yxxy, c116.xxyz		// offsets for 9th and 12th samples, respectively
    mul r21, r22.yxxy, c117.xxyz        // offsets for 11th and 10th samples, respectively
	
    mad r24.xy, r23.xy, r20.xy, r0.zw	// offset * texel size + UV
    texld r24, r24, s15					// 9th sample
    mov r25.x, r24.x					// copy to r25
    mad r24.xy, r21.zw, r20.xy, r0.zw	// offset * texel size + UV
    texld r24, r24, s15					// 10th sample
    mov r25.y, r24.x					// copy to r25
    mad r24.xy, r21.xy, r20.xy, r0.zw	// offset * texel size + UV
    texld r24, r24, s15					// 11th sample
    mov r25.z, r24.x					// copy to r25
    mad r24.xy, r23.zw, r20.xy, r0.zw	// offset * texel size + UV
    texld r24, r24, s15					// 12th sample
    mov r25.w, r24.x					// copy to r25
	add r25, r1.z, -r25					// depth bias
	cmp r25, r25, c110.y, c110.w
	dp4 r26.z, r25, -c110.x				// average
	
	dp3 r0.z, r26, c112.w
	// ----------------------------------------------------------------------------------------------------------------------------------------------
    rcp r0.w, c53.w
    mul r0.w, r0.y, r0.w
    mul r0.w, r0.w, r0.w // improved shadow fadeout
    add r0.y, r0.y, -c53.w
    cmp r1.xy, r0.y, c9, c9.zwzw
    mul r0.y, r0.w, r0.w
    mul r0.y, r0.y, c5.x
    add r0.y, r0.z, r0.y // mad r0.y, r0.z, c5.w, r0.y 1.0.6.0 filter average
    add r0.z, r1.y, r0.y
	// ----------------------------------------------------------- Console Tree Lighting ------------------------------------------------------------
	texld r21, v0, s5
	add r21.yz, r21.x, -c22
	add_sat r21.yz, -r21_abs, c23.w
	add r21.x, r21.y, r21.z
	mov r21.y, c223.x
	add r21.y, r21.y, -c21.y
	cmp r21.y, -r21_abs.y, r21.x, c4.w	// Console tree lighting toggle
	if_eq r21.y, c4.w
		cmp_sat r0.y, r0.z, r0.y, r1.x
		texld r1, v0, s1
		mul r2.xyz, r1.w, c1
		frc r2.xyz, r2
		add r3.xyz, r2, r2
		mad r3.xy, r2.yzzw, -c1.w, r3
		mad r1.xyz, r1, c2.x, r3
		add r1.xyz, r1, c2.y
		nrm r2.xyz, r1
		mad r1.xyz, v1, -r0.x, c3.w
		mul r0.xzw, r0.x, v1.xyyz
		nrm r3.xyz, r1
		dp3 r1.x, r3, r2
		add r1.y, r1.x, r1.x
		add r1.x, -r1_abs.x, c3.z
		mul r1.x, r1.x, r1.x
		mul r1.x, r1.x, r1.x
		mad r1.x, r1.x, c7.z, c7.w
		mad r1.yzw, r2.xxyz, -r1.y, r3.xxyz
		dp3_sat r2.w, -c17, r1.yzww
		add r2.w, r2.w, c4.y
		mul r3.w, r2.z, c2.w
		mov_sat r3.w, r3.w
		mul r3.w, r3.w, c72.y
		texld r4, v0, s5
		
		// add r4.x, -r4.x, c2.z
		// cmp r3.w, r4.x, r3.w, c0.x
		add r20.xy, r4.x, -c22.xw
		add_sat r20.xy, -r20_abs, c23.w
		add r4.x, r20.x, r20.y // change wetness mask to include stencil 3 alongside 0 (since 3 is now used for the dithering mask)
		cmp r3.w, -r4.x, c0.x, r3.w
		
		texld r4, v0, s2
		mul r4.y, r4.y, r4.y
		mul r5.xy, r4.y, c0.yzzw
		min r4.w, r5.y, c2.x
		mad r4.y, r4.y, -c0.y, r4.w
		mad r4.y, r3.w, r4.y, r5.x
		max r6.x, r5.x, r4.y
		add r4.y, r6.x, c4.y
		pow r5.x, r2.w, r4.y
		mul r5.yzw, c18.w, c18.xxyz
		mul r6.yzw, r5.x, r5
		mul r6.yzw, r0.y, r6
		dp3 r0.x, r3, -r0.xzww
		mul_sat r0.xz, r0.x, c7.xyyw
		add r0.z, -r0.z, c3.z
		mad r1.yzw, r3.xxyz, r0.x, r1
		add r1.yzw, r1, c3.w
		nrm r3.xyz, r1.yzww
		mul_sat r0.x, r3.z, c8.x
		mov_sat r0.w, r3.z
		add r0.w, r0.w, c3.z
		add r0.w, r0.w, r0.w
		rcp r0.w, r0.w
		mad r1.yz, r3.xxyw, r0.w, c3.y
		add r7.xy, -r1.yzzw, c3.z
		mul_sat r0.w, r6.x, c72.x
		mul r1.y, r6.x, c0.w
		min r2.w, r1.y, c1.w
		mad r1.y, r4.x, -c3.x, r2.w
		mad r7.w, r0.w, -c2.w, c2.w
		mov r7.z, c0.x
		texldl r7, r7, s6
		mul r7, r7, c20.x	// reflection intensity tweak
		mul r3.xyz, r0.x, r7
		mul r0.xzw, r0.z, r3.xyyz
		mul r0.xzw, r4.z, r0
		mul r0.xzw, r0, c39.w
		mul r0.xzw, r1.x, r0
		mul r0.xzw, r0, c8.y
		add r1.x, c17.w, c17.w
		mad r0.xzw, r6.yyzw, r1.x, r0
		add r1.x, r4.x, r4.x
		mad r1.y, r3.w, r1.y, r1.x
		mad r1.z, r3.w, -c3.y, c3.z
		max r2.w, r1.x, r1.y
		mul r0.xzw, r0, r2.w
		dp3 r1.x, r2, -c17
		mad_sat r1.y, r2.z, c6.z, c6.w
		mov r10, c38
		mov r11, c37
		if_ne -r21_abs.x, c4.w // Tree orange glow fix
			dp3 r12.x, r10, c20.yzw
			dp3 r12.y, r11, c20.yzw
			lrp r10, c23.x, r10, r12.x
			lrp r11, c23.y, r11, r12.y
		endif
		mov r2.xyz, r10
		mad r2.xyz, r2, r1.y, r11
		mul r2.xyz, r4.z, r2
		add r1.x, r1.x, -c1.w
		mul_sat r1.x, r1.x, c4.x
		mul r1.xyw, r5.yzzw, r1.x
		mad r1.xyw, r1, r0.y, r2.xyzz
		texld r2, v0, s0
		mul r2.xyz, r1.z, r2
		mad oC0.xyz, r2, r1.xyww, r0.xzww
		mov oC0.w, c3.z
	else
		cmp_sat r8.x, r0.z, r0.y, r1.x
		
		texld r1, v0, s1
		mul r2.xyz, r1.w, c1
		frc r2.xyz, r2
		add r3.xyz, r2, r2
		mad r3.xy, r2.yzzw, -c1.w, r3
		mad r1.xyz, r1, c2.x, r3
		add r1.xyz, r1, c2.y
		nrm r2.xyz, r1
		
		mad r1.xyz, v1, -r0.x, c3.w
		nrm r3.xyz, r1
		
		//dot(viewDir, normal)
		dp3 r4.y, r3.xyz, r2.xyz
		//saturate(viewDir.z)
		mov_sat r4.x, r3.z
		//                 (3, 2, 1)
		add r0.xyz, r4.yxy, c21.xyz
		
		add r1.y, r0.y, r4.x
		rcp r1.y, r1.y
		//                        0.5
		mad r1.yz, r3.yxyx, r1.y, c3.yy
		//                    1
		add r1.yz, -r1.yzyz, c3.z
		
		mov r1.xy, r1.zy
		//0
		mov r1.z, c4.w
		//4
		mov r1.w, c2.w
		texldl r4.xyz, r1, s6
		
		//viewDir.z * -0.5 + 0.5
		mad_sat r1.y, r3.z, c6.z, c6.w
		
		mul r6.xyz, c18.xyz, c18.w
		//dot(normal, -dirLight) * dirLightColor
		dp3_sat r0.w, r2.xyz, -c17.xyz
		mul r5.xyz, r6, r0.w
		
		//saturate(viewDir.z * 2)
		add_sat r0.w, r3.z, r3.z
		
		//remappedViewDir.z * ambient1 + ambient0
		mov r8.yzw, c38.xxyz
		mad r1.yzw, r1.y, r8.yyzw, c37.xxyz
		
		//paraboloid - ambient
		add r4.xyz, -r1.yzw, r4.xyz
		
		//        0.25
		mul r2.w, c1.w, r0.x
		
		//parabAmbient * saturate(viewDir.z * 2) + ambient
		mad r4.xyz, r4.xyz, r0.w, r1.yzw
		
		max r1.yzw, r4.xxyz, r1.yyzw
		//        0.25
		mul r0.w, c1.w, r0.z
		
		mul r0.xyz, r2.w, r1.yzw
		//diffuseLight * shadow + r0
		mad r0.xyz, r5.xyz, r8.x, r0.xyz
		
		//diffuse * r0
		texld r2.xyz, v0, s0
		mul r0.xyz, r0.xyz, r2.xyz
		
		mul r0.w, r0.w, r0.w
		
		mad oC0.xyz, r0.w, r1.yzw, r0.xyz
		mov oC0.w, c4.z
	endif
	// ----------------------------------------------------------------------------------------------------------------------------------------------

// approximately 184 instruction slots used (19 texture, 165 arithmetic)
