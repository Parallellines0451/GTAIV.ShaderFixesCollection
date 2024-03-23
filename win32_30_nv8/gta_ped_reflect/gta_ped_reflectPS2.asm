// Summary: removed unnecessary stipple + console-like ambient reflection intensity + improved shadow filter + added PCSS thanks to robi29 + improved shadow fadeout
// Generated by Microsoft (R) HLSL Shader Compiler 9.26.952.2844
//
// Parameters:
//
//   sampler2D BumpSampler;
//   sampler2D EnvironmentSampler;
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
//   float4 matMaterialColorScale;
//   float reflectivePower;
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
//   gLightPosX               c19      1
//   gLightPosY               c20      1
//   gLightPosZ               c21      1
//   gLightDirX               c22      1
//   gLightDirY               c23      1
//   gLightDirZ               c24      1
//   gLightFallOff            c25      1
//   gLightConeScale          c26      1
//   gLightConeOffset         c27      1
//   gLightColR               c29      1
//   gLightColG               c30      1
//   gLightColB               c31      1
//   gLightPointPosX          c32      1
//   gLightPointPosY          c33      1
//   gLightPointPosZ          c34      1
//   gLightPointColR          c35      1
//   gLightPointFallOff       c36      1
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
//   gLightPointColG          c64      1
//   gLightPointColB          c65      1
//   matMaterialColorScale    c66      1
//   gLightDir2X              c67      1
//   gLightDir2Y              c68      1
//   gLightDir2Z              c69      1
//   gLightConeScale2         c70      1
//   gLightConeOffset2        c71      1
//   reflectivePower          c72      1
//   specularFactor           c73      1
//   specularColorFactor      c74      1
//   specMapIntMask           c75      1
//   bumpiness                c76      1
//   TextureSampler           s0       1
//   EnvironmentSampler       s1       1
//   damageTextureSampler     s2       1
//   damageSpecTextureSampler s4       1
//   BumpSampler              s5       1
//   SpecSampler              s6       1
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
    def c219, 1.8395173895e+25, 3.9938258725e+24, 4.5435787456e+30, 6.6141287516e-43 // 472
    def c127, 0.9999999, 1, 0, 0	// LogDepth constants
    def c0, 4, 0.125, 0.25, -0.5
    def c1, 9.99999975e-006, -0.5, 0.5, 1.33333337
    def c2, 0, 1, 0.333333343, 3.99600005
    def c3, 9.99999975e-005, 1.5, -0.326211989, -0.405809999
    def c4, -0.791558981, -0.597710013, 0.0833333358, -0.100000001
    def c5, 1.11111116, 0.212500006, 0.715399981, 0.0720999986
    def c6, 1.00000001e-007, 0, 0, 0
    def c7, 1, -1, 0, -0
    def c8, 0.896420002, 0.412458003, -0.321940005, -0.932614982
    def c9, 0.185461, -0.893123984, 0.507430971, 0.0644249991
    def c10, 0.473434001, -0.480026007, 0.519456029, 0.767022014
    def c11, -0.203345001, 0.620715976, 0.962339997, -0.194983006
    def c12, -0.840143979, -0.0735799968, -0.69591397, 0.457136989
	def c100, 1.6666667, 0, 0, 0	// Reflection intensity multiplier
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
    dcl_2d s6
    dcl_2d s10
    dcl_2d s15
    texld r0, v0, s0
    texld r1, v0, s6
    mul r1.w, r1.w, c73.x
    dp3 r1.x, r1, c75
    mul r1.x, r1.x, c74.x
    if_lt -v6.x, c2.x
      texld r2, v0, s2
      if_lt -r2.w, c2.x
        texld r3, v0, s4
        add r1.y, c2.y, -v6.x
        mul r1.z, r3.w, c73.x
        lrp r3.w, v6.x, r1.z, r1.w
        add r1.z, r3.y, r3.x
        add r1.z, r3.z, r1.z
        mul r1.z, r1.z, v6.x
        mul r1.z, r1.z, c74.x
        mul r1.z, r1.z, c2.z
        mad r1.y, r1.y, r1.x, r1.z
        mad r1.z, r2.w, -v6.x, c2.y
        mul r2.xyz, r2.w, r2
        mul r2.xyz, r2, v6.x
        mad r0.xyz, r0, r1.z, r2
        mov r1.w, r3.w
      else
        mov r1.yw, r1.xxzw
      endif
    else
      mov r1.yw, r1.xxzw
    endif
    /* removed stipple
    mov_sat r1.z, c39.x
    mul r1.z, r1.z, c2.w
    frc r2.x, r1.z
    mul r2.y, r2.x, c0.x
    frc r2.z, r2.y
    add r3.x, r2.y, -r2.z
    add r3.y, r1.z, -r2.x
    mul r2.xy, c0.y, vPos
    frc r2.xy, r2_abs
    cmp r2.xy, vPos, r2, -r2
    mul r2.xy, r2, c0.z
    mad r2.xy, r3, c0.z, r2
    mov r2.zw, c2.x
    texldl r2, r2, s10
    cmp r2, -r2.y, -c2.y, -c2.x
    texkill r2
    removed stipple */
    texld r2, v0, s5
    add r1.z, -r2.w, c2.y
    add r1.z, -r2.x, r1.z
    cmp r2.xy, r1.z, r2.wyzw, r2
    add r2.zw, r2.xyxy, c0.w
    mul r2.zw, r2, c76.x
    dp2add r1.z, r2, -r2, c2.y
    rsq r1.z, r1.z
    rcp r1.z, r1.z
    mul r2.xyz, r2.z, v3
    mad r2.xyz, v1, r1.z, r2
    mad r2.xyz, r2.w, v4, r2
    add r2.xyz, r2, c1.x
    nrm r3.xyz, r2
    add r2.xyz, c1.x, v2
    nrm r4.xyz, r2
    dp3 r1.z, -r4, r3
    add r1.z, r1.z, r1.z
    mad r2.xyz, r3, -r1.z, -r4
    add r4.xyz, r2, c1.x
    dp3 r1.z, r4, r4
    rsq r1.z, r1.z
    mad r4.xy, r4.xzzw, r1.z, c2.y
    mul r4.xy, r4, c0.w
    texld r4, r4, s1
	mul r4, r4, c100.x
    texld r5, v0, s1
    mul r4.xyz, r4, r5.w
    mul r4.xyz, r1.x, r4
    mul r5.w, r0.w, v5.w
    mad r5.xyz, r4, c72.x, r0
    mad_sat r0.x, r3.z, c1.y, c1.z
    mov r4.xyz, c38
    mad r0.xyz, r4, r0.x, c37
    mul r4.xyz, c18.w, c18
    dp3 r0.w, r3, -c17
    add r0.w, r0.w, -c0.z
    mul_sat r0.w, r0.w, c1.w
    dp3_sat r1.x, -c17, r2
    add r1.x, r1.x, c3.x
    add r1.z, r1.w, c3.x
    pow r2.w, r1.x, r1.z
    mul r6.xyz, c61.xyww, v7.y
    mad r6.xyz, v7.x, c60.xyww, r6
    mad r6.xyz, v7.z, c62.xyww, r6
    add r6.xyz, r6, c63.xyww
    dp3 r1.x, c14, v7
    add r7.xyz, -r1.x, -c54
    cmp r7.yzw, r7.xxyz, c2.y, c2.x
	// ---------------------------------------------------------------- Cascade Mask ----------------------------------------------------------------
	mov r21.x, c110.y
	mov r21.yzw, r7
	add r21.xyz, r21.xyz, -r21.yzw
	// ----------------------------------------------------------------------------------------------------------------------------------------------
    mov r7.x, c2.y
    dp4 r8.x, r7, c57
    dp4 r8.y, r7, c58
    dp4 r9.x, r7, c59
    dp4 r9.y, r7, c56
    mad r1.xz, r6.xyyw, r8.xyyw, r9.xyyw
    add r6.xyw, c15.xyzz, -v7.xyzz
    dp3 r3.w, r6.xyww, r6.xyww
    rsq r3.w, r3.w
    rcp r3.w, r3.w
    rcp r4.w, c53.w
    mul r4.w, r3.w, r4.w
    mul r4.w, r4.w, r4.w // improved shadow fadeout
    mul r4.w, r4.w, r4.w
    mul r4.w, r4.w, c3.y
    /* removed 1.0.6.0 filter
    mov r6.y, c53.y
    mad r6.xw, r6.y, c3.zyzw, r1.xyzz
    texld r7, r6.xwzw, s15
    add r6.x, r6.z, -r7.x
    cmp r6.x, r6.x, c2.y, c2.x
    mad r7.xy, r6.y, c12, r1.xzzw
    texld r7, r7, s15
    add r6.w, r6.z, -r7.x
    cmp r6.w, r6.w, c2.y, c2.x
    add r6.x, r6.x, r6.w
    mad r7.xy, r6.y, c12.zwzw, r1.xzzw
    texld r7, r7, s15
    add r6.w, r6.z, -r7.x
    cmp r6.w, r6.w, c2.y, c2.x
    add r6.x, r6.x, r6.w
    mad r7.xy, r6.y, c11, r1.xzzw
    texld r7, r7, s15
    add r6.w, r6.z, -r7.x
    cmp r6.w, r6.w, c2.y, c2.x
    add r6.x, r6.x, r6.w
    mad r7.xy, r6.y, c11.zwzw, r1.xzzw
    texld r7, r7, s15
    add r6.w, r6.z, -r7.x
    cmp r6.w, r6.w, c2.y, c2.x
    add r6.x, r6.x, r6.w
    mad r7.xy, r6.y, c10, r1.xzzw
    texld r7, r7, s15
    add r6.w, r6.z, -r7.x
    cmp r6.w, r6.w, c2.y, c2.x
    add r6.x, r6.x, r6.w
    mad r7.xy, r6.y, c10.zwzw, r1.xzzw
    texld r7, r7, s15
    add r6.w, r6.z, -r7.x
    cmp r6.w, r6.w, c2.y, c2.x
    add r6.x, r6.x, r6.w
    mad r7.xy, r6.y, c9, r1.xzzw
    texld r7, r7, s15
    add r6.w, r6.z, -r7.x
    cmp r6.w, r6.w, c2.y, c2.x
    add r6.x, r6.x, r6.w
    mad r7.xy, r6.y, c9.zwzw, r1.xzzw
    texld r7, r7, s15
    add r6.w, r6.z, -r7.x
    cmp r6.w, r6.w, c2.y, c2.x
    add r6.x, r6.x, r6.w
    mad r7.xy, r6.y, c8, r1.xzzw
    texld r7, r7, s15
    add r6.w, r6.z, -r7.x
    cmp r6.w, r6.w, c2.y, c2.x
    add r6.x, r6.x, r6.w
    mad r7.xy, r6.y, c8.zwzw, r1.xzzw
    texld r7, r7, s15
    add r6.w, r6.z, -r7.x
    cmp r6.w, r6.w, c2.y, c2.x
    add r6.x, r6.x, r6.w
    mad r1.xz, r6.y, c4.xyyw, r1
    texld r7, r1.xzzw, s15
    add r1.x, r6.z, -r7.x
    cmp r1.x, r1.x, c2.y, c2.x
    add r1.x, r6.x, r1.x
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
	add r6.z, r6.z, -r20.w // apply per cascade bias
	if_ne r24.z, c223.y // PCSS
		mov r24.xyw, c110.w // sum
		mul r25.xy, r20.z, c124.xy // pcss texel step
		mov r25.zw, r25.x // x - inner loop index, y - outer loop index
		rep i1
			mul r24.z, r25.w, c124.z
			rep i1
				mad r26.xy, c53.xy, r25.zw, r1.xz
				texldl r27, r26.xy, s15
				add r26.x, r27.x, -r6.z
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
	add r22.x, r3.w, -r22.x
	add r22.y, c54.z, -c54.x
	rcp r22.y, r22.y
	mul_sat r22.x, r22.x, r22.y
	mul r22.x, r22.x, r22.x
	mul r22.y, r23.x, c53.w
	mov r22.z, c123.x
	lrp r23.xy, r22.x, r22.yz, r24.xy
	mul r20.xy, r20.xy, r23.x // apply depth based blur
	add r6.z, r6.z, r23.y // apply depth based bias
	
    mov r21.xy, c112.xy
    dp2add r21.y, vPos, r21, c110.w		// v0.x * r21.x + v0.y * r21.y
    mad r21.y, r21.y, c111.x, c111.y
    frc r21.y, r21.y
    mad r21.y, r21.y, c111.z, c111.w	// r21.y * 2pi - pi
    sincos r22.xy, r21.y				// cosine & sine of r21.y
    mul r23, r22.yxxy, c110.xxyz		// offsets for 1st and 4th samples, respectively
    mul r21, r22.yxxy, c113.xxyz        // offsets for 3rd and 2nd samples, respectively
	mul r20.xy, r20.xy, c221.w			// compensate for FixCascadedShadowMapResolution
	
    mad r24.xy, r23.xy, r20.xy, r1.xz	// offset * texel size + UV
    texld r24, r24, s15					// 1st sample
    mov r25.x, r24.x					// copy to r25
    mad r24.xy, r21.zw, r20.xy, r1.xz	// offset * texel size + UV
    texld r24, r24, s15					// 2nd sample
    mov r25.y, r24.x					// copy to r25
    mad r24.xy, r21.xy, r20.xy, r1.xz	// offset * texel size + UV
    texld r24, r24, s15					// 3rd sample
    mov r25.z, r24.x					// copy to r25
    mad r24.xy, r23.zw, r20.xy, r1.xz	// offset * texel size + UV
    texld r24, r24, s15					// 4th sample
    mov r25.w, r24.x					// copy to r25
	add r25, r6.z, -r25					// depth bias
	cmp r25, r25, c110.y, c110.w
	dp4 r26.x, r25, -c110.x				// average
	
    mul r23, r22.yxxy, c114.xxyz		// offsets for 5th and 8th samples, respectively
    mul r21, r22.yxxy, c115.xxyz        // offsets for 7th and 6th samples, respectively
	
    mad r24.xy, r23.xy, r20.xy, r1.xz	// offset * texel size + UV
    texld r24, r24, s15					// 5th sample
    mov r25.x, r24.x					// copy to r25
    mad r24.xy, r21.zw, r20.xy, r1.xz	// offset * texel size + UV
    texld r24, r24, s15					// 6th sample
    mov r25.y, r24.x					// copy to r25
    mad r24.xy, r21.xy, r20.xy, r1.xz	// offset * texel size + UV
    texld r24, r24, s15					// 7th sample
    mov r25.z, r24.x					// copy to r25
    mad r24.xy, r23.zw, r20.xy, r1.xz	// offset * texel size + UV
    texld r24, r24, s15					// 8th sample
    mov r25.w, r24.x					// copy to r25
	add r25, r6.z, -r25					// depth bias
	cmp r25, r25, c110.y, c110.w
	dp4 r26.y, r25, -c110.x				// average
	
    mul r23, r22.yxxy, c116.xxyz		// offsets for 9th and 12th samples, respectively
    mul r21, r22.yxxy, c117.xxyz        // offsets for 11th and 10th samples, respectively
	
    mad r24.xy, r23.xy, r20.xy, r1.xz	// offset * texel size + UV
    texld r24, r24, s15					// 9th sample
    mov r25.x, r24.x					// copy to r25
    mad r24.xy, r21.zw, r20.xy, r1.xz	// offset * texel size + UV
    texld r24, r24, s15					// 10th sample
    mov r25.y, r24.x					// copy to r25
    mad r24.xy, r21.xy, r20.xy, r1.xz	// offset * texel size + UV
    texld r24, r24, s15					// 11th sample
    mov r25.z, r24.x					// copy to r25
    mad r24.xy, r23.zw, r20.xy, r1.xz	// offset * texel size + UV
    texld r24, r24, s15					// 12th sample
    mov r25.w, r24.x					// copy to r25
	add r25, r6.z, -r25					// depth bias
	cmp r25, r25, c110.y, c110.w
	dp4 r26.z, r25, -c110.x				// average
	
	dp3 r1.x, r26, c112.w
	// ----------------------------------------------------------------------------------------------------------------------------------------------
    add r1.x, r1.x, r4.w // mad r1.x, r1.x, c4.z, r4.w 1.0.6.0 filter average
    add r1.z, r3.w, -c53.w
    cmp r6.xy, r1.z, c7, c7.zwzw
    add r1.z, r1.x, r6.y
    cmp_sat r1.x, r1.z, r1.x, r6.x
    mul r6.xyz, r4, r2.w
    mul r6.xyz, r1.x, r6
    mul r4.xyz, r4, r0.w
    mul r4.xyz, r1.x, r4
    mad r0.xyz, r0, v5.x, r4
    mul r0.w, r1.w, c0.z
    add r4, c19, -v7.x
    add r7, c20, -v7.y
    add r8, c21, -v7.z
    mul r9, r4, r4
    mad r9, r7, r7, r9
    mad r9, r8, r8, r9
    add r10, r9, c1.x
    rsq r11.x, r10.x
    rsq r11.y, r10.y
    rsq r11.z, r10.z
    rsq r11.w, r10.w
    mov r10.y, c2.y
    mad r9, r9, -c25, r10.y
    max r12, r9, c2.x
    mul r9, r12, r12
    mad r9, r9, r9, c4.w
    mul r12, r9, c5.x
    cmp r9, r9, r12, c2.x
    mul r12, r3.x, r4
    mad r12, r7, r3.y, r12
    mad r12, r8, r3.z, r12
    mul r9, r9, r12
    mul_sat r9, r11, r9
    mul r12, r4, -c22
    mad r12, r7, -c23, r12
    mad r12, r8, -c24, r12
    mul r12, r11, r12
    mov r13, c26
    mad_sat r12, r12, r13, c27
    mul r9, r9, r12
    mul r4, r2.x, r4
    mad r4, r2.y, r7, r4
    mad r4, r2.z, r8, r4
    mul r4, r11, r4
    log r7.x, r4_abs.x
    log r7.y, r4_abs.y
    log r7.z, r4_abs.z
    log r7.w, r4_abs.w
    mul r4, r0.w, r7
    exp r7.x, r4.x
    exp r7.y, r4.y
    exp r7.z, r4.z
    exp r7.w, r4.w
    mul r4, r9, r7
    dp4 r7.x, c29, r9
    dp4 r7.y, c30, r9
    dp4 r7.z, c31, r9
    dp4 r8.x, c29, r4
    dp4 r8.y, c30, r4
    dp4 r8.z, c31, r4
    add r0.xyz, r0, r7
    mad r1.xzw, r6.xyyz, c17.w, r8.xyyz
    add r4, c32, -v7.x
    add r6, c33, -v7.y
    add r7, c34, -v7.z
    mul r8, r4, r4
    mad r8, r6, r6, r8
    mad r8, r7, r7, r8
    add r9, r8, c1.x
    rsq r11.x, r9.x
    rsq r11.y, r9.y
    rsq r11.z, r9.z
    rsq r11.w, r9.w
    mad r8, r8, -c36, r10.y
    max r9, r8, c2.x
    mul r8, r9, r9
    mad r8, r8, r8, c4.w
    mul r9, r8, c5.x
    cmp r8, r8, r9, c2.x
    mul r9, r3.x, r4
    mad r9, r6, r3.y, r9
    mad r3, r7, r3.z, r9
    mul r3, r8, r3
    mul_sat r3, r11, r3
    mul r8, r4, -c67
    mad r8, r6, -c68, r8
    mad r8, r7, -c69, r8
    mul r8, r11, r8
    mov r9, c70
    mad_sat r8, r8, r9, c71
    mul r3, r3, r8
    mul r4, r2.x, r4
    mad r4, r2.y, r6, r4
    mad r2, r2.z, r7, r4
    mul r2, r11, r2
    log r4.x, r2_abs.x
    log r4.y, r2_abs.y
    log r4.z, r2_abs.z
    log r4.w, r2_abs.w
    mul r2, r0.w, r4
    exp r4.x, r2.x
    exp r4.y, r2.y
    exp r4.z, r2.z
    exp r4.w, r2.w
    mul r2, r3, r4
    dp4 r4.x, c35, r3
    dp4 r4.y, c64, r3
    dp4 r4.z, c65, r3
    dp4 r3.x, c35, r2
    dp4 r3.y, c64, r2
    dp4 r3.z, c65, r2
    add r0.xyz, r0, r4
    add r1.xzw, r1, r3.xyyz
    mov r0.w, c2.y
    mul r0, r5, r0
    mad r0.xyz, r1.y, r1.xzww, r0
    mul oC0.w, r0.w, c39.x
    add r0.w, c16.w, -v1.w
    add r1.x, -c16.z, c16.w
    rcp r1.x, r1.x
    mul_sat r0.w, r0.w, r1.x
    add r0.w, -r0.w, c2.y
    add r1.xy, -r10.y, c16
    mul r1.y, r0.w, r1.y
    mad r0.w, r0.w, r1.x, c2.y
    dp3 r1.x, r0, c5.yzww
    lrp r2.xyz, r0.w, r0, r1.x
    add r0.x, r1.x, c6.x
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
    mad r0.xyz, r0.w, r1, r0
    mul oC0.xyz, r0, c66.x
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

// approximately 326 instruction slots used (21 texture, 305 arithmetic)
