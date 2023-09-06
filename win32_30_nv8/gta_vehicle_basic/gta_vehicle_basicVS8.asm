//
// Generated by Microsoft (R) HLSL Shader Compiler 9.26.952.2844
//
// Parameters:
//
//   float4x3 gBoneMtx[48];
//   row_major float4x4 gWorldViewProj;
//
//
// Registers:
//
//   Name           Reg   Size
//   -------------- ----- ----
//   gWorldViewProj c8       4
//   gBoneMtx       c64    144
//

    vs_3_0
    def c0, 765.005859, 1, 0, 0
    dcl_position v0
    dcl_blendindices v1
    dcl_texcoord v2
    dcl_color v3
    dcl_position o0
    dcl_texcoord9 o10
    dcl_texcoord o1.xy
    dcl_color o2
    mul r0.x, c0.x, v1.x
    mova a0.x, r0.x
    mad r0, v0.xyzx, c0.yyyz, c0.zzzy
    dp4 r1.x, r0, c65[a0.x]
    mul r1, r1.x, c9
    dp4 r2.x, r0, c64[a0.x]
    dp4 r0.x, r0, c66[a0.x]
    mad r1, r2.x, c8, r1
    mad r0, r0.x, c10, r1
    add o0, r0, c11
    add o10.zw, r0, c11
    mov o1.xy, v2
    mad o2, v3.xyzx, c0.yyyz, c0.zzzy
    mov r20.x, c8.w
    add r20.x, r20.x, c9.w
    add r20.x, r20.x, c10.w
    add o10.y, r20.x, c11.w
    
// approximately 12 instruction slots used