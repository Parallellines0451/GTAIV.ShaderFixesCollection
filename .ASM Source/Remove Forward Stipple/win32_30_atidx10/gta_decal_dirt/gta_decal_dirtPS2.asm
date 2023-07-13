// Removed forward stipple
// Generated by Microsoft (R) HLSL Shader Compiler 9.26.952.2844
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
    def c1, 0, -1, -0, 0
    dcl_texcoord v0.xy
    dcl_color v1
    dcl vPos.xy
    dcl_2d s0
    dcl_2d s10
    texld r0, v0, s0
    mul r0, r0, v1
    mul oC0.w, r0.w, c39.x
    mov oC0.xyz, r0

// approximately 20 instruction slots used (3 texture, 17 arithmetic)