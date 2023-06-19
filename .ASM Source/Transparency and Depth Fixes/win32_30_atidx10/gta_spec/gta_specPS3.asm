// Restored stippled transparency + reduced stippling
// Generated by Microsoft (R) HLSL Shader Compiler 9.23.949.2378 (ported from 1.0.4.0)
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
    def c0, -1, -0, 9.99999975e-006, 1
    def c1, 3.99600005, 4, 0.125, 0.25
    def c2, 0.5, 0.001953125, 0, 0
    dcl_texcoord v0.xy
    dcl_texcoord1 v1.xyz
    dcl_color v2.xw
    dcl vPos.xy
    dcl_2d s0
    dcl_2d s1
    dcl_2d s10
    texld r0, v0, s0
	mul_sat r0.w, r0.w, c1.y // increased alpha threshold to reduce stippling
    mul r0.w, r0.w, v2.w
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
    texld r2, v0, s1
    mul r2.w, r2.w, c66.x
    dp3 r2.x, r2, c73
    mul r2.x, r2.x, c72.x
    mad r1.xyz, r1, r1.w, c0.w
    mul oC1.xyz, r1, c2.x
    mul oC2.x, r2.x, c2.x
    mul r1.x, r2.w, c2.y
    rsq r1.x, r1.x
    rcp oC2.y, r1.x
    mov oC0, r0
    mov oC1.w, r0.w
    mov oC2.z, v2.x
    mov oC2.w, r0.w
    mov r0.xy, c0
    mul oC3, -r0.xyyy, c52.x

// approximately 36 instruction slots used (3 texture, 33 arithmetic)
 