//
// Generated by Microsoft (R) HLSL Shader Compiler 9.26.952.2844
//
// Parameters:
//
//   row_major float4x4 gViewInverse;
//   row_major float4x4 gWorld;
//   row_major float4x4 gWorldViewProj;
//   row_major float4x4 matWheelTransform;
//
//
// Registers:
//
//   Name              Reg   Size
//   ----------------- ----- ----
//   gWorld            c0       4
//   gWorldViewProj    c8       4
//   gViewInverse      c12      4
//   matWheelTransform c64      4
//

    vs_3_0
    def c0, 9.99999975e-006, 1, 0, 0
    dcl_position v0
    dcl_color v1
    dcl_texcoord v2
    dcl_normal v3
    dcl_tangent v4
    dcl_position o0
    dcl_texcoord9 o10
    dcl_texcoord o1.xy
    dcl_texcoord1 o2
    dcl_texcoord3 o3.xyz
    dcl_texcoord4 o4.xyz
    dcl_texcoord5 o5.xyz
    dcl_color o6
    dcl_texcoord2 o7
    mul r0.xyz, c65, v0.y
    mad r0.xyz, v0.x, c64, r0
    mad r0.xyz, v0.z, c66, r0
    add r0.xyz, r0, c67
    add r1.xyz, r0, c3
    add o3.xyz, -r1, c15
    mul r1.xyz, c65, v3.y
    mad r1.xyz, v3.x, c64, r1
    mad r1.xyz, v3.z, c66, r1
    add r1.xyz, r1, c0.x
    nrm r2.xyz, r1
    mul r1.xyz, c65, v4.y
    mad r1.xyz, v4.x, c64, r1
    mad r1.xyz, v4.z, c66, r1
    add r1.xyz, r1, c0.x
    nrm r3.xyz, r1
    mul r1.xyz, r2.yzxw, r3.zxyw
    mad r1.xyz, r3.yzxw, r2.zxyw, -r1
    mov o2.xyz, r2
    mov o4.xyz, r3
    mul o5.xyz, r1, v4.w
    mul r1, r0.y, c9
    mad r1, r0.x, c8, r1
    mad r1, r0.z, c10, r1
    mov o7.xyz, r0
    add r0, r1, c11
    mov o0, r0
    mov o10.zw, r0
    mov o2.w, r0.w
    mov o1.xy, v2
    mad o6, v1.xyzx, c0.yyyz, c0.zzzy
    mov o7.w, c0.y
    mov r20.x, c8.w
    add r20.x, r20.x, c9.w
    add r20.x, r20.x, c10.w
    add o10.y, r20.x, c11.w
    
// approximately 35 instruction slots used