// Summary: Ported XBOX mirror shader + improved filter
// Generated by Microsoft (R) HLSL Shader Compiler 9.26.952.2844
//
// Parameters:
//
//   sampler2D ReflectTextureSampler;
//   float gInvColorExpBias;
//   float4 globalScreenSize;
//   float4 globalScalars;
//
//
// Registers:
//
//   Name                  Reg   Size
//   --------------------- ----- ----
//   globalScalars         c39      1
//   globalScreenSize      c44      1
//   gInvColorExpBias      c46      1
//   ReflectTextureSampler s0       1
//

    ps_3_0
    def c219, 1.8395173895e+25, 3.9938258725e+24, 4.5435787456e+30, 1.0691907283e-42 // 763
    def c127, 0.9999999, 1, 0, 0	// LogDepth constants
    def c0, 0.5, 0.25, 0.1111111, 0
    def c1, -1, 0, 1, 0.001953125
    dcl_texcoord v0.xyw
    dcl_texcoord9 v9
    dcl_2d s0
    rcp r1.x, v0.w
    mul r1.x, -r1.x, c0.x
    mad r2.xy, r1.x, v0.yx, c0.x
	
    mul r3.xy, c44.xy, c44.z
    mul r3.xy, r3.xy, c1.w
	
    mad r0.xy, r3.xy, c1.xx, r2.xy
    texld r1, r0.yx, s0
    mad r0.xy, r3.xy, c1.xy, r2.xy
    texld r0, r0.yx, s0
    add r1, r1, r0
    mad r0.xy, r3.xy, c1.xz, r2.xy
    texld r0, r0.yx, s0
    add r1, r1, r0
    mad r0.xy, r3.xy, c1.yx, r2.xy
    texld r0, r0.yx, s0
    add r1, r1, r0
    mad r0.xy, r3.xy, c1.yy, r2.xy
    texld r0, r0.yx, s0
    add r1, r1, r0
    mad r0.xy, r3.xy, c1.yz, r2.xy
    texld r0, r0.yx, s0
    add r1, r1, r0
    mad r0.xy, r3.xy, c1.zx, r2.xy
    texld r0, r0.yx, s0
    add r1, r1, r0
    mad r0.xy, r3.xy, c1.zy, r2.xy
    texld r0, r0.yx, s0
    add r1, r1, r0
    mad r0.xy, r3.xy, c1.zz, r2.xy
    texld r0, r0.yx, s0
    add r1, r1, r0
    mul r0, r1, c0.z
	
    mul oC0.xyz, r0.xyz, c39.y
    mov oC0.w, c46.x
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

// approximately 8 instruction slots used (1 texture, 7 arithmetic)
