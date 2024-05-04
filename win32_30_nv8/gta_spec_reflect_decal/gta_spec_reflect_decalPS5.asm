// Summary: simplified transparency code + added slope scale bias
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
    def c219, 1.8395173895e+25, 3.9938258725e+24, 4.5435787456e+30, 7.9874012467e-43 // 570
    def c152, 0.2, 0.6, 0.8, 0.4 // c152-c153 = new stipple constants
    def c153, 0.5, 2, 1, 0
    def c0, 3.99600005, 4, 0.125, 0.25
    def c1, 0, -1, -0, 0 // w = slope scale bias factor
    dcl_texcoord v0.xyz
    dcl vPos.xy
    dcl_2d s0
    dcl_2d s10
    texld r0, v0.yzzw, s0
    mul r0.x, r0.w, c39.x
    /* removed stipple
    mov_sat r0.y, r0.x
    mul r0.y, r0.y, c0.x
    frc r0.z, r0.y
    mul r0.w, r0.z, c0.y
    frc r1.x, r0.w
    add r1.x, r0.w, -r1.x
    add r1.y, r0.y, -r0.z
    mul r0.yz, c0.z, vPos.xxyw
    frc r0.yz, r0_abs
    cmp r0.yz, vPos.xxyw, r0, -r0
    mul r0.yz, r0, c0.w
    mad r1.xy, r1, c0.w, r0.yzzw
    mov r1.zw, c1.x
    texldl r1, r1, s10
    cmp r1, -r1.y, c1.y, c1.z
    texkill r1
    removed stipple */
    mul r20.xy, vPos.xy, c153.x
    frc r20.xy, r20.xy
    mad r20, r20.xxyy, -c153.y, c153.zwzw
    mul r20, r20.xxyy, r20.zwzw
    dp4 r20.x, r20_abs, c152
    add r20.y, -r20.x, r0.x
    texkill r20.y
    // mov oC0.xyz, v0.x
    dsx r1.x, v0.x
    dsy r1.y, v0.x
    add r1.x, r1_abs.x, r1_abs.y
    mad oC0.xyz, r1.x, -c1.w, v0.x
    mov oC0.w, r0.x

// approximately 21 instruction slots used (3 texture, 18 arithmetic)
