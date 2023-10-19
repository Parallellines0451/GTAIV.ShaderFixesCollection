// 256 state stipple + dithering mask
// Generated by Microsoft (R) HLSL Shader Compiler 9.26.952.2844
//
// Parameters:
//
//   sampler2D SpecSampler;
//   sampler2D StippleTexture;
//   sampler2D TextureSampler;
//   float4 globalScalars;
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
//   TextureSampler      s0       1
//   SpecSampler         s1       1
//   StippleTexture      s10      1
//

    ps_3_0
    def c151, 0.9999, 0.01171875, 0, 0	// Dithering Mask constants
    def c219, 1.8395173895e+25, 3.9938258725e+24, 4.5435787456e+30, 8.2816739242e-43 // 591
    def c150, 15.996, 16, 0.0625, 0.0625	// 256 state stipple constants
    def c127, 0.9999999, 1, 0, 0	// LogDepth constants
    def c0, 0, -1, -0, 9.99999975e-006
    def c1, 3.99600005, 4, 0.125, 0.25
    def c2, 0.5, 0.001953125, 0, 0
    dcl_texcoord v0.xy
    dcl_texcoord1 v1.xyz
    dcl_color v2.xw
    dcl vPos.xy
    dcl_texcoord9 v9
    dcl_2d s0
    dcl_2d s1
    dcl_2d s10
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
    mov r0.zw, c0.x
    texldl r0, r0, s10
    cmp r0, -r0.x, c0.y, c0.z
    texkill r0
    texld r0, v0, s0
    add r1.xyz, c0.w, v1
    dp3 r1.w, r1, r1
    rsq r1.w, r1.w
    texld r2, v0, s1
    mul r2.w, r2.w, c66.x
    dp3 r2.x, r2, c73
    mul r2.x, r2.x, c72.x
    mul r0.w, r0.w, v2.w
    mad r1.xyz, r1, r1.w, -c0.y
    mul oC1.xyz, r1, c2.x
    mul oC2.x, r2.x, c2.x
    mul r1.x, r2.w, c2.y
    rsq r1.x, r1.x
    rcp oC2.y, r1.x
    mul r0.w, r0.w, c39.x
    mov oC0, r0
    mov r20.w, r0
    mov oC1.w, r0.w
    mov oC2.z, v2.x
    mov oC2.w, r0.w
    mov r0.yz, c0
    mul oC3, -r0.yzzz, c52.x
	// -------------------------------------------------------------- Dithering Mask ----------------------------------------------------------------
	if_le r20.w, c151.x
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

// approximately 38 instruction slots used (4 texture, 34 arithmetic)
