// Summary: simplified transparency code + fixed pop-in/added stippled transparency + dithering mask
// Generated by Microsoft (R) HLSL Shader Compiler 9.26.952.2844
//
// Parameters:
//
//   sampler2D BumpSampler;
//   samplerCUBE EnvironmentSampler;
//   sampler2D SpecSampler;
//   sampler2D TextureSampler;
//   float bumpiness;
//   float4 globalScalars;
//   float reflectivePower;
//   float3 specMapIntMask;
//   float specularColorFactor;
//   float specularFactor;
//   float4 stencil;
//
//
// Registers:
//
//   Name                Reg   Size
//   ------------------- ----- ----
//   globalScalars       c39      1
//   stencil             c52      1
//   specularFactor      c66      1
//   specularColorFactor c72      1
//   specMapIntMask      c73      1
//   bumpiness           c74      1
//   reflectivePower     c75      1
//   TextureSampler      s0       1
//   BumpSampler         s1       1
//   SpecSampler         s2       1
//   EnvironmentSampler  s4       1
//

    ps_3_0
    def c151, 0.7999, 0.012156862745098, 0, 0 // Dithering Mask constants
    def c219, 1.8395173895e+25, 3.9938258725e+24, 4.5435787456e+30, 4.8765186559e-43 // 348
    def c152, 0.2, 0.6, 0.8, 0.4 // c152-c153 = new stipple constants
    def c153, 0.5, 2, 1, 0
    def c127, 0.9999999, 1, 0, 0	// LogDepth constants
    def c0, -0.5, 9.99999975e-006, 0.5, 0.001953125
    def c1, 0.176470593, -1, -0, 1
    dcl_texcoord v0.xy
    dcl_texcoord1 v1.xyz
    dcl_texcoord3 v2.xyz
    dcl_texcoord4 v3.xyz
    dcl_texcoord5 v4.xyz
    dcl_color v5.xw
    dcl_texcoord9 v9
    dcl vPos.xy
    dcl_2d s0
    dcl_2d s1
    dcl_2d s2
    dcl_cube s4
    texld r0, v0, s0
    // mul r0.w, r0.w, v5.w disabled vertex alpha
    mul r1.x, r0.w, c39.x
    mov r2.xyz, c1
    /* removed alpha threshold
    mad r0.w, r0.w, -c39.x, r2.x
    cmp r3, r0.w, c1.y, c1.z
    texkill r3
    removed alpha threshold */
    mul r20.xy, vPos.xy, c153.x
    frc r20.xy, r20.xy
    mad r20, r20.xxyy, -c153.y, c153.zwzw
    mul r20, r20.xxyy, r20.zwzw
    dp4 r20.x, r20_abs, c152
    add r20.y, -r20.x, r1.x
    texkill r20.y
    texld r3, v0, s1
    add r0.w, -r3.w, c1.w
    add r0.w, -r3.x, r0.w
    cmp r1.yz, r0.w, r3.xwyw, r3.xxyw
    add r2.xw, r1.yyzz, c0.x
    mul r2.xw, r2, c74.x
    dp2add r0.w, r1.yzzw, -r1.yzzw, c1.w
    rsq r0.w, r0.w
    rcp r0.w, r0.w
    mul r1.yzw, r2.x, v3.xxyz
    mad r1.yzw, v1.xxyz, r0.w, r1
    mad r1.yzw, r2.w, v4.xxyz, r1
    add r1.yzw, r1, c0.y
    dp3 r0.w, r1.yzww, r1.yzww
    rsq r0.w, r0.w
    mul r3.xyz, r1.yzww, r0.w
    texld r4, v0, s2
    mul r2.x, r4.w, c66.x
    dp3 r2.w, r4, c73
    mul r2.w, r2.w, c72.x
    add r4.xyz, c0.y, v2.xzyw
    dp3 r3.w, r4, r4
    rsq r3.w, r3.w
    mul r4.xyz, r4, r3.w
    dp3 r3.w, -r4.xzyw, r3
    add r3.w, r3.w, r3.w
    mad r3.xyz, r3.xzyw, -r3.w, -r4
    add r3.xyz, r3, c0.y
    dp3 r3.w, r3, r3
    rsq r3.w, r3.w
    mul r3.xyz, r3, r3.w
    texld r3, r3, s4
    mul r3.xyz, r2.w, r3
    mad oC0.xyz, r3, c75.x, r0
    mad r0.xyz, r1.yzww, r0.w, c1.w
    mul oC1.xyz, r0, c0.z
    mul oC2.x, r2.w, c0.z
    mul r0.x, r2.x, c0.w
    rsq r0.x, r0.x
    rcp oC2.y, r0.x
    mov oC0.w, r1.x
    mov oC1.w, r1.x
    mov oC2.z, v5.x
    mov oC2.w, r1.x
    mul oC3, -r2.yzzz, c52.x
	// -------------------------------------------------------------- Dithering Mask ----------------------------------------------------------------
	if_lt r1.x, c151.x
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

// approximately 53 instruction slots used (4 texture, 49 arithmetic)
