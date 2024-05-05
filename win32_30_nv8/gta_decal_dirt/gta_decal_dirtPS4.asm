// Summary: simplified transparency code + stipple mask + reduced specularity
// Generated by Microsoft (R) HLSL Shader Compiler 9.26.952.2844
//
// Parameters:
//
//   sampler2D StippleTexture;
//   sampler2D TextureSampler;
//   float3 dirtDecalMask;
//   float4 globalScalars;
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
//   dirtDecalMask       c66      1
//   specularFactor      c72      1
//   specularColorFactor c73      1
//   TextureSampler      s0       1
//   StippleTexture      s10      1
//

    ps_3_0
    def c151, 0.9999, 0.012156862745098, 0, 0 // Stipple Mask constants
    def c219, 1.8395173895e+25, 3.9938258725e+24, 4.5435787456e+30, 1.4853763722e-43 // 106
    def c152, 0.2, 0.6, 0.8, 0.4 // c152-c153 = new stipple constants
    def c153, 0.5, 2, 1, 0
    def c127, 0.9999999, 1, 0, 0	// LogDepth constants
    def c0, 3.99600005, 4, 0.125, 0.25
    def c1, 0, -1, -0, 0.001953125
    def c2, 0.5, 0, 0, 0
    dcl_texcoord v0.xy
    dcl_color v1
    dcl vPos.xy
    dcl_texcoord9 v9
    dcl_2d s0
    dcl_2d s10
    /* removed stipple
    mov_sat r0.x, c39.x
    mul r0.x, r0.x, c0.x
    frc r0.y, r0.x
    mul r0.z, r0.y, c0.y
    frc r0.w, r0.z
    add r1.xy, r0.zxzw, -r0.wyzw
    mul r0.xy, c0.z, vPos
    frc r0.xy, r0_abs
    cmp r0.xy, vPos, r0, -r0
    mul r0.xy, r0, c0.w
    mad r0.xy, r1, c0.w, r0
    mov r0.zw, c1.x
    texldl r0, r0, s10
    cmp r0, -r0.y, c1.y, c1.z
    texkill r0
    removed stipple */
    mul r20.xy, vPos.xy, c153.x
    frc r20.xy, r20.xy
    mad r20, r20.xxyy, -c153.y, c153.zwzw
    mul r20, r20.xxyy, r20.zwzw
    dp4 r20.x, r20_abs, c152
    add r20.y, -r20.x, c39.x
    texkill r20.y
    texld r0, v0, s0
    dp3 r0.x, r0, c66
    mul r0.x, r0.x, v1.w
    mul r0.x, r0.x, c39.x
    mov r0.yzw, c1
    mul r0.w, r0.w, c72.x
    rsq r0.w, r0.w
    rcp r21.x, r0.w
    mul oC2.y, r21.x, c0.z
    mov oC0.xyz, v1
    mov oC0.w, r0.x
    mov r1.x, c73.x
    mul r1.x, r1.x, c0.z
    mul oC2.xz, r1.x, c2.xyyw
    mov oC2.w, r0.x
    mul oC3, -r0.yzzz, c52.x
    mov oC1, c1.x
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

// approximately 31 instruction slots used (3 texture, 28 arithmetic)
