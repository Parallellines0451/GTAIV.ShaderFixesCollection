// Summary: removed unnecessary stipple + console-like ambient reflection intensity + improved shadow filter + added PCSS thanks to robi29 + improved shadow fadeout
// Generated by Microsoft (R) HLSL Shader Compiler 9.26.952.2844
//
// Parameters:
//
//   sampler2D EnvironmentSampler;
//   sampler2D SpecSampler;
//   sampler2D StippleTexture;
//   sampler2D TextureSampler;
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
//   float4 gLightConeScale;
//   float4 gLightDirX;
//   float4 gLightDirY;
//   float4 gLightDirZ;
//   float4 gLightFallOff;
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
//   float3 specMapIntMask;
//   float specularColorFactor;
//   float specularFactor;
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
//   specularFactor       c66      1
//   specularColorFactor  c72      1
//   specMapIntMask       c73      1
//   reflectivePower      c74      1
//   TextureSampler       s0       1
//   SpecSampler          s1       1
//   EnvironmentSampler   s2       1
//   StippleTexture       s10      1
//   gShadowZSamplerDir   s15      1
//

    ps_3_0
	// ------------------------------------------------------ 1.0.4.0 Shadow Filter Constants -------------------------------------------------------
    def c110, -0.25, 1, -1, 0
    def c111, 0.159154937, 0.5, 6.28318548, -3.14159274
    def c112, 3, 7.13800001, 3, 0.3333333
    def c113, 0.75, -0.5, 0.5, 0
	defi i1, 3, 0, 0, 0
	// ----------------------------------------------------------------------------------------------------------------------------------------------
	// --------------------------------------------------------------- PCSS Constants ---------------------------------------------------------------
    def c114, 49, 1, 1, 0.045
    def c115, -33, 6, 0, 0
    defi i2, 12, 0, 0, 0
	// ----------------------------------------------------------------------------------------------------------------------------------------------
	// --------------------------------------------------------- Filter Utilities Constants ---------------------------------------------------------
	def c116, 0.25, 0.5, 0.75, 0 // cascade identifiers
	def c117, 0, 1, 2, 3 // filter ID's
	def c118, 0.5, 1, 1.5, 2 // blur multipliers
	def c119, 0.0001220703125, 0.00048828125, 0.00006103515625, 0.000244140625 // static texel size
	
	// Very High
    def c130, 1, 0.475, 0.1, 0.22 // x,y = 1st & 2nd cascade blur | z,w = 1st & 2nd cascade bias
	def c131, 0.19, 0.0542857, 0.5, 0.8 // x,y = 3rd & 4th cascade blur | z,w = 3rd & 4th cascade bias
	def c132, 9.5, 0.0246914, 9.2105263, 0.15 // depth based blur | x = start, y = 1/(end - start), z = maximum blur, w = maximum bias
	
	// High
	def c133, 1, 0.4, 0.22, 0.42
	def c134, 0.1538462, 0.0571429, 1.07, 1.22
	def c135, 10, 0.0181818, 8.75, 0.15
	
	// Medium
	def c136, 2, 0.7878788, 0.28, 0.53
	def c137, 0.2888888, 0.1485714, 0.98, 1.08
	def c138, 13, 0.0129870, 6.7307692, 0.15
	
	// Low
	def c139, 2, 0.8888888, 0.5, 0.8
	def c140, 0.4444444, 0.2285714, 1.35, 1.5
	def c141, 20, 0.0142857, 4.375, 0.15
	// ----------------------------------------------------------------------------------------------------------------------------------------------
    def c219, 1.8395173895e+25, 3.9938258725e+24, 4.5435787456e+30, 8.0574661699e-43 // 575
    def c127, 0.9999999, 1, 0, 0	// LogDepth constants
    def c0, -0.5, -0.00999999978, 100, 0.5
    def c1, 1.33333337, 9.99999975e-005, 1.5, 0.0833333358
    def c2, 0, -1, -0, 9.99999975e-006
    def c3, -0.100000001, 1.11111116, 1.00000001e-007, 0
    def c4, 3.99600005, 4, 0.125, 0.25
    def c5, 0.212500006, 0.715399981, 0.0720999986, 0
    def c6, 1, -1, 0, -0
    def c7, -0.321940005, -0.932614982, -0.791558981, -0.597710013
    def c8, 0.507430971, 0.0644249991, 0.896420002, 0.412458003
    def c9, 0.519456029, 0.767022014, 0.185461, -0.893123984
    def c10, 0.962339997, -0.194983006, 0.473434001, -0.480026007
    def c11, -0.69591397, 0.457136989, -0.203345001, 0.620715976
    def c12, -0.326211989, -0.405809999, -0.840143979, -0.0735799968
	def c100, 1.6666667, 0, 0, 0	// Reflection intensity multiplier
    dcl_texcoord v0.xy
    dcl_texcoord1 v1
    dcl_texcoord3 v2.xyz
    dcl_color v3.xw
    dcl_texcoord6 v4.xyz
    dcl vPos.xy
    dcl_texcoord9 v9
    dcl_2d s0
    dcl_2d s1
    dcl_2d s2
    dcl_2d s10
    dcl_2d s15
    /* removed stipple
    mov_sat r0.x, c39.x
    mul r0.x, r0.x, c4.x
    frc r0.y, r0.x
    mul r0.z, r0.y, c4.y
    frc r0.w, r0.z
    add r1.xy, r0.zxzw, -r0.wyzw
    mul r0.xy, c4.z, vPos
    frc r0.xy, r0_abs
    cmp r0.xy, vPos, r0, -r0
    mul r0.xy, r0, c4.w
    mad r0.xy, r1, c4.w, r0
    mov r0.zw, c2.x
    texldl r0, r0, s10
    cmp r0, -r0.y, c2.y, c2.z
    texkill r0
    removed stipple */
    texld r0, v0, s0
    add r1.xyz, c2.w, v1
    nrm r2.xyz, r1
    texld r1, v0, s1
    mul r2.w, r1.w, c66.x
    dp3 r1.x, r1, c73
    mul r1.x, r1.x, c72.x
    add r3.xyz, c2.w, v2
    nrm r4.xyz, r3
    dp3 r1.y, -r4, r2
    add r1.y, r1.y, r1.y
    mad r3.xyz, r2, -r1.y, -r4
    add r4.xyz, r3, c2.w
    dp3 r1.y, r4, r4
    rsq r1.y, r1.y
    mad r1.yz, r4.xxzw, r1.y, -c2.y
    mul r1.yz, r1, c0.x
    texld r4, r1.yzzw, s2
	mul r4, r4, c100.x
    mul r4.xyz, r1.x, r4
    mul r4.xyz, r4, c74.x
    mul r5.w, r0.w, v3.w
    mad r0.w, r0.w, v3.w, c0.y
    rcp r1.y, r5.w
    cmp r0.w, r0.w, r1.y, c0.z
    mad r5.xyz, r4, r0.w, r0
    mad_sat r0.x, r2.z, c0.x, c0.w
    mov r4.xyz, c38
    mad r0.xyz, r4, r0.x, c37
    mul r4.xyz, c18.w, c18
    dp3 r0.w, r2, -c17
    add r0.w, r0.w, -c4.w
    mul_sat r0.w, r0.w, c1.x
    dp3_sat r1.y, -c17, r3
    add r1.y, r1.y, c1.y
    mov r6.y, c1.y
    mad r1.z, r1.w, c66.x, r6.y
    pow r3.w, r1.y, r1.z
    mul r1.yzw, c61.xxyw, v4.y
    mad r1.yzw, v4.x, c60.xxyw, r1
    mad r1.yzw, v4.z, c62.xxyw, r1
    add r1.yzw, r1, c63.xxyw
    dp3 r4.w, c14, v4
    add r6.xyz, -r4.w, -c54
    cmp r6.yzw, r6.xxyz, -c2.y, -c2.z
    mov r6.x, -c2.y
    dp4 r7.x, r6, c57
    dp4 r7.y, r6, c58
    dp4 r8.x, r6, c59
    dp4 r8.y, r6, c56
    mad r1.yz, r1, r7.xxyw, r8.xxyw
    add r6.xyz, c15, -v4
    dp3 r4.w, r6, r6
    rsq r4.w, r4.w
    rcp r4.w, r4.w
    rcp r6.x, c53.w
    mul r6.x, r4.w, r6.x
    mul r6.x, r6.x, r6.x // improved shadow fadeout
    mul r6.x, r6.x, r6.x
    mul r6.x, r6.x, c1.z
    /* removed 1.0.6.0 filter
    mov r6.y, c53.y
    mad r6.zw, r6.y, c12.xyxy, r1.xyyz
    texld r7, r6.zwzw, s15
    add r6.z, r1.w, -r7.x
    cmp r6.z, r6.z, -c2.y, -c2.z
    mad r7.xy, r6.y, c12.zwzw, r1.yzzw
    texld r7, r7, s15
    add r6.w, r1.w, -r7.x
    cmp r6.w, r6.w, -c2.y, -c2.z
    add r6.z, r6.z, r6.w
    mad r7.xy, r6.y, c11, r1.yzzw
    texld r7, r7, s15
    add r6.w, r1.w, -r7.x
    cmp r6.w, r6.w, -c2.y, -c2.z
    add r6.z, r6.z, r6.w
    mad r7.xy, r6.y, c11.zwzw, r1.yzzw
    texld r7, r7, s15
    add r6.w, r1.w, -r7.x
    cmp r6.w, r6.w, -c2.y, -c2.z
    add r6.z, r6.z, r6.w
    mad r7.xy, r6.y, c10, r1.yzzw
    texld r7, r7, s15
    add r6.w, r1.w, -r7.x
    cmp r6.w, r6.w, -c2.y, -c2.z
    add r6.z, r6.z, r6.w
    mad r7.xy, r6.y, c10.zwzw, r1.yzzw
    texld r7, r7, s15
    add r6.w, r1.w, -r7.x
    cmp r6.w, r6.w, -c2.y, -c2.z
    add r6.z, r6.z, r6.w
    mad r7.xy, r6.y, c9, r1.yzzw
    texld r7, r7, s15
    add r6.w, r1.w, -r7.x
    cmp r6.w, r6.w, -c2.y, -c2.z
    add r6.z, r6.z, r6.w
    mad r7.xy, r6.y, c9.zwzw, r1.yzzw
    texld r7, r7, s15
    add r6.w, r1.w, -r7.x
    cmp r6.w, r6.w, -c2.y, -c2.z
    add r6.z, r6.z, r6.w
    mad r7.xy, r6.y, c8, r1.yzzw
    texld r7, r7, s15
    add r6.w, r1.w, -r7.x
    cmp r6.w, r6.w, -c2.y, -c2.z
    add r6.z, r6.z, r6.w
    mad r7.xy, r6.y, c8.zwzw, r1.yzzw
    texld r7, r7, s15
    add r6.w, r1.w, -r7.x
    cmp r6.w, r6.w, -c2.y, -c2.z
    add r6.z, r6.z, r6.w
    mad r7.xy, r6.y, c7, r1.yzzw
    texld r7, r7, s15
    add r6.w, r1.w, -r7.x
    cmp r6.w, r6.w, -c2.y, -c2.z
    add r6.z, r6.z, r6.w
    mad r1.yz, r6.y, c7.xzww, r1
    texld r7, r1.yzzw, s15
    add r1.y, r1.w, -r7.x
    cmp r1.y, r1.y, -c2.y, -c2.z
    add r1.y, r6.z, r1.y
    removed 1.0.6.0 filter */
	// ------------------------------------------------------------- Per Setting Tweaks -------------------------------------------------------------
	mov r20.x, c221.y
	if_eq r20.x, c117.w // High
		mov r23, c133
		mov r24, c134
		mov r27, c135
	else
	if_eq r20.x, c117.z // Medium
		mov r23, c136
		mov r24, c137
		mov r27, c138
	else
	if_eq r20.x, c117.y // Low
		mov r23, c139
		mov r24, c140
		mov r27, c141
	else                // Very High
		mov r23, c130
		mov r24, c131
		mov r27, c132
	endif
	endif
	endif
	// ----------------------------------------------------------------------------------------------------------------------------------------------
	// ------------------------------------------------------------- Per Cascade Tweaks -------------------------------------------------------------
    add r21.xyz, r1.y, -c116.xyz
    cmp r22.xy, r21.x, r23.yw, r23.xz
    cmp r22.xy, r21.y, r24.xz, r22.xy
    cmp r22.xy, r21.z, r24.yw, r22.xy	// r22.x = per cascade blur, r22.y = per cascade bias
	
	mov r20.xy, c119.xy					// static texel size instead of c53.xy
    mul r20.xy, r20.xy, r22.x			// reduce cascade blur disparity
	add r1.w, r1.w, -r22.y				// improve depth bias for 2nd, 3rd and 4th cascade
	// ----------------------------------------------------------------------------------------------------------------------------------------------
	// -------------------------------------------------------------- Filter Selection --------------------------------------------------------------
	mov r20.z, c223.y
    add r21.xyz, r20.z, -c117.yzw
    cmp r20.w, r21.x, c118.y, c118.x
    cmp r20.w, r21.y, c118.z, r20.w
    cmp r20.w, r21.z, c118.w, r20.w // "Sharp", "Soft", "Softer" & "Softest"
	
	if_gt r20.z, c117.w // "PCSS"
		mov r21.y, c110.w // blockers
	
		mul r22.xy, r22.xx, c115.xy // pcss texel step
	
		mov r23.xy, r22.xx // x - inner loop index, y - outer loop index
		mov r24.x, c110.w // sum
	
		rep i2
			mul r21.w, r23.y, c114.w
	
			rep i2
				mad r25.xy, c119.zw, r23.xy, r1.yz
				texldl r26, r25.xy, s15
	
				add r25.x, r26.x, -r1.w
	
				if_gt r25.x, r21.w
					min r25.x, r25.x, c114.x // < 49
					add r24.x, r24.x, r25.x
					add r21.y, r21.y, c110.y
				endif
	
				add r23.x, r23.x, r22.y // j++
			endrep
			add r23.y, r23.y, r22.y // i++
			mov r23.x, r22.x // j = -33
		endrep
	
		// avg if any blockers
		if_gt r21.y, c110.w
			rcp r21.y, r21.y
			mul r24.x, r24.x, r21.y
			rsq r24.x, r24.x
			rcp r24.x, r24.x
			max r20.w, r24.x, c114.z // minimum factor
		else
			mov r20.w, c114.z
		endif
	endif
	// ----------------------------------------------------------------------------------------------------------------------------------------------
	// ------------------------------------------------------------ Depth Based Blur ------------------------------------------------------------
	mov r20.z, c110.w
	add r21.x, r4.w, -r27.x
	mul_sat r21.x, r21.x, r27.y
	mul r21.x, r21.x, r21.x
	lrp r22.xy, r21.x, r27.zw, r20.wz // r22.x = blur factor, r22.y = bias factor
	
	mul r20.xy, r20.xy, r22.x
	add r1.w, r1.w, r22.y
	// ----------------------------------------------------------------------------------------------------------------------------------------------
	// ----------------------------------------------------------- 1.0.4.0 Shadow Filter ------------------------------------------------------------
    mov r21.xy, c112.xy
    dp2add r21.y, vPos, r21, c110.w		// v0.x * r21.x + v0.y * r21.y
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
		
		mad r24.xy, r23.xy, r20.xy, r1.yz	// offset * texel size + UV
		texld r24, r24, s15					// 1st sample
		mov r25.x, r24.x					// copy to r25
		mad r24.xy, r21.zw, r20.xy, r1.yz	// offset * texel size + UV
		texld r24, r24, s15					// 2nd sample
		mov r25.y, r24.x					// copy to r25
		mad r24.xy, r21.xy, r20.xy, r1.yz	// offset * texel size + UV
		texld r24, r24, s15					// 3rd sample
		mov r25.z, r24.x					// copy to r25
		mad r24.xy, r23.zw, r20.xy, r1.yz	// offset * texel size + UV
		texld r24, r24, s15					// 4th sample
		mov r25.w, r24.x					// copy to r25
	
		add r25, r1.w, -r25					// depth bias
		cmp r25, r25, c110.y, c110.w
		dp4 r20.w, r25, -c110.x				// average samples of current iteration
		add r20.z, r20.z, r20.w
		
		add r26, r26, c110.zzyz				// add (-1, -1, 1, -1)
		add r27, r27, -c110.zzyz			// add (1, 1, -1, 1)
	endrep
	
	mul r1.y, r20.z, c112.w					// average all iterations
	// ----------------------------------------------------------------------------------------------------------------------------------------------
    add r1.y, r1.y, r6.x // mad r1.y, r1.y, c1.w, r6.x 1.0.6.0 filter average
    add r1.z, r4.w, -c53.w
    cmp r1.zw, r1.z, c6.xyxy, c6
    add r1.w, r1.y, r1.w
    cmp_sat r1.y, r1.w, r1.y, r1.z
    mul r6.xyz, r4, r3.w
    mul r6.xyz, r1.y, r6
    mul r4.xyz, r4, r0.w
    mul r1.yzw, r1.y, r4.xxyz
    mad r0.xyz, r0, v3.x, r1.yzww
    mul r0.w, r2.w, c4.w
    add r4, c19, -v4.x
    add r7, c20, -v4.y
    add r8, c21, -v4.z
    mul r9, r4, r4
    mad r9, r7, r7, r9
    mad r9, r8, r8, r9
    add r10, r9, c2.w
    rsq r11.x, r10.x
    rsq r11.y, r10.y
    rsq r11.z, r10.z
    rsq r11.w, r10.w
    mov r1.y, c2.y
    mad r9, r9, -c25, -r1.y
    max r10, r9, c2.x
    mul r9, r10, r10
    mad r9, r9, r9, c3.x
    mul r10, r9, c3.y
    cmp r9, r9, r10, c2.x
    mul r10, r2.x, r4
    mad r10, r7, r2.y, r10
    mad r2, r8, r2.z, r10
    mul r2, r9, r2
    mul_sat r2, r11, r2
    mul r9, r4, -c22
    mad r9, r7, -c23, r9
    mad r9, r8, -c24, r9
    mul r9, r11, r9
    mov r10, c26
    mad_sat r9, r9, r10, c27
    mul r2, r2, r9
    mul r4, r3.x, r4
    mad r4, r3.y, r7, r4
    mad r3, r3.z, r8, r4
    mul r3, r11, r3
    log r4.x, r3_abs.x
    log r4.y, r3_abs.y
    log r4.z, r3_abs.z
    log r4.w, r3_abs.w
    mul r3, r0.w, r4
    exp r4.x, r3.x
    exp r4.y, r3.y
    exp r4.z, r3.z
    exp r4.w, r3.w
    mul r3, r2, r4
    dp4 r4.x, c29, r2
    dp4 r4.y, c30, r2
    dp4 r4.z, c31, r2
    dp4 r2.x, c29, r3
    dp4 r2.y, c30, r3
    dp4 r2.z, c31, r3
    add r0.xyz, r0, r4
    mad r2.xyz, r6, c17.w, r2
    mov r0.w, -c2.y
    mul r0, r5, r0
    mad r0.xyz, r1.x, r2, r0
    mul oC0.w, r0.w, c39.x
    add r0.w, c16.w, -v1.w
    add r1.x, -c16.z, c16.w
    rcp r1.x, r1.x
    mul_sat r0.w, r0.w, r1.x
    add r0.w, -r0.w, -c2.y
    add r1.xy, r1.y, c16
    mul r1.y, r0.w, r1.y
    mad r0.w, r0.w, r1.x, -c2.y
    dp3 r1.x, r0, c5
    lrp r2.xyz, r0.w, r0, r1.x
    add r0.x, r1.x, c3.z
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

// approximately 235 instruction slots used (17 texture, 218 arithmetic)
