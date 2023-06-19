//
// Generated by Microsoft (R) HLSL Shader Compiler 9.26.952.2844
//
// Parameters:
//
//   float gAmbientAmount;
//   float4 gColorTint;
//   float4 gColorTintPhase2;
//   float gDiffuse;
//   float4 gDirectionalColour;
//   float4 gDirectionalLight;
//   float4 gLightAmbient0;
//   float4 gLightAmbient1;
//   float4 gLightColB;
//   float4 gLightColG;
//   float4 gLightColR;
//   float4 gLightConeOffset;
//   float4 gLightConeScale;
//   float4 gLightDirX;
//   float4 gLightDirY;
//   float4 gLightDirZ;
//   float4 gLightFallOff;
//   float4 gLightPosX;
//   float4 gLightPosY;
//   float4 gLightPosZ;
//   float gMotionBlur;
//   float4 gRadius;
//   float4 gTextureAnimation;
//   row_major float4x4 gViewInverse;
//   row_major float4x4 gWorldView;
//   row_major float4x4 gWorldViewProj;
//   float gWrapBias;
//   float gWrapScale;
//
//
// Registers:
//
//   Name               Reg   Size
//   ------------------ ----- ----
//   gWorldView         c4       4
//   gWorldViewProj     c8       4
//   gViewInverse       c12      4
//   gDirectionalLight  c17      1
//   gDirectionalColour c18      1
//   gLightPosX         c19      1
//   gLightPosY         c20      1
//   gLightPosZ         c21      1
//   gLightDirX         c22      1
//   gLightDirY         c23      1
//   gLightDirZ         c24      1
//   gLightFallOff      c25      1
//   gLightConeScale    c26      1
//   gLightConeOffset   c27      1
//   gLightColR         c29      1
//   gLightColG         c30      1
//   gLightColB         c31      1
//   gLightAmbient0     c37      1
//   gLightAmbient1     c38      1
//   gMotionBlur        c64      1
//   gRadius            c65      1
//   gTextureAnimation  c66      1
//   gColorTint         c67      1
//   gColorTintPhase2   c68      1
//   gWrapScale         c69      1
//   gWrapBias          c70      1
//   gDiffuse           c71      1
//   gAmbientAmount     c72      1
//

    vs_3_0
    def c0, 0, 0.5, -0.5, 0.699999988
    def c1, -10, 9.99999975e-006, 1, -0.100000001
    def c2, 1.11111116, 0.200000003, 0, 0
    dcl_texcoord v0
    dcl_texcoord1 v1
    dcl_texcoord2 v2
    dcl_position o0
    dcl_color o1
    dcl_texcoord o2.xy
    dcl_texcoord1 o3.xyz
    if_ge -v1_abs.w, v1_abs.w
      mov r0.xy, c0
      mad r0.xyz, c65.x, r0.xxyw, v0
      add r0.w, c0.z, v2.x
      nrm r1.xyz, v1
      add r2.xyz, -r0.yzxw, c15.yzxw
      dp3 r1.w, r2, r2
      rsq r1.w, r1.w
      mul r2.xyz, r2, r1.w
      mul r3.xyz, r1.zxyw, r2
      mad r2.xyz, r1.yzxw, r2.yzxw, -r3
      nrm r3.xyz, r2
      mul r2.xyz, c64.x, v1
      mad r1.xyz, c65.x, r1, r2
      mul r2.xyz, r3, c65.x
      add r1.w, c0.w, -v2.y
      mul r1.xyz, -r1, r1.w
      mad r1.xyz, r0.w, r2, r1
      nrm r2.xyz, r1
      add r0.xyz, r0, r1
      mul r1, r0.y, c9
      mad r1, r0.x, c8, r1
      mad r1, r0.z, c10, r1
      add o0, r1, c11
      mov r1.xyz, c67
      mov o3.xyz, r0
      mov r0.w, c67.w
      mov r3.x, v2.x
      mov r1.w, r2.y
      mov r2.w, r2.z
    else
      mov r4.xy, c0
      mad r4, c65.z, r4.xxyx, v0
      add r3.zw, c0.z, v2.xyxy
      nrm r5.xyz, c12
      mul r5.xyz, r5, c65.z
      nrm r6.xyz, -c13
      mul r6.xyz, r6, c65.z
      mul r6.xyz, r3.w, r6
      mad r5.xyz, r3.z, r5, r6
      nrm r2.xyz, r5
      add r0.xyz, r4, r5
      mul r5, r0.y, c9
      mad r5, r0.x, c8, r5
      mad r5, r0.z, c10, r5
      add o0, r5, c11
      mad r3.z, r4.w, c66.x, -c66.y
      frc r3.w, r3.z
      add r4.x, r3.z, -r3.w
      slt r3.z, r3.z, -r3.z
      slt r3.w, -r3.w, r3.w
      mad r3.z, r3.z, r3.w, r4.x
      mul_sat r3.z, r3.z, c66.z
      mad r3.z, c66.z, v2.x, r3.z
      add r3.x, r3.z, c1.x
      mov r1.xyz, c68
      mov o3.xyz, r0
      mov r0.w, c68.w
      mov r1.w, r2.y
      mov r2.w, r2.z
    endif
    mul r4.xyz, r0.y, c5
    mad r4.xyz, r0.x, c4, r4
    mad r0.xyz, r0.z, c6, r4
    add r0.xyz, r0, c7
    mul r4.xyz, r1.w, c5
    mad r2.xyz, r2.x, c4, r4
    mad r2.xyz, r2.w, c6, r2
    add r4, -r0.x, c19
    add r5, -r0.y, c20
    add r6, -r0.z, c21
    mul r7, r4, r4
    mad r7, r5, r5, r7
    mad r7, r6, r6, r7
    add r8, r7, c1.y
    rsq r9.x, r8.x
    rsq r9.y, r8.y
    rsq r9.z, r8.z
    rsq r9.w, r8.w
    mov r0.z, c1.z
    mad r7, r7, -c25, r0.z
    max r7, r7, c0.x
    mul r7, r7, r7
    mad r7, r7, r7, c1.w
    max r7, r7, c0.x
    mul r7, r9, r7
    mul r7, r7, c2.x
    min r7, r7, c1.z
    mul r8, r4, -c22
    mad r8, r5, -c23, r8
    mad r8, r6, -c24, r8
    mul r8, r9, r8
    mov r10, c26
    mad_sat r8, r8, r10, c27
    mul r7, r7, r8
    mul r7, r9, r7
    mul r4, r4, r7
    mul r5, r5, r7
    mul r6, r6, r7
    mul r0.x, r7.x, c70.x
    dp3 r0.y, r2, -c17
    mad_sat r0.x, r0.y, c69.x, r0.x
    mul r0.xyz, r0.x, c18
    mul r4, r2.x, r4
    mad r4, r2.y, r5, r4
    mad r4, r2.z, r6, r4
    mad_sat r4, c70.x, r7.x, r4
    dp4 r5.x, c29, r4
    dp4 r5.y, c30, r4
    dp4 r5.z, c31, r4
    mad r0.xyz, r0, c18.w, r5
    dp3 r1.w, r2, c6
    mad_sat r1.w, r1.w, c0.z, c0.y
    mov r2.xyz, c38
    mad r2.xyz, r2, r1.w, c37
    mad r0.xyz, r2, c72.x, r0
    mul r0.xyz, r0, c71.x
    mul o1.xyz, r1, r0
    add r0.xyz, c15, -v0
    dp3 r0.x, r0, r0
    rsq r0.x, r0.x
    rcp r0.x, r0.x
    mul r0.x, r0.x, c2.y
    mul r0.y, r0.x, r0.x
    mul r0.x, r0.x, r0.y
    min r0.x, r0.x, c1.z
    mul o1.w, r0.w, r0.x
    mov r3.y, v2.y
    mov o2.xy, r3

// approximately 143 instruction slots used
 