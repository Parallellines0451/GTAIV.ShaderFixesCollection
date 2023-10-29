// Summary: 256 state stipple & changed stipple channel + dithering mask
// Generated by Microsoft (R) HLSL Shader Compiler 9.26.952.2844
//
// Parameters:
//
//   sampler2D BumpSampler;
//   sampler2D SpecSampler;
//   sampler2D StippleTexture;
//   float4 SubColor;
//   float SubScatWidth;
//   float SubScatWrap;
//   sampler2D TextureSampler;
//   float bumpiness;
//   sampler2D damageSpecTextureSampler;
//   sampler2D damageTextureSampler;
//   float4 gDirectionalLight;
//   row_major float4x4 gViewInverse;
//   float4 globalScalars;
//   float4 matMaterialColorScale;
//   float3 specMapIntMask;
//   float specularColorFactor;
//   float specularFactor;
//   float4 stencil;
//
//
// Registers:
//
//   Name                     Reg   Size
//   ------------------------ ----- ----
//   gViewInverse             c12      4
//   gDirectionalLight        c17      1
//   globalScalars            c39      1
//   stencil                  c52      1
//   matMaterialColorScale    c66      1
//   SubColor                 c72      1
//   SubScatWrap              c73      1
//   SubScatWidth             c74      1
//   specularFactor           c75      1
//   specularColorFactor      c76      1
//   specMapIntMask           c77      1
//   bumpiness                c78      1
//   TextureSampler           s0       1
//   damageTextureSampler     s1       1
//   damageSpecTextureSampler s2       1
//   BumpSampler              s4       1
//   SpecSampler              s5       1
//   StippleTexture           s10      1
//

    ps_3_0
    def c151, 0.9999, 0.015625, 0.02734375, 0	// Dithering Mask constants
    def c219, 1.8395173895e+25, 3.9938258725e+24, 4.5435787456e+30, 6.7262326288e-43 // 480
    def c150, 15.996, 16, 0.0625, 0.0625	// 256 state stipple constants
    def c127, 0.9999999, 1, 0, 0	// LogDepth constants
    def c0, 4, 0.125, 0.25, -0.5
    def c1, 0, 1, 0.333333343, 3.99600005
    def c2, 9.99999975e-006, -2, 3, 2
    def c3, 8, 4, 32, 1
    def c4, 0.00392156886, 0.0078125, 0, 0
    def c5, 0.00146484375, -2, 1, 64
    dcl_texcoord v0.xy
    dcl_texcoord1 v1.xyz
    dcl_texcoord4 v2.xyz
    dcl_texcoord5 v3.xyz
    dcl_color v4.xyw
    dcl_texcoord7 v5.xyz
    dcl_texcoord6 v6.x
    dcl vPos.xy
    dcl_texcoord9 v9
    dcl_2d s0
    dcl_2d s1
    dcl_2d s2
    dcl_2d s4
    dcl_2d s5
    dcl_2d s10
    texld r0, v0, s0
    texld r1, v0, s5
    mul r2.y, r1.w, c75.x
    dp3 r1.x, r1, c77
    mul r2.x, r1.x, c76.x
    if_lt -v6.x, c1.x
      texld r1, v0, s1
      if_lt -r1.w, c1.x
        texld r3, v0, s2
        add r2.z, c1.y, -v6.x
        mul r2.w, r3.w, c75.x
        lrp r4.y, v6.x, r2.w, r2.y
        add r2.w, r3.y, r3.x
        add r2.w, r3.z, r2.w
        mul r2.w, r2.w, v6.x
        mul r2.w, r2.w, c76.x
        mul r2.w, r2.w, c1.z
        mad r4.x, r2.z, r2.x, r2.w
        mad r2.z, r1.w, -v6.x, c1.y
        mul r1.xyz, r1.w, r1
        mul r1.xyz, r1, v6.x
        mad r0.xyz, r0, r2.z, r1
        mov r2.xy, r4
      endif
    endif
    mov_sat r1.x, c39.x
    mul r1.x, r1.x, c150.x
    frc r1.y, r1.x
    mul r1.z, r1.y, c150.y
    frc r1.w, r1.z
    add r3.xy, r1.zxzw, -r1.wyzw
    mul r1.xy, c150.z, vPos
    frc r1.xy, r1_abs
    cmp r1.xy, vPos, r1, -r1
    mul r1.xy, r1, c150.w
    mad r1.xy, r3, c150.w, r1
    mov r1.zw, c1.x
    texldl r1, r1, s10
    cmp r1, -r1.x, -c1.y, -c1.x
    texkill r1
    texld r1, v0, s4
    add r1.z, -r1.w, c1.y
    add r1.z, -r1.x, r1.z
    cmp r1.xy, r1.z, r1.wyzw, r1
    add r1.zw, r1.xyxy, c0.w
    mul r1.zw, r1, c78.x
    dp2add r1.x, r1, -r1, c1.y
    rsq r1.x, r1.x
    rcp r1.x, r1.x
    mul r3.xyz, r1.z, v2
    mad r1.xyz, v1, r1.x, r3
    mad r1.xyz, r1.w, v3, r1
    add r1.xyz, r1, c2.x
    dp3 r1.w, r1, r1
    rsq r1.w, r1.w
    mul r3.xyz, r1, r1.w
    dp3 r2.z, c17, r3
    add r2.z, r2.z, c73.x
    mov r3.xy, c1
    add r2.w, r3.y, c73.x
    rcp r2.w, r2.w
    mul r2.z, r2.z, r2.w
    max r3.z, r2.z, c1.x
    rcp r2.z, c74.x
    mul_sat r2.z, r3.z, r2.z
    mad r2.w, r2.z, c2.y, c2.z
    mul r2.z, r2.z, r2.z
    mul r2.z, r2.w, r2.z
    mov r2.w, c2.w
    mad r2.w, c74.x, -r2.w, r3.z
    rcp r3.z, -c74.x
    mul_sat r2.w, r2.w, r3.z
    mad r3.z, r2.w, c2.y, c2.z
    mul r2.w, r2.w, r2.w
    mul r2.w, r3.z, r2.w
    mul r2.z, r2.z, r2.w
    mul r4.xyz, r2.z, c72
    mul r4.xyz, r0.w, r4
    mad r0.xyz, r4, -c0.w, r0
    mul oC0.xyz, r0, c66.x
    mul r0.xy, r2, c66.w
    mul r0.y, r0.y, c5.x
    add r2.xyz, -c15, v5
    add r2.xyz, r2, c2.x
    nrm r4.xyz, r2
    mad r2.xyz, r1, r1.w, c2.x
    nrm r5.xyz, r2
    dp3 r0.z, r4, r5
    mad r0.w, r0.z, -c5.y, c5.z
    cmp r0.z, -r0.z, r0.w, c1.y
    mul r0.w, r0.z, v4.y
    cmp r0.z, r0.z, r0.w, c1.x
    mul r0.w, r0.z, r0.z
    mad r0.x, r0.x, -c0.w, r0.w
    mad oC2.z, r0.z, r0.z, v4.x
    mad r1.xyz, r1, r1.w, c1.y
    mul r2.xyz, r1, c5.w
    frc r4.xyz, r2
    add r2.xyz, r2, -r4
    mad r1.xyz, r1, c5.w, -r2
    mul r1.xyz, r1, c3.xxyw
    frc r4.xyz, r1
    add r1.xyz, r1, -r4
    dp3 r0.z, r1.yxzw, c3.yzww
    mul oC1.w, r0.z, c4.x
    mul oC1.xyz, r2, c4.y
    mul oC2.x, r0.x, -c0.w
    rsq r0.x, r0.y
    rcp oC2.y, r0.x
    mul oC0.w, c39.x, v4.w
    mul r20.w, c39.x, v4.w
    mov oC2.w, c1.y
    mul oC3, r3.yxxx, c52.x
	// -------------------------------------------------------------- Dithering Mask ----------------------------------------------------------------
	mov r20.z, c52.x
	add r20.z, r20.z, -c151.z
	cmp r20.w, r20.z, c151.x, r20.w
	if_lt r20.w, c151.x
		mov oC3, c151.ywww
	endif
	// ----------------------------------------------------------------------------------------------------------------------------------------------
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

// approximately 122 instruction slots used (7 texture, 115 arithmetic)
