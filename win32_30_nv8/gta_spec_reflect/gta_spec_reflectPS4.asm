// Summary: simplified transparency code + dithering mask
// Generated by Microsoft (R) HLSL Shader Compiler 9.26.952.2844
//
// Parameters:
//
//   sampler2D EnvironmentSampler;
//   sampler2D SpecSampler;
//   sampler2D StippleTexture;
//   sampler2D TextureSampler;
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
//   reflectivePower     c74      1
//   TextureSampler      s0       1
//   SpecSampler         s1       1
//   EnvironmentSampler  s2       1
//   StippleTexture      s10      1
//

    ps_3_0
    def c151, 0.9999, 0.012156862745098, 0, 0 // Dithering Mask constants
    def c219, 1.8395173895e+25, 3.9938258725e+24, 4.5435787456e+30, 8.1275310931e-43 // 580
    def c152, 0.2, 0.6, 0.8, 0.4
    def c153, -2, 2, 1, 0
    def c154, 0.5, 0, 0, 0
    def c127, 0.9999999, 1, 0, 0	// LogDepth constants
    def c0, 0, -1, -0, 9.99999975e-006
    def c1, -0.5, 0.5, 0.001953125, 0
    def c2, 3.99600005, 4, 0.125, 0.25
    dcl_texcoord v0.xy
    dcl_texcoord1 v1.xyz
    dcl_texcoord3 v2.xyz
    dcl_color v3.xw
    dcl vPos.xy
    dcl_texcoord9 v9
    dcl_2d s0
    dcl_2d s1
    dcl_2d s2
    dcl_2d s10
    /* removed stipple
    mov_sat r0.x, c39.x
    mul r0.x, r0.x, c2.x
    frc r0.y, r0.x
    mul r0.z, r0.y, c2.y
    frc r0.w, r0.z
    add r1.xy, r0.zxzw, -r0.wyzw
    mul r0.xy, c2.z, vPos
    frc r0.xy, r0_abs
    cmp r0.xy, vPos, r0, -r0
    mul r0.xy, r0, c2.w
    mad r0.xy, r1, c2.w, r0
    mov r0.zw, c0.x
    texldl r0, r0, s10
    cmp r0, -r0.y, c0.y, c0.z
    texkill r0
    removed stipple */
    mul r20.xy, vPos.xy, c154.x
    frc r20.xy, r20.xy
    mad r20, r20.xxyy, c153.xyxy, c153.zwzw
    mul r20, r20.xxyy, r20.zwzw
    dp4 r20.x, r20, c152
    add r20.y, -r20.x, c39.x
    texkill r20.y
    texld r0, v0, s0
    add r1.xyz, c0.w, v1
    dp3 r1.w, r1, r1
    rsq r1.w, r1.w
    mul r2.xyz, r1, r1.w
    texld r3, v0, s1
    mul r2.w, r3.w, c66.x
    dp3 r3.x, r3, c73
    mul r3.x, r3.x, c72.x
    add r3.yzw, c0.w, v2.xxyz
    nrm r4.xyz, r3.yzww
    dp3 r3.y, -r4, r2
    add r3.y, r3.y, r3.y
    mad r2.xyz, r2, -r3.y, -r4
    add r2.xyz, r2, c0.w
    dp3 r2.y, r2, r2
    rsq r2.y, r2.y
    mad r2.xy, r2.xzzw, r2.y, -c0.y
    mul r2.xy, r2, c1.x
    texld r4, r2, s2
    mul r2.xyz, r3.x, r4
    mul r0.w, r0.w, v3.w
    mad oC0.xyz, r2, c74.x, r0
    mad r0.xyz, r1, r1.w, -c0.y
    mul oC1.xyz, r0, c1.y
    mul oC2.x, r3.x, c1.y
    mul r0.x, r2.w, c1.z
    rsq r0.x, r0.x
    rcp oC2.y, r0.x
    mul r0.x, r0.w, c39.x
    mov oC0.w, r0.x
    mov r20.w, r0.x
    mov oC1.w, r0.x
    mov oC2.z, v3.x
    mov oC2.w, r0.x
    mov r0.yz, c0
    mul oC3, -r0.yzzz, c52.x
	// -------------------------------------------------------------- Dithering Mask ----------------------------------------------------------------
	if_lt r20.w, c151.x
		mov r20.z, c52.x
		add oC3.x, r20.z, c151.y
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

// approximately 54 instruction slots used (5 texture, 49 arithmetic)
