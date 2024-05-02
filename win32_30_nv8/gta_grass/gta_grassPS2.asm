// Summary: simplified transparency code + dithering mask
// Generated by Microsoft (R) HLSL Shader Compiler 9.26.952.2844
//
// Parameters:
//
//   sampler2D StippleTexture;
//   sampler2D TextureGrassSampler;
//   float4 stencil;
//
//
// Registers:
//
//   Name                Reg   Size
//   ------------------- ----- ----
//   stencil             c52      1
//   TextureGrassSampler s0       1
//   StippleTexture      s10      1
//

    ps_3_0
    def c151, 0.7999, 0.012156862745098, 0, 0 // Dithering Mask constants
    def c219, 1.8395173895e+25, 3.9938258725e+24, 4.5435787456e+30, 3.7835058537e-43 // 270
    def c152, 0.2, 0.6, 0.8, 0.4 // c152-c153 = new stipple constants
    def c153, 0.5, 2, 1, 0
    def c127, 0.9999999, 1, 0, 0	// LogDepth constants
    def c0, 0, -1, -0, 9.99999975e-006
    def c1, 3.99600005, 4, 0.125, 0.25
    def c2, 0.5, 0, 1, 0.25
    dcl_color v0.w
    dcl_texcoord v1
    dcl_texcoord1 v2.w
    dcl vPos.xy
    dcl_texcoord9 v9
    dcl_2d s0
    dcl_2d s10
    mov r0.x, v1.w
    mov r0.y, v2.w
    texld r0, r0, s0
    mul r0.w, r0.w, v0.w
    /* removed stipple
    mov_sat r1.x, r0.w
    mul r1.x, r1.x, c1.x
    frc r1.y, r1.x
    mul r1.z, r1.y, c1.y
    frc r1.w, r1.z
    add r2.xy, r1.zxzw, -r1.wyzw
    mul r1.xy, c1.z, vPos
    frc r1.xy, r1_abs
    cmp r1.xy, vPos, r1, -r1
    mul r1.xy, r1, c1.w
    mad r1.xy, r2, c1.w, r1
    mov r1.zw, c0.x
    texldl r1, r1, s10
    cmp r1, -r1.y, c0.y, c0.z
    texkill r1
    removed stipple */
    mul r20.xy, vPos.xy, c153.x
    frc r20.xy, r20.xy
    mad r20, r20.xxyy, -c153.y, c153.zwzw
    mul r20, r20.xxyy, r20.zwzw
    dp4 r20.x, r20_abs, c152
    add r20.y, -r20.x, r0.w
    texkill r20.y
    add r1.xyz, c0.w, v1
    dp3 r1.w, r1, r1
    rsq r1.w, r1.w
    mad r1.xyz, r1, r1.w, -c0.y
    mul oC1.xyz, r1, c2.x
    mov oC0, r0
    mov oC1.w, r0.w
    mad oC2, r0.w, c2.yyyz, c2.ywzy
    mov r0.yz, c0
    mul oC3, -r0.yzzz, c52.x
	// -------------------------------------------------------------- Dithering Mask ----------------------------------------------------------------
	if_lt r0.w, c151.x
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

// approximately 30 instruction slots used (3 texture, 27 arithmetic)
