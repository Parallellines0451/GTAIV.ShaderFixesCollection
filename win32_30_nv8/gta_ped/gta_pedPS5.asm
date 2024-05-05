// Summary: simplified transparency code + stipple mask
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
//   globalScalars            c39      1
//   stencil                  c52      1
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
//

    ps_3_0
    def c151, 0.9999, 0.012156862745098, 0, 0 // Stipple Mask constants
    def c219, 1.8395173895e+25, 3.9938258725e+24, 4.5435787456e+30, 6.8663624752e-43 // 490
    def c152, 0.2, 0.6, 0.8, 0.4 // c152-c153 = new stipple constants
    def c153, 0.5, 2, 1, 0
    def c127, 0.9999999, 1, 0, 0	// LogDepth constants
    def c0, 4, 0.125, 0.25, -0.5
    def c1, 9.99999975e-006, 0.00146484375, -2, 1
    def c2, 0, 1, 0.333333343, 3.99600005
    def c3, 64, 8, 4, 0.00392156886
    def c4, 32, 4, 1, 0.0078125
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
    mul r2.y, r1.w, c72.x
    dp3 r1.x, r1, c74
    mul r2.x, r1.x, c73.x
    if_lt -v6.x, c2.x
      texld r1, v0, s1
      if_lt -r1.w, c2.x
        texld r3, v0, s2
        add r2.z, c2.y, -v6.x
        mul r2.w, r3.w, c72.x
        lrp r4.y, v6.x, r2.w, r2.y
        add r2.w, r3.y, r3.x
        add r2.w, r3.z, r2.w
        mul r2.w, r2.w, v6.x
        mul r2.w, r2.w, c73.x
        mul r2.w, r2.w, c2.z
        mad r4.x, r2.z, r2.x, r2.w
        mad r2.z, r1.w, -v6.x, c2.y
        mul r1.xyz, r1.w, r1
        mul r1.xyz, r1, v6.x
        mad r0.xyz, r0, r2.z, r1
        mov r2.xy, r4
      endif
    endif
    /* removed stipple
    mov_sat r1.x, c39.x
    mul r1.x, r1.x, c2.w
    frc r1.y, r1.x
    mul r1.z, r1.y, c0.x
    frc r1.w, r1.z
    add r3.xy, r1.zxzw, -r1.wyzw
    mul r1.xy, c0.y, vPos
    frc r1.xy, r1_abs
    cmp r1.xy, vPos, r1, -r1
    mul r1.xy, r1, c0.z
    mad r1.xy, r3, c0.z, r1
    mov r1.zw, c2.x
    texldl r1, r1, s10
    cmp r1, -r1.y, -c2.y, -c2.x
    texkill r1
    removed stipple */
    mul r20.xy, vPos.xy, c153.x
    frc r20.xy, r20.xy
    mad r20, r20.xxyy, -c153.y, c153.zwzw
    mul r20, r20.xxyy, r20.zwzw
    dp4 r20.x, r20_abs, c152
    add r20.y, -r20.x, c39.x
    texkill r20.y
    texld r1, v0, s4
    add r1.z, -r1.w, c2.y
    add r1.z, -r1.x, r1.z
    cmp r1.xy, r1.z, r1.wyzw, r1
    add r1.zw, r1.xyxy, c0.w
    mul r1.zw, r1, c75.x
    dp2add r1.x, r1, -r1, c2.y
    rsq r1.x, r1.x
    rcp r1.x, r1.x
    mul r3.xyz, r1.z, v2
    mad r1.xyz, v1, r1.x, r3
    mad r1.xyz, r1.w, v3, r1
    add r1.xyz, r1, c1.x
    dp3 r1.w, r1, r1
    rsq r1.w, r1.w
    mul r0.w, r0.w, v4.w
    mul oC0.xyz, r0, c66.x
    mul r0.xy, r2, c66.w
    mul r0.y, r0.y, c1.y
    add r2.xyz, -c15, v5
    add r2.xyz, r2, c1.x
    nrm r3.xyz, r2
    mad r2.xyz, r1, r1.w, c1.x
    nrm r4.xyz, r2
    dp3 r0.z, r3, r4
    mad r2.x, r0.z, -c1.z, c1.w
    cmp r0.z, -r0.z, r2.x, c2.y
    mul r2.x, r0.z, v4.y
    cmp r0.z, r0.z, r2.x, c2.x
    mul r2.x, r0.z, r0.z
    mad r0.x, r0.x, -c0.w, r2.x
    mad oC2.z, r0.z, r0.z, v4.x
    mad r1.xyz, r1, r1.w, c2.y
    mul r2.xyz, r1, c3.x
    frc r3.xyz, r2
    add r2.xyz, r2, -r3
    mad r1.xyz, r1, c3.x, -r2
    mul r1.xyz, r1, c3.yyzw
    frc r3.xyz, r1
    add r1.xyz, r1, -r3
    dp3 r0.z, r1, c4
    mul oC1.w, r0.z, c3.w
    mul oC1.xyz, r2, c4.w
    mul oC2.x, r0.x, -c0.w
    rsq r0.x, r0.y
    rcp oC2.y, r0.x
    mul oC0.w, r0.w, c39.x
    mov oC2.w, c2.y
    mov r0.xy, c2
    mul oC3, r0.yxxx, c52.x
	// --------------------------------------------------------------- Stipple Mask -----------------------------------------------------------------
	mov r22.x, c39.x
	if_lt r22.x, c151.x
		mov r22.x, c52.x
		add oC3.x, r22.x, c151.y
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

// approximately 100 instruction slots used (7 texture, 93 arithmetic)
