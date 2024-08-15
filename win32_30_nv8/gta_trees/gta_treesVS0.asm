// Summary: Added custom wind sway register
// Generated by Microsoft (R) HLSL Shader Compiler 9.26.952.2844
//
// Parameters:
//
//   float4 colorize;
//   float4 gDayNightEffects;
//   row_major float4x4 gWorld;
//   row_major float4x4 gWorldViewProj;
//   float4 globalScalars;
//   float4 globalScalars2;
//
//
// Registers:
//
//   Name             Reg   Size
//   ---------------- ----- ----
//   gWorld           c0       4
//   gWorldViewProj   c8       4
//   globalScalars    c39      1
//   globalScalars2   c40      1
//   gDayNightEffects c45      1
//   colorize         c51      1
//

    vs_3_0
    def c230, 1.8395173895e+25, 3.9938258725e+24, 4.5435787456e+30, 3.6685993796e-42 // 2618
    def c4, 0.00499999989, 0.00999999978, 0, 1
    def c5, 9.99999975e-006, 0.5, 0.0318309888, 0
    def c6, 6.28318548, -3.14159274, 0, 0
    dcl_position v0
    dcl_normal v1
    dcl_color v2
    dcl_texcoord v3
    dcl_position o0
    dcl_texcoord9 o10
    dcl_texcoord o1.xy
    dcl_texcoord1 o2.xyz
    dcl_texcoord2 o3.xy
    dcl_texcoord3 o4.xyz
    mul r0.xyz, c1, v1.y
    mad r0.xyz, v1.x, c0, r0
    mad o2.xyz, v1.z, c2, r0
    mul r0.xyz, c4.zwzw, v0.zxyw
    mad r0.xyz, v0.yzxw, c4.wzzw, -r0
    add r0.xyz, r0, c5.x
    nrm r1.xyz, r0
    dp3 r0.x, v0, v0
    rsq r0.x, r0.x
    rcp r0.x, r0.x
    mad r0.y, r0.x, c4.x, c4.y
    mul r0.x, r0.x, c233.x
    // mul r0.x, r0.x, c51.w
    mad r0.x, r0.x, c5.z, c5.y
    frc r0.x, r0.x
    mad r0.x, r0.x, c6.x, c6.y
    sincos r2.xy, r0.x
    mul r0.xzw, r1.xyyz, r0.y
    mul r1.xyz, r0.wxzw, v0.yzxw
    mad r1.xyz, r0.zwxw, v0.zxyw, -r1
    mad r0.xzw, r0, r2.y, v0.xyyz
    add r1.xyz, r1, c5.x
    nrm r3.xyz, r1
    mul r1.xyz, r0.y, r3
    mul r1.xyz, r1, c5.y
    mad r0.xyz, r1, r2.x, r0.xzww
    mul r1, r0.y, c9
    mad r1, r0.x, c8, r1
    mad r0, r0.z, c10, r1
    add o0, r0, c11
    add o10.zw, r0, c11
    mul r0.xyz, c1, v0.y
    mad r0.xyz, v0.x, c0, r0
    mad r0.xyz, v0.z, c2, r0
    add o4.xyz, r0, c3
    mul r0.xy, c45, v2
    add r0.x, r0.y, r0.x
    mov r0.w, c4.w
    mad r0.x, r0.x, c39.z, -r0.w
    mad o3.x, c40.z, r0.x, r0.w
    mul o3.y, c39.x, v2.w
    mov o1.xy, v3
    mov r20.x, c8.w
    add r20.x, r20.x, c9.w
    add r20.x, r20.x, c10.w
    add o10.y, r20.x, c11.w

// approximately 51 instruction slots used
