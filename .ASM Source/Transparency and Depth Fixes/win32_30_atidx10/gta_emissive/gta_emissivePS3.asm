// Restored stippled transparency from 1.0.4.0
// Generated by Microsoft (R) HLSL Shader Compiler 9.23.949.2378
//
// Parameters:
//
//   sampler2D StippleTexture;
//   sampler2D TextureSampler;
//   float4 colorize;
//   float4 globalScalars;
//   float4 stencil;
//
//
// Registers:
//
//   Name           Reg   Size
//   -------------- ----- ----
//   globalScalars  c39      1
//   colorize       c51      1
//   stencil        c52      1
//   TextureSampler s0       1
//   StippleTexture s10      1
//

    ps_3_0
    def c0, -1, -0, 9.99999975e-006, 1
    def c1, 3.99600005, 4, 0.125, 0.25
    def c2, 0.5, 0, 1, 0.25	
    dcl_texcoord v0.xy
    dcl_texcoord1 v1.xyz
    dcl_color v2.w
    dcl vPos.xy
    dcl_texcoord9 v9
    dcl_2d s0
    dcl_2d s10
    texld r0, v0, s0
    mul r0, r0, c51
    //mul r0.w, r0.w, v2.w	// disabled vertex alpha
    mul r0.w, r0.w, c39.x
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
    texld r1, r1, s10
    cmp r1, -r1.y, c0.x, c0.y
    texkill r1
    add r1.xyz, c0.z, v1
    dp3 r1.w, r1, r1
    rsq r1.w, r1.w
    mad r1.xyz, r1, r1.w, c0.w
    mul oC1.xyz, r1, c2.x
    mov oC0, r0
    mov oC1.w, r0.w
    mov r1.yzw, c2
    mad oC2.xyz, c39.z, r1.yyzw, r1.ywyw
    mov oC2.w, r0.w
    mov r0.xy, c0
    mul oC3, -r0.xyyy, c52.x
	// ----------------------------------------------------------------- Linear2Log -----------------------------------------------------------------
	rcp r20.z, c128.x
	mul r20.x, v9.w, r20.z
	mul r20.y, c128.y, r20.z
	log r20.x, r20.x
	log r20.y, r20.y
	rcp r20.y, r20.y
	mul oDepth, r20.x, r20.y
	// ----------------------------------------------------------------------------------------------------------------------------------------------

// approximately 30 instruction slots used (2 texture, 28 arithmetic)
