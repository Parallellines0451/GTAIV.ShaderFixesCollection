// Summary: simplified transparency code
// Generated by Microsoft (R) HLSL Shader Compiler 9.26.952.2844
//
// Parameters:
//
//   sampler2D StippleTexture;
//   sampler2D TextureSampler;
//   float altRemap[16];
//   float4 colorize;
//   float3 normTable[16];
//
//
// Registers:
//
//   Name           Reg   Size
//   -------------- ----- ----
//   colorize       c51      1
//   normTable      c72     16
//   altRemap       c88     16
//   TextureSampler s0       1
//   StippleTexture s10      1
//

    ps_3_0
    def c219, 1.8395173895e+25, 3.9938258725e+24, 4.5435787456e+30, 1.2037153809e-42 // 859
    def c152, 0.2, 0.4, 0.6, 0.8 // c152-c154 = new stipple constants
    def c153, 0.5, 2, 1, 0
    def c154, 1.6, 0, 0, 0
    def c127, 0.9999999, 1, 0, 0 // LogDepth constants
    def c0, 7, 8, 9, 10
    def c1, 3.99600005, 4, 0.125, 0.25
    def c2, 0, -1, -0, 9.99999975e-006
    def c3, 2, 3, 5, 6
    def c4, 11, 12, 13, 14
    def c5, 15, 12, 13, 14
    def c6, -0, -1, -2, -3
    def c7, -4, -5, -6, -7
    def c8, -8, -9, -10, -11
    def c9, -0.5, 16, 0.00392156886, 0
    def c10, -1, -2, -3, -4
    dcl_texcoord v0.xy
    dcl_texcoord1 v1.xyz
    dcl vPos.xy
    dcl_texcoord9 v9
    dcl_2d s0
    dcl_2d s10
    texld r0, v0, s0
    mul_sat r0.w, r0.w, c154.x
    /* removed stipple
    mov_sat r0.x, r0.w
    mul r0.x, r0.x, c1.x
    frc r0.y, r0.x
    mul r0.z, r0.y, c1.y
    frc r1.x, r0.z
    add r1.x, r0.z, -r1.x
    add r1.y, r0.x, -r0.y
    mul r0.xy, c1.z, vPos
    frc r0.xy, r0_abs
    cmp r0.xy, vPos, r0, -r0
    mul r0.xy, r0, c1.w
    mad r1.xy, r1, c1.w, r0
    mov r1.zw, c2.x
    texldl r1, r1, s10
    cmp r1, -r1.y, c2.y, c2.z
    texkill r1
    removed stipple */
    mul r20.xy, vPos.xy, c153.x
    frc r20.xy, r20.xy
    mad r20, r20.xxyy, -c153.y, c153.zwzw
    mul r20, r20.xxyy, r20.zwzw
    dp4 r20.x, r20_abs, c152.xzwy
    add r20.y, -r20.x, r0.w
    texkill r20.y
    add r0.xyz, c2.w, v1
    nrm r1.xyz, r0
    dp3 r0.x, r1, c73
    add r0.y, -r0.x, c2.y
    cmp r0.y, r0.y, -c2.z, -c2.y
    max r1.w, c2.y, r0.x
    dp3 r0.x, r1, c74
    add r0.z, r1.w, -r0.x
    cmp r0.y, r0.z, r0.y, c3.x
    max r2.x, r1.w, r0.x
    dp3 r0.x, r1, c75
    add r0.z, r2.x, -r0.x
    cmp r0.y, r0.z, r0.y, c3.y
    max r1.w, r2.x, r0.x
    dp3 r0.x, r1, c76
    add r0.z, r1.w, -r0.x
    cmp r0.y, r0.z, r0.y, c1.y
    max r2.x, r1.w, r0.x
    dp3 r0.x, r1, c77
    add r0.z, r2.x, -r0.x
    cmp r0.y, r0.z, r0.y, c3.z
    max r1.w, r2.x, r0.x
    dp3 r0.x, r1, c78
    add r0.z, r1.w, -r0.x
    cmp r0.y, r0.z, r0.y, c3.w
    max r2.x, r1.w, r0.x
    dp3 r0.x, r1, c79
    add r0.z, r2.x, -r0.x
    cmp r0.y, r0.z, r0.y, c0.x
    max r1.w, r2.x, r0.x
    dp3 r0.x, r1, c80
    add r0.z, r1.w, -r0.x
    cmp r0.y, r0.z, r0.y, c0.y
    max r2.x, r1.w, r0.x
    dp3 r0.x, r1, c81
    add r0.z, r2.x, -r0.x
    cmp r0.y, r0.z, r0.y, c0.z
    max r1.w, r2.x, r0.x
    dp3 r0.x, r1, c82
    add r0.z, r1.w, -r0.x
    cmp r0.y, r0.z, r0.y, c0.w
    max r2.x, r1.w, r0.x
    dp3 r0.x, r1, c83
    add r0.z, r2.x, -r0.x
    cmp r0.y, r0.z, r0.y, c4.x
    max r1.w, r2.x, r0.x
    dp3 r0.x, r1, c84
    add r0.z, r1.w, -r0.x
    cmp r0.y, r0.z, r0.y, c4.y
    max r2.x, r1.w, r0.x
    dp3 r0.x, r1, c85
    add r0.z, r2.x, -r0.x
    cmp r0.y, r0.z, r0.y, c4.z
    max r1.w, r2.x, r0.x
    dp3 r0.x, r1, c86
    add r0.z, r1.w, -r0.x
    cmp r0.y, r0.z, r0.y, c4.w
    max r2.x, r1.w, r0.x
    dp3 r0.x, r1, c87
    add r0.x, r2.x, -r0.x
    cmp r0.x, r0.x, r0.y, c5.x
    add r1, r0.x, c6
    add r2, r0.x, c7
    add r3, r0.x, c8
    add r4, r0.x, -c5.yzwx
    mov r5.x, c2.x
    cmp r0.y, -r1_abs.x, c88.x, r5.x
    cmp r0.y, -r1_abs.y, c89.x, r0.y
    cmp r0.y, -r1_abs.z, c90.x, r0.y
    cmp r0.y, -r1_abs.w, c91.x, r0.y
    cmp r0.y, -r2_abs.x, c92.x, r0.y
    cmp r0.y, -r2_abs.y, c93.x, r0.y
    cmp r0.y, -r2_abs.z, c94.x, r0.y
    cmp r0.y, -r2_abs.w, c95.x, r0.y
    cmp r0.y, -r3_abs.x, c96.x, r0.y
    cmp r0.y, -r3_abs.y, c97.x, r0.y
    cmp r0.y, -r3_abs.z, c98.x, r0.y
    cmp r0.y, -r3_abs.w, c99.x, r0.y
    cmp r0.y, -r4_abs.x, c100.x, r0.y
    cmp r0.y, -r4_abs.y, c101.x, r0.y
    cmp r0.y, -r4_abs.z, c102.x, r0.y
    cmp r0.y, -r4_abs.w, c103.x, r0.y
    add r0.z, r0.w, c9.x
    cmp r0.x, r0.z, r0.x, r0.y
    abs r0.y, c51.x
    cmp r0.y, -r0.y, r0.x, c2.x
    mov r1.x, c51.x
    add r2, r1.x, c10
    cmp r0.zw, -r2_abs.xyyw, r0.x, c2.x
    add r1.xyz, r1.x, c7.yzww
    cmp r1.y, -r1_abs.y, r0.x, c2.x
    mul r0.x, r0.x, c9.y
    cmp r2.xy, -r2_abs.xzzw, r0.x, c2.x
    add r0.y, r0.y, r2.x
    mul oC0.x, r0.y, c9.z
    add r0.y, r0.z, r2.y
    mul oC0.y, r0.y, c9.z
    cmp r0.xy, -r1_abs.xzzw, r0.x, c2.x
    add r0.x, r0.w, r0.x
    mul oC0.z, r0.x, c9.z
    add r0.x, r1.y, r0.y
    mul oC0.w, r0.x, c9.z
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

// approximately 122 instruction slots used (3 texture, 119 arithmetic)
