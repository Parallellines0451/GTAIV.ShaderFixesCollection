//
// Generated by Microsoft (R) HLSL Shader Compiler 9.26.952.2844
//
// Parameters:
//
//   float4 DofBlurWeight;
//   sampler2D HDRSampler;
//   float4 TexelSize;
//
//
// Registers:
//
//   Name          Reg   Size
//   ------------- ----- ----
//   TexelSize     c66      1
//   DofBlurWeight c72      1
//   HDRSampler    s0       1
//

    ps_3_0
    def c0, 0, -2, -1.5, -1
    def c1, 0, -0.5, 0.5, 0
    dcl_texcoord v0.xy
    dcl_2d s0
    mov r0, c0
    mad r1.xy, c66, r0, v0
    texld r1, r1, s0
    texld r2, v0, s0
    mad r1.xyz, r1, c72.x, r2
    mad r2.xy, c66, r0.xzzw, v0
    texld r2, r2, s0
    mad r1.xyz, r2, c72.y, r1
    mad r2.xy, c66, r0.xwzw, v0
    texld r2, r2, s0
    mad r1.xyz, r2, c72.z, r1
    mov r2.xy, c66
    mad r2.zw, r2.xyxy, c1.xyxy, v0.xyxy
    texld r3, r2.zwzw, s0
    mad r1.xyz, r3, c72.w, r1
    mad r2.xy, r2, c1.xzzw, v0
    texld r2, r2, s0
    mad r1.xyz, r2, c72.w, r1
    mad r2.xy, c66, r0_abs.xwzw, v0
    texld r2, r2, s0
    mad r1.xyz, r2, c72.z, r1
    mad r0.zw, c66.xyxy, r0_abs.xyxz, v0.xyxy
    texld r2, r0.zwzw, s0
    mad r1.xyz, r2, c72.y, r1
    mad r0.xz, c66.xyyw, r0_abs.xyyw, v0.xyyw
    texld r2, r0.xzzw, s0
    mad r0.xzw, r2.xyyz, c72.x, r1.xyyz
    dp4 r0.y, -r0.y, c72
    add r0.y, r0.y, -c0.w
    rcp r0.y, r0.y
    mul oC0.xyz, r0.xzww, r0.y
    mov oC0.w, -c0.w

// approximately 32 instruction slots used (9 texture, 23 arithmetic)
 