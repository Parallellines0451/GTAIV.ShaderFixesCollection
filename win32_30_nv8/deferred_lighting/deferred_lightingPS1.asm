// Summary: Improved shadow filter + added PCSS thanks to robi29 + console-like ambient reflection intensity + console tree lighting thanks to AssaultKifle47 + dithering mask + fixed trees' orange glow
// Custom registers: c223
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
//   ParabSampler                 s5       1
//   GBufferStencilTextureSampler s6       1
//   gShadowZSamplerDir           s15      1
//

    ps_3_0
    def c219, 1.8395173895e+25, 3.9938258725e+24, 4.5435787456e+30, 8.4077907859e-45 // 6
    def c127, 0.9999999, 1, 0, 0	// LogDepth constants
    def c0, 512, 0.99609375, 7.96875, 63.75
    def c1, 0.25, 256, -127.999992, 9.99999975e-006
    def c2, 1.33333337, 9.99999975e-005, 512, 1
    def c3, 1, 0, 1.5, 1
    def c4, -0.5, 0.5, 0.0199999996, 0.00999999978
    def c5, 4, 0.75, 0.25, 5
    def c6, 10, 0, 0, 0
    def c7, 1, -1, 0, -0
    def c8, -0.321940005, -0.932614982, -0.791558981, -0.597710013
    def c9, 0.507430971, 0.0644249991, 0.896420002, 0.412458003
    def c10, 0.519456029, 0.767022014, 0.185461, -0.893123984
    def c11, 0.962339997, -0.194983006, 0.473434001, -0.480026007
    def c12, -0.69591397, 0.457136989, -0.203345001, 0.620715976
    def c13, -0.326211989, -0.405809999, -0.840143979, -0.0735799968
	def c20, 1.6666667, 0, 0, 0	// Reflection intensity multiplier
	def c21, 3, 2, 1, 0	// Console tree lighting constants
	def c22, 0.01171875, 0.01953125, 0.0234375, 0
	def c23, 0.35, 0.5, 0.3333333, 0
	// ------------------------------------------------------ 1.0.4.0 Shadow Filter Constants -------------------------------------------------------
    def c110, -0.25, 1, -1, 0
    def c111, 0.159154937, 0.5, 6.28318548, -3.14159274
    def c112, 3, 7.13800001, 3, 0.25
    def c113, 0.75, -0.5, 0.5, 0
	defi i1, 4, 0, 0, 0
	// ----------------------------------------------------------------------------------------------------------------------------------------------
	// --------------------------------------------------------- Filter Utilities Constants ---------------------------------------------------------
	def c120, 0.25, 0.5, 0.75, 0 // cascade identifiers
	
    def c121, 1, 0.475, 0, 0.12 // x,y = 1st & 2nd cascade blur | z,w = 1st & 2nd cascade bias
	def c122, 0.19, 0.0542857, 0.4, 0.7 // x,y = 3rd & 4th cascade blur | z,w = 3rd & 4th cascade bias
	
	def c130, 9.5, 0.0246914, 9.210526, 0.15 // smooth distance blur | x = start, y = 1/(end - start), z = maximum blur, w = maximum bias
	def c131, 0.0001220703125, 0.00048828125, 0, 0 // x,y = "Very High" setting texel size
	
	def c132, 0, 1, 2, 3 // filter ID's
	def c133, 0.5, 1, 1.5, 2 // blur multipliers
	
	// PCSS constants
    def c140, 49, 0.2333333, 0.5, 0.045
    def c141, -33, 6, 0, 1
    defi i2, 12, 0, 0, 0
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
    cmp r1.yzw, r1.xxyz, c3.x, c3.y
    mov r1.x, c2.w
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
    mad r1.xw, r1.y, c13.xyzy, r0.zyzw
    texld r2, r1.xwzw, s15
    add r1.x, r1.z, -r2.x
    cmp r1.x, r1.x, c3.x, c3.y
    mad r2.xy, r1.y, c13.zwzw, r0.zwzw
    texld r2, r2, s15
    add r1.w, r1.z, -r2.x
    cmp r1.w, r1.w, c3.x, c3.y
    add r1.x, r1.x, r1.w
    mad r2.xy, r1.y, c12, r0.zwzw
    texld r2, r2, s15
    add r1.w, r1.z, -r2.x
    cmp r1.w, r1.w, c3.x, c3.y
    add r1.x, r1.x, r1.w
    mad r2.xy, r1.y, c12.zwzw, r0.zwzw
    texld r2, r2, s15
    add r1.w, r1.z, -r2.x
    cmp r1.w, r1.w, c3.x, c3.y
    add r1.x, r1.x, r1.w
    mad r2.xy, r1.y, c11, r0.zwzw
    texld r2, r2, s15
    add r1.w, r1.z, -r2.x
    cmp r1.w, r1.w, c3.x, c3.y
    add r1.x, r1.x, r1.w
    mad r2.xy, r1.y, c11.zwzw, r0.zwzw
    texld r2, r2, s15
    add r1.w, r1.z, -r2.x
    cmp r1.w, r1.w, c3.x, c3.y
    add r1.x, r1.x, r1.w
    mad r2.xy, r1.y, c10, r0.zwzw
    texld r2, r2, s15
    add r1.w, r1.z, -r2.x
    cmp r1.w, r1.w, c3.x, c3.y
    add r1.x, r1.x, r1.w
    mad r2.xy, r1.y, c10.zwzw, r0.zwzw
    texld r2, r2, s15
    add r1.w, r1.z, -r2.x
    cmp r1.w, r1.w, c3.x, c3.y
    add r1.x, r1.x, r1.w
    mad r2.xy, r1.y, c9, r0.zwzw
    texld r2, r2, s15
    add r1.w, r1.z, -r2.x
    cmp r1.w, r1.w, c3.x, c3.y
    add r1.x, r1.x, r1.w
    mad r2.xy, r1.y, c9.zwzw, r0.zwzw
    texld r2, r2, s15
    add r1.w, r1.z, -r2.x
    cmp r1.w, r1.w, c3.x, c3.y
    add r1.x, r1.x, r1.w
    mad r2.xy, r1.y, c8, r0.zwzw
    mad r0.zw, r1.y, c8, r0
    texld r3, r0.zwzw, s15
    add r0.z, r1.z, -r3.x
    cmp r0.z, r0.z, c3.x, c3.y
    texld r2, r2, s15
    add r0.w, r1.z, -r2.x
    cmp r0.w, r0.w, c3.x, c3.y
    add r0.w, r1.x, r0.w
    add r0.z, r0.z, r0.w
	removed 1.0.6.0 filter */
	// ------------------------------------------------------------- Per Cascade Tweaks -------------------------------------------------------------
    add r21.xyz, r0.z, -c120.xyz
    cmp r22.xy, r21.x, c121.yw, c121.xz
    cmp r22.xy, r21.y, c122.xz, r22.xy
    cmp r22.xy, r21.z, c122.yw, r22.xy	// r22.x = per cascade blur, r22.y = per cascade bias
	
	mov r20.xy, c53.xy
	max r20.xy, r20.xy, c131.xy			// limit minimum blur
    mul r20.xy, r20.xy, r22.x			// reduce cascade blur disparity
	add r1.z, r1.z, -r22.y				// improve depth bias for 2nd, 3rd and 4th cascade
	// ----------------------------------------------------------------------------------------------------------------------------------------------
	// -------------------------------------------------------------- Filter Selection --------------------------------------------------------------
	mov r20.z, c223.y
    add r21.xyz, r20.z, -c132.yzw
    cmp r20.w, r21.x, c133.y, c133.x
    cmp r20.w, r21.y, c133.z, r20.w
    cmp r20.w, r21.z, c133.w, r20.w // "Sharp", "Soft", "Softer" & "Softest"
	
	if_gt r20.z, c132.w // "PCSS"
		mov r21.y, c141.z // blockers
	
		mul r22.xy, r22.xx, c141.xy // pcss texel step
	
		mov r23.xy, r22.xx // x - inner loop index, y - outer loop index
		mov r24.x, c141.z // sum
	
		rep i2
			mul r21.w, r23.y, c140.w
	
			rep i2
				mad r25.xy, c53.xy, r23.xy, r0.zw
				texldl r26, r25.xy, s15
	
				add r25.x, r26.x, -r1.z
	
				if_gt r25.x, r21.w
					min r25.x, r25.x, c140.x // < 49
					add r24.x, r24.x, r25.x
					add r21.y, r21.y, c141.w
				endif
	
				add r23.x, r23.x, r22.y // j++
			endrep
			add r23.y, r23.y, r22.y // i++
			mov r23.x, r22.x // j = -33
		endrep
	
		// avg if any blockers
		if_gt r21.y, c141.z
			rcp r21.y, r21.y
			mul r24.x, r24.x, r21.y
			mul r24.x, r24.x, c140.y // maximum intensity
		else
			mov r24.x, c141.z
		endif
	
		max r20.w, r24.x, c140.z // minimum intensity
	endif
	// ----------------------------------------------------------------------------------------------------------------------------------------------
	// ------------------------------------------------------------ Smooth Distance Blur ------------------------------------------------------------
	mov r20.z, c110.w
	add r21.x, r0.y, -c130.x
	mul_sat r21.x, r21.x, c130.y
	mul r21.x, r21.x, r21.x
	lrp r22.xy, r21.x, c130.zw, r20.wz // r22.x = blur factor, r22.y = bias factor
	
	mul r20.xy, r20.xy, r22.x
	add r1.z, r1.z, r22.y
	// ----------------------------------------------------------------------------------------------------------------------------------------------
	// ----------------------------------------------------------- 1.0.4.0 Shadow Filter ------------------------------------------------------------
    mov r21.xy, c112.xy
    mul r21.xy, r21.xy, c44.xy			// r21.xy * screen dimensions
    dp2add r21.y, v0, r21, c110.w		// v0.x * r21.x + v0.y * r21.y
    mad r21.y, r21.y, c111.x, c111.y
    frc r21.y, r21.y
    mad r21.y, r21.y, c111.z, c111.w	// r21.y * 2pi - pi
    sincos r22.xy, r21.y				// sine & cosine of r21.y

	mul r20.xy, r20.xy, c112.z			// blur factor
	mul r20.xy, r20.xy, c112.w			// compensate blur for extra iterations
	
	mov r20.zw, c110.w
	
	mov r26, c110.xxyz					// copy offsets for 1st and 4th samples, respectively
	mov r27, c113.xxyz					// copy offsets for 3rd and 2nd samples, respectively
	
	rep i1
		mul r23, r22.yxxy, r26
		mul r21, r22.yxxy, r27
		
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
		dp4 r20.w, r25, -c110.x				// average samples of current iteration
		add r20.z, r20.z, r20.w
		
		add r26, r26, c110.zzyz				// add (-1, -1, 1, -1)
		add r27, r27, -c110.zzyz			// add (1, 1, -1, 1)
	endrep
	
	mul r0.z, r20.z, c112.w					// average all iterations
	// ----------------------------------------------------------------------------------------------------------------------------------------------
    rcp r0.w, c53.w
    mul r0.w, r0.y, r0.w
    mul r0.w, r0.w, r0.w // improved shadow fadeout
    add r0.y, r0.y, -c53.w
    cmp r1.xy, r0.y, c7, c7.zwzw
    mul r0.y, r0.w, r0.w
    mul r0.y, r0.y, c3.z
    mad r0.y, r0.z, c3.w, r0.y
    add r0.z, r1.y, r0.y
	// ----------------------------------------------------------- Console Tree Lighting ------------------------------------------------------------
	texld r21, v0, s6
	add r21.yz, r21.x, -c22
	cmp r21.yz, -r21_abs, c3.x, c3.y
	add_sat r21.x, r21.y, r21.z // masks 5 and 6
	mov r21.y, c223.x
	add r21.y, r21.y, -c21.y
	cmp r21.y, -r21_abs.y, r21.x, c3.y	// Console tree lighting toggle
	if_eq r21.y, c3.y
		cmp_sat r0.y, r0.z, r0.y, r1.x
		texld r1, v0, s1
		mul r2.xyz, r1.w, c0.yzww
		frc r2.xyz, r2
		add r3.xyz, r2, r2
		mad r3.xy, r2.yzzw, -c1.x, r3
		mad r1.xyz, r1, c1.y, r3
		add r1.xyz, r1, c1.z
		nrm r2.xyz, r1
		mad r1.xyz, v1, -r0.x, c1.w
		mul r0.xzw, r0.x, v1.xyyz
		nrm r3.xyz, r1
		dp3 r1.x, r3, r2
		add r1.y, r1.x, r1.x
		add r1.x, -r1_abs.x, c2.w
		mul r1.x, r1.x, r1.x
		mul r1.x, r1.x, r1.x
		mad r1.x, r1.x, c5.y, c5.z
		mad r1.yzw, r2.xxyz, -r1.y, r3.xxyz
		dp3_sat r2.w, -c17, r1.yzww
		add r2.w, r2.w, c2.y
		texld r4, v0, s2
		mul r3.w, r4.y, r4.y
		mad r4.y, r3.w, c2.z, c2.y
		mul r3.w, r3.w, c0.x
		mul_sat r3.w, r3.w, c72.x
		mad r5.w, r3.w, -c5.x, c5.x
		pow r3.w, r2.w, r4.y
		mul r6.xyz, c18.w, c18
		mul r7.xyz, r3.w, r6
		mul r7.xyz, r0.y, r7
		dp3 r0.x, r3, -r0.xzww
		mul_sat r0.xz, r0.x, c4.zyww
		mad r1.yzw, r3.xxyz, r0.x, r1
		add r0.x, -r0.z, c2.w
		add r1.yzw, r1, c1.w
		nrm r3.xyz, r1.yzww
		mul_sat r0.z, r3.z, c5.w
		mov_sat r0.w, r3.z
		add r0.w, r0.w, c2.w
		add r0.w, r0.w, r0.w
		rcp r0.w, r0.w
		mad r1.yz, r3.xxyw, r0.w, c4.y
		add r5.xy, -r1.yzzw, c2.w
		mov r5.z, c3.y
		texldl r3, r5, s5
		mul r3, r3, c20.x	// reflection intensity tweak
		mul r1.yzw, r0.z, r3.xxyz
		mul r0.xzw, r0.x, r1.yyzw
		mul r0.xzw, r4.z, r0
		mul r0.xzw, r0, c39.w
		mul r0.xzw, r1.x, r0
		mul r0.xzw, r0, c6.x
		add r1.x, c17.w, c17.w
		mad r0.xzw, r7.xyyz, r1.x, r0
		add r1.x, r4.x, r4.x
		mul r0.xzw, r0, r1.x
		dp3 r1.x, r2, -c17
		mad_sat r1.y, r2.z, c4.x, c4.y
		mov r10, c38
		mov r11, c37
		if_ne -r21_abs.x, c3.y // Tree orange glow fix
			dp3 r12.x, r10, c23.z
			dp3 r12.y, r11, c23.z
			lrp r10, c23.x, r10, r12.x
			lrp r11, c23.y, r11, r12.y
		endif
		mov r2.xyz, r10
		mad r1.yzw, r2.xxyz, r1.y, r11.xxyz
		mul r1.yzw, r4.z, r1
		add r1.x, r1.x, -c1.x
		mul_sat r1.x, r1.x, c2.x
		mul r2.xyz, r6, r1.x
		mad r1.xyz, r2, r0.y, r1.yzww
		texld r2, v0, s0
		mad oC0.xyz, r2, r1, r0.xzww
		mov oC0.w, c2.w
	else
		cmp_sat r8.x, r0.z, r0.y, r1.x
		
		texld r1, v0, s1
		mul r2.xyz, r1.w, c0.yzww
		frc r2.xyz, r2
		add r3.xyz, r2, r2
		mad r3.xy, r2.yzzw, -c1.x, r3
		mad r1.xyz, r1, c1.y, r3
		add r1.xyz, r1, c1.z
		nrm r2.xyz, r1
		
		mad r1.xyz, v1, -r0.x, c1.w
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
		mad r1.yz, r3.yxyx, r1.y, c4.yy
		//                    1
		add r1.yz, -r1.yzyz, c3.x
		
		mov r1.xy, r1.zy
		//0
		mov r1.z, c3.y
		//4
		mov r1.w, c5.x
		texldl r4.xyz, r1, s5
		
		//viewDir.z * -0.5 + 0.5
		mad_sat r1.y, r3.z, c4.x, c4.y
		
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
		mul r2.w, c1.x, r0.x
		
		//parabAmbient * saturate(viewDir.z * 2) + ambient
		mad r4.xyz, r4.xyz, r0.w, r1.yzw
		
		max r1.yzw, r4.xxyz, r1.yyzw
		//        0.25
		mul r0.w, c1.x, r0.z
		
		mul r0.xyz, r2.w, r1.yzw
		//diffuseLight * shadow + r0
		mad r0.xyz, r5.xyz, r8.x, r0.xyz
		
		//diffuse * r0
		texld r2.xyz, v0, s0
		mul r0.xyz, r0.xyz, r2.xyz
		
		mul r0.w, r0.w, r0.w
		
		mad oC0.xyz, r0.w, r1.yzw, r0.xyz
		mov oC0.w, c2.w
	endif
	// ----------------------------------------------------------------------------------------------------------------------------------------------

// approximately 167 instruction slots used (18 texture, 149 arithmetic)
