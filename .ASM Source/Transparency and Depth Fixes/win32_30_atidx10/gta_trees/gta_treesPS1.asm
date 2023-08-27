// Restored stippled transparency from 1.0.4.0
// Generated by Microsoft (R) HLSL Shader Compiler 9.23.949.2378
//
// Parameters:
//
//   sampler2D StippleTexture;
//   sampler2D TextureSampler;
//   float4 globalScalars;
//
//
// Registers:
//
//   Name           Reg   Size
//   -------------- ----- ----
//   globalScalars  c39      1
//   TextureSampler s0       1
//   StippleTexture s10      1
//

    ps_3_0
    def c0, 3.99600005, 4, 0.125, 0.25
    def c1, -1, -0, 0.5, 0
    dcl_texcoord v0.xy
    dcl_texcoord1 v1.xyz
    dcl vPos.xy
    dcl_texcoord9 v9
    dcl_2d s0
    dcl_2d s10
    texld r0, v0, s0
    mul r0.w, r0.w, c39.x
    mov_sat r1.x, r0.w
    mul r1.x, r1.x, c0.x
    frc r1.y, r1.x
    mul r1.z, r1.y, c0.y
    frc r1.w, r1.z
    add r2.xy, r1.zxzw, -r1.wyzw
    mul r1.xy, c0.z, vPos
    frc r1.xy, r1_abs
    cmp r1.xy, vPos, r1, -r1
    mul r1.xy, r1, c0.w
    mad r1.xy, r2, c0.w, r1
    texld r1, r1, s10
    cmp r1, -r1.y, c1.x, c1.y
    texkill r1
    mov oC0, r0
    mad oC1, v1.xyzx, c1.zzzw, c1.zzzw
    mov oC2, c1.wzzw
    mov oC3, c1.w
	// ----------------------------------------------------------------- Linear2Log -----------------------------------------------------------------
	rcp r20.z, c128.x
	mul r20.x, v9.w, r20.z
	mul r20.y, c128.y, r20.z
	log r20.x, r20.x
	log r20.y, r20.y
	rcp r20.y, r20.y
	mul oDepth, r20.x, r20.y
	// ----------------------------------------------------------------------------------------------------------------------------------------------

// approximately 20 instruction slots used (2 texture, 18 arithmetic)
