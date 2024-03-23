// Reduced corona intensity in reflections
// Generated by Microsoft (R) HLSL Shader Compiler 9.26.952.2844
//
// Parameters:
//
//   row_major float4x4 gViewInverse;
//   row_major float4x4 gWorldView;
//
//
// Registers:
//
//   Name         Reg   Size
//   ------------ ----- ----
//   gWorldView   c4       4
//   gViewInverse c12      4
//

    vs_3_0
    def c230, 1.8395173895e+25, 3.9938258725e+24, 4.5435787456e+30, 2.8250177041e-42 // 2016
    def c0, 512, 0, 1, 9.99999975e-006
    def c1, 0.353553385, 0.25, 0, 0
    dcl_position v0
    dcl_color v1
    dcl_texcoord v2
    dcl_normal v3
    dcl_position o0
    dcl_texcoord o1.xy
    dcl_texcoord1 o2.xyz
    mov r0.x, c0.x
    add r0.x, r0.x, c15.z
    mov r0.x, -r0.x
    mov r0.yz, -c15.xxyw
    add r0.xyz, r0, v3.zxyw
    mul r1.xyz, r0, c0.yzyw
    mad r1.xyz, r0.zxyw, c0.zyyw, -r1
    add r1.xyz, r1, c0.w
    nrm r2.xyz, r1
    slt r0.w, c0.y, r0.x
    mul r1.xyz, r2, r0.w
    mul r2.xyz, r0, r1.yzxw
    mad r2.xyz, r0.zxyw, r1.zxyw, -r2
    add r2.xyz, r2, c0.w
    nrm r3.xyz, r2
    mul r0.yzw, r0.w, r3.xxyz
    mov r2.xyz, v3
    add r2.xyz, -r2, v0
    mad r1.xyz, r1, r2.x, v3
    mad r0.yzw, r0, r2.y, r1.xxyz
    dp3 r1.x, r2, r2
    rsq r1.x, r1.x
    rcp r1.x, r1.x
    mul r1.x, r1.x, c1.x
    rcp r1.x, r1.x
    mul_sat r0.x, r0.x, r1.x
    mul r1.xyz, r0.z, c5
    mad r1.xyz, r0.y, c4, r1
    mad r0.yzw, r0.w, c6.xxyz, r1.xxyz
    add r1.xyz, r0.yzww, c7
    add r1.w, r1.z, c0.x
    dp3 r0.y, r1.xyww, r1.xyww
    rsq r0.y, r0.y
    add r0.z, r1.z, c0.x
    mad r0.z, r0.z, -r0.y, c0.z
    rcp r0.y, r0.y
    mul r0.z, r0.z, r0.y
    add r0.y, r0.y, c0.z
    rcp r0.y, r0.y
    add o0.z, -r0.y, c0.z
    rcp r0.y, r0.z
    mul o0.xy, r1, r0.y
    mul r1.xyz, v1, c1.y
    mul r0.yzw, r1.xxyz, v2.y
    mul o2.xyz, r0.x, r0.yzww
    mov o0.w, c0.z
    mov o1.x, v2.x
    mov o1.y, v1.w

// approximately 52 instruction slots used
