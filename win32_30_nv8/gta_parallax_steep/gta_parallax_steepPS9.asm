// 256 state stipple + removed unnecessary stipple
// Generated by Microsoft (R) HLSL Shader Compiler 9.26.952.2844
//
// Parameters:
//
//   sampler2D BumpSampler;
//   sampler2D StippleTexture;
//   sampler2D TextureSampler;
//   float bumpiness;
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
//   float parallaxScaleBias;
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
//   parallaxScaleBias    c66      1
//   specularFactor       c72      1
//   specularColorFactor  c73      1
//   bumpiness            c74      1
//   TextureSampler       s0       1
//   BumpSampler          s1       1
//   StippleTexture       s10      1
//   gShadowZSamplerDir   s15      1
//

    ps_3_0
	// ------------------------------------------------------ 1.0.4.0 Shadow Filter Constants -------------------------------------------------------
    def c110, -0.25, 1, -1, 0
    def c111, 0.159154937, 0.5, 6.28318548, -3.14159274
    def c112, 3, 7.13800001, 0, 0
    def c113, 0.75, -0.5, 0.5, 0
	// ----------------------------------------------------------------------------------------------------------------------------------------------
    def c219, 1.8395173895e+25, 3.9938258725e+24, 4.5435787456e+30, 6.3899209973e-43 // 456
    def c150, 15.996, 16, 0.0625, 0.0625	// 256 state stipple constants
    def c127, 0.9999999, 1, 0, 0	// LogDepth constants
    def c0, 9.99999975e-006, 0, 1, -0.125
    def c1, -1, -0, -0.5, -0.00200000009
    def c2, -0.5, 0.5, 1.33333337, 9.99999975e-005
    def c3, 1.5, -0.326211989, -0.405809999, 1
    def c4, 0.212500006, 0.715399981, 0.0720999986, 0
    def c5, -0.791558981, -0.597710013, 1.00000001e-007, 0
    def c6, 3.99600005, 4, 0.25, 0
    def c7, 0.896420002, 0.412458003, -0.321940005, -0.932614982
    def c8, 0.185461, -0.893123984, 0.507430971, 0.0644249991
    def c9, 0.473434001, -0.480026007, 0.519456029, 0.767022014
    def c10, -0.203345001, 0.620715976, 0.962339997, -0.194983006
    def c11, -0.840143979, -0.0735799968, -0.69591397, 0.457136989
    def c12, 1, -1, 0, -0
    defi i0, 8, 0, 0, 0
    dcl_texcoord v0.xy
    dcl_texcoord1 v1
    dcl_texcoord3 v2.xyz
    dcl_texcoord4 v3.xyz
    dcl_texcoord5 v4.xyz
    dcl_color v5.xw
    dcl_texcoord6 v6.xyz
    dcl_texcoord7 v7.xyz
    dcl vPos.xy
    dcl_texcoord9 v9
    dcl_2d s0
    dcl_2d s1
    dcl_2d s10
    dcl_2d s15
    texld r0, v0, s1
    add r1.xyz, c0.x, v7
    dp3 r0.z, r1, r1
    rsq r0.z, r0.z
    mul r1.xy, r1, r0.z
    mul r1.xy, -r1, c66.x
    mov r1.zw, v0.xyxy
    mov r2.yz, r0.xxyw
    mov r2.x, c0.z
    mov r2.w, r0.w
    rep i0
      add r0.z, -r2.x, r2.w
      add r3.x, r2.x, c0.w
      mad r4.xy, r1, -c0.w, r1.zwzw
      texld r5, r4, s1
      cmp r1.zw, r0.z, r1, r4.xyxy
      mov r3.yzw, r5.xxyw
      cmp r2, r0.z, r2, r3
    endrep
    /* removed stipple
    mov_sat r0.x, c39.x
    mul r0.x, r0.x, c150.x
    frc r0.y, r0.x
    mul r0.z, r0.y, c150.y
    frc r0.w, r0.z
    add r1.xy, r0.zxzw, -r0.wyzw
    mul r0.xy, c150.z, vPos
    frc r0.xy, r0_abs
    cmp r0.xy, vPos, r0, -r0
    mul r0.xy, r0, c150.w
    mad r0.xy, r1, c150.w, r0
    mov r0.zw, c6.w
    texldl r0, r0, s10
    cmp r0, -r0.x, c1.x, c1.y
    texkill r0
    removed stipple */
    texld r0, r1.zwzw, s0
    add r1.xy, r2.yzzw, c1.z
    mul r1.xy, r1, c74.x
    dp2add r1.z, r2.yzzw, -r2.yzzw, c0.z
    rsq r1.z, r1.z
    rcp r1.z, r1.z
    mul r3.xyz, r1.x, v3
    mad r1.xzw, v1.xyyz, r1.z, r3.xyyz
    mad r1.xyz, r1.y, v4, r1.xzww
    add r1.xyz, r1, c0.x
    nrm r3.xyz, r1
    dp2add r1.x, r2.yzzw, r2.yzzw, c1.w
    cmp r1.x, r1.x, -c1.x, -c1.y
    mul r2.xyz, r0, r1.x
    mul r0.x, r1.x, v5.x
    mul r0.y, r1.x, c73.x
    mul r2.w, r0.w, v5.w
    add r1.xyz, c0.x, v2
    nrm r4.xyz, r1
    mad_sat r0.z, r3.z, c2.x, c2.y
    mov r1.xyz, c38
    mad r1.xyz, r1, r0.z, c37
    dp3 r0.z, -r4, r3
    add r0.z, r0.z, r0.z
    mad r4.xyz, r3, -r0.z, -r4
    mul r5.xyz, c18.w, c18
    dp3 r0.z, r3, -c17
    add r0.z, r0.z, -c6.z
    mul_sat r0.z, r0.z, c2.z
    dp3_sat r0.w, -c17, r4
    add r0.w, r0.w, c2.w
    mov r1.w, c2.w
    add r1.w, r1.w, c72.x
    pow r3.x, r0.w, r1.w
    mul r3.yzw, c61.xxyw, v6.y
    mad r3.yzw, v6.x, c60.xxyw, r3
    mad r3.yzw, v6.z, c62.xxyw, r3
    add r3.yzw, r3, c63.xxyw
    dp3 r0.w, c14, v6
    add r4.xyz, -r0.w, -c54
    cmp r4.yzw, r4.xxyz, -c1.x, -c1.y
    mov r4.x, c0.z
    dp4 r6.x, r4, c57
    dp4 r6.y, r4, c58
    dp4 r7.x, r4, c59
    dp4 r7.y, r4, c56
    mad r3.yz, r3, r6.xxyw, r7.xxyw
    add r4.xyz, c15, -v6
    dp3 r0.w, r4, r4
    rsq r0.w, r0.w
    rcp r0.w, r0.w
    rcp r1.w, c53.w
    mul r1.w, r0.w, r1.w
    mul r1.w, r1.w, r1.w
    mul r1.w, r1.w, c3.x
    /* removed 1.0.6.0 filter
    mov r4.y, c53.y
    mad r4.xz, r4.y, c3.yyzw, r3.yyzw
    texld r6, r4.xzzw, s15
    add r4.x, r3.w, -r6.x
    cmp r4.x, r4.x, -c1.x, -c1.y
    mad r4.zw, r4.y, c11.xyxy, r3.xyyz
    texld r6, r4.zwzw, s15
    add r4.z, r3.w, -r6.x
    cmp r4.z, r4.z, -c1.x, -c1.y
    add r4.x, r4.x, r4.z
    mad r4.zw, r4.y, c11, r3.xyyz
    texld r6, r4.zwzw, s15
    add r4.z, r3.w, -r6.x
    cmp r4.z, r4.z, -c1.x, -c1.y
    add r4.x, r4.x, r4.z
    mad r4.zw, r4.y, c10.xyxy, r3.xyyz
    texld r6, r4.zwzw, s15
    add r4.z, r3.w, -r6.x
    cmp r4.z, r4.z, -c1.x, -c1.y
    add r4.x, r4.x, r4.z
    mad r4.zw, r4.y, c10, r3.xyyz
    texld r6, r4.zwzw, s15
    add r4.z, r3.w, -r6.x
    cmp r4.z, r4.z, -c1.x, -c1.y
    add r4.x, r4.x, r4.z
    mad r4.zw, r4.y, c9.xyxy, r3.xyyz
    texld r6, r4.zwzw, s15
    add r4.z, r3.w, -r6.x
    cmp r4.z, r4.z, -c1.x, -c1.y
    add r4.x, r4.x, r4.z
    mad r4.zw, r4.y, c9, r3.xyyz
    texld r6, r4.zwzw, s15
    add r4.z, r3.w, -r6.x
    cmp r4.z, r4.z, -c1.x, -c1.y
    add r4.x, r4.x, r4.z
    mad r4.zw, r4.y, c8.xyxy, r3.xyyz
    texld r6, r4.zwzw, s15
    add r4.z, r3.w, -r6.x
    cmp r4.z, r4.z, -c1.x, -c1.y
    add r4.x, r4.x, r4.z
    mad r4.zw, r4.y, c8, r3.xyyz
    texld r6, r4.zwzw, s15
    add r4.z, r3.w, -r6.x
    cmp r4.z, r4.z, -c1.x, -c1.y
    add r4.x, r4.x, r4.z
    mad r4.zw, r4.y, c7.xyxy, r3.xyyz
    texld r6, r4.zwzw, s15
    add r4.z, r3.w, -r6.x
    cmp r4.z, r4.z, -c1.x, -c1.y
    add r4.x, r4.x, r4.z
    mad r4.zw, r4.y, c7, r3.xyyz
    texld r6, r4.zwzw, s15
    add r4.z, r3.w, -r6.x
    cmp r4.z, r4.z, -c1.x, -c1.y
    add r4.x, r4.x, r4.z
    mad r3.yz, r4.y, c5.xxyw, r3
    texld r6, r3.yzzw, s15
    add r3.y, r3.w, -r6.x
    cmp r3.y, r3.y, -c1.x, -c1.y
    add r3.y, r4.x, r3.y
    removed 1.0.6.0 filter */
	// ----------------------------------------------------------- 1.0.4.0 Shadow Filter ------------------------------------------------------------
    mov r21.xy, c112.xy
    mul r21.xy, r21.xy, c44.xy			// r21.xy * screen dimensions
    dp2add r21.y, v0, r21, c110.w		// v0.x * r21.x + v0.y * r21.y
    mad r21.y, r21.y, c111.x, c111.y
    frc r21.y, r21.y
    mad r21.y, r21.y, c111.z, c111.w	// r21.y * 2pi - pi
    sincos r22.xy, r21.y				// sine & cosine of r21.y
    mul r23, r22.yxxy, c110.xxyz
    mul r22, r22.yxxy, c113.xxyz
	mov r20.xy, c53.xy					// copy texel size
	mul r20.xy, r20.xy, c112.x			// blur factor
	
    mad r24.xy, r23.xy, r20.xy, r3.yz	// offset * texel size + UV
    texld r24, r24, s15					// sample #1
    mov r25.x, r24.x					// copy to r25
    mad r24.xy, r22.zw, r20.xy, r3.yz	// offset * texel size + UV
    texld r24, r24, s15					// sample #2
    mov r25.y, r24.x					// copy to r25
    mad r24.xy, r22.xy, r20.xy, r3.yz	// offset * texel size + UV
    texld r24, r24, s15					// sample #3
    mov r25.z, r24.x					// copy to r25
    mad r24.xy, r23.zw, r20.xy, r3.yz	// offset * texel size + UV
    texld r24, r24, s15					// sample #4
    mov r25.w, r24.x					// copy to r25

	add r25, r3.w, -r25					// depth bias
	cmp r25, r25, c110.y, c110.w
	dp4 r3.y, r25, -c110.x				// average
	// ----------------------------------------------------------------------------------------------------------------------------------------------
    mad r1.w, r3.y, c3.w, r1.w
    add r0.w, r0.w, -c53.w
    cmp r3.yz, r0.w, c12.xxyw, c12.xzww
    add r0.w, r1.w, r3.z
    cmp_sat r0.w, r0.w, r1.w, r3.y
    mul r3.xyz, r5, r3.x
    mul r3.xyz, r0.w, r3
    mul r4.xyz, r5, r0.z
    mul r4.xyz, r0.w, r4
    mul r3.xyz, r3, c17.w
    mad r1.xyz, r1, r0.x, r4
    mov r1.w, c0.z
    mul r1, r2, r1
    mad r0.xyz, r0.y, r3, r1
    mul oC0.w, r1.w, c39.x
    add r0.w, c16.w, -v1.w
    add r1.x, -c16.z, c16.w
    rcp r1.x, r1.x
    mul_sat r0.w, r0.w, r1.x
    add r0.w, -r0.w, c0.z
    mov r1.z, c0.z
    add r1.xy, -r1.z, c16
    mul r1.y, r0.w, r1.y
    mad r0.w, r0.w, r1.x, c0.z
    dp3 r1.x, r0, c4
    lrp r2.xyz, r0.w, r0, r1.x
    add r0.x, r1.x, c5.z
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

// approximately 205 instruction slots used (17 texture, 188 arithmetic)
