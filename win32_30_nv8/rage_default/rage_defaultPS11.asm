// Summary: removed unnecessary stipple + improved shadow filter + restored normal offset bias + improved shadow fadeout + sped up forward fading
// Generated by Microsoft (R) HLSL Shader Compiler 9.26.952.2844
//
// Parameters:
//
//   sampler2D StippleTexture;
//   sampler2D TextureSampler;
//   float4 gDirectionalColour;
//   float4 gDirectionalLight;
//   float4 gFacetCentre;
//   float4 gLightAmbient0;
//   float4 gLightAmbient1;
//   float4 gLightColB;
//   float4 gLightColG;
//   float4 gLightColR;
//   float4 gLightConeOffset;
//   float4 gLightConeOffset2;
//   float4 gLightConeScale;
//   float4 gLightConeScale2;
//   float4 gLightDir2X;
//   float4 gLightDir2Y;
//   float4 gLightDir2Z;
//   float4 gLightDirX;
//   float4 gLightDirY;
//   float4 gLightDirZ;
//   float4 gLightFallOff;
//   float4 gLightPointColB;
//   float4 gLightPointColG;
//   float4 gLightPointColR;
//   float4 gLightPointFallOff;
//   float4 gLightPointPosX;
//   float4 gLightPointPosY;
//   float4 gLightPointPosZ;
//   float4 gLightPosX;
//   float4 gLightPosY;
//   float4 gLightPosZ;
//   row_major float4x4 gShadowMatrix;
//   float4 gShadowParam0123;
//   float4 gShadowParam14151617;
//   float4 gShadowParam18192021;
//   float4 gShadowParam4567;
//   float4 gShadowParam891113;
//   sampler2D gShadowZSamplerDir;
//   row_major float4x4 gViewInverse;
//   float4 globalScalars;
//   float specularColorFactor;
//   float specularFactor;
//
//
// Registers:
//
//   Name                 Reg   Size
//   -------------------- ----- ----
//   gViewInverse         c12      4
//   gDirectionalLight    c17      1
//   gDirectionalColour   c18      1
//   gLightPosX           c19      1
//   gLightPosY           c20      1
//   gLightPosZ           c21      1
//   gLightDirX           c22      1
//   gLightDirY           c23      1
//   gLightDirZ           c24      1
//   gLightFallOff        c25      1
//   gLightConeScale      c26      1
//   gLightConeOffset     c27      1
//   gLightColR           c29      1
//   gLightColG           c30      1
//   gLightColB           c31      1
//   gLightPointPosX      c32      1
//   gLightPointPosY      c33      1
//   gLightPointPosZ      c34      1
//   gLightPointColR      c35      1
//   gLightPointFallOff   c36      1
//   gLightAmbient0       c37      1
//   gLightAmbient1       c38      1
//   globalScalars        c39      1
//   gShadowParam18192021 c53      1
//   gFacetCentre         c54      1
//   gShadowParam14151617 c56      1
//   gShadowParam0123     c57      1
//   gShadowParam4567     c58      1
//   gShadowParam891113   c59      1
//   gShadowMatrix        c60      4
//   gLightPointColG      c64      1
//   gLightPointColB      c65      1
//   specularFactor       c66      1
//   gLightDir2X          c67      1
//   gLightDir2Y          c68      1
//   gLightDir2Z          c69      1
//   gLightConeScale2     c70      1
//   gLightConeOffset2    c71      1
//   specularColorFactor  c72      1
//   TextureSampler       s0       1
//   StippleTexture       s10      1
//   gShadowZSamplerDir   s15      1
//

    ps_3_0
    // -------------------------------------------------------------- Shadow Constants --------------------------------------------------------------
    def c110, -0.25, 1, -1, 0
    def c111, 0.159154937, 0.5, 6.28318548, -3.14159274
    def c112, 3, 7.13800001, 0.03125, 0
    def c113, 0.75, -0.5, 0.5, 0
    
    // def c114, 0.14, 0.24, 0.5, 0.75
    // def c115, 0.24, 0.44, 1.1, 1.15
    // def c116, 0.3, 0.54, 1.1, 0.95
    // def c117, 0.64, 1.04, 2.2, 2.3
    
    def c119, 0, 0.25, 0.5, 0.75 // UV clamps
    def c120, 0.2499, 0.4999, 0.7499, 1
    
    def c130, 0.18993645671348536, 0.027087114076591513, -0.21261242652069953, 0.23391293246949066
    def c131, 0.04771781344140756, -0.3666840644525993, 0.297730981239584, 0.398259878229082
    def c132, -0.509063425827436, -0.06528681462854097, 0.507855152944665, -0.2875976005206389
    def c133, -0.15230616564632418, 0.6426121151781916, -0.30240170651828074, -0.5805072900736001
    def c134, 0.6978019230005561, 0.2771173334141519, -0.6990963248129052, 0.3210960724922725
    def c135, 0.3565142601623699, -0.7066415061851589, 0.266890002328106, 0.8360191043249159
    def c136, -0.7515861305520581, -0.41609876195815027, 0.9102937449894895, -0.17014527555321657
    def c137, -0.5343471434373126, 0.8058593459499529, -0.1133270115046468, -0.9490025827627441
    // ----------------------------------------------------------------------------------------------------------------------------------------------
    def c219, 1.8395173895e+25, 3.9938258725e+24, 4.5435787456e+30, 1.1070257868e-42 // 790
    def c127, 0.9999999, 1, 0, 0 // LogDepth constants
    def c0, 9.99999975e-006, -0.5, 0.5, -0.25
    def c1, 1.33333337, 1, 0, 1.5
    def c2, 4, 0.125, 9.99999975e-005, 0
    def c3, 0.0833333358, -0.100000001, 1.11111116, 3.99600005
    def c4, 1, -1, 0, -0
    def c5, -0.321940005, -0.932614982, -0.791558981, -0.597710013
    def c6, 0.507430971, 0.0644249991, 0.896420002, 0.412458003
    def c7, 0.519456029, 0.767022014, 0.185461, -0.893123984
    def c8, 0.962339997, -0.194983006, 0.473434001, -0.480026007
    def c9, -0.69591397, 0.457136989, -0.203345001, 0.620715976
    def c10, -0.326211989, -0.405809999, -0.840143979, -0.0735799968
    def c46, 2, 0, 0, 0
    dcl_texcoord v0.xy
    dcl_texcoord1 v1.xyz
    dcl_texcoord3 v2.xyz
    dcl_color v3
    dcl_texcoord6 v4.xyz
    dcl vPos.xy
    dcl_texcoord9 v9
    dcl_2d s0
    dcl_2d s10
    dcl_2d s15
    mov r31.w, c39.x
    mul_sat r31.w, r31.w, c46.x
    texld r0, v0, s0
    add r1.xyz, c0.x, v1
    nrm r2.xyz, r1
    mul r0, r0, v3
    mad_sat r1.x, r2.z, c0.y, c0.z
    mov r3.xyz, c38
    mad r1.xyz, r3, r1.x, c37
    mul r3.xyz, c18.w, c18
    dp3 r1.w, r2, -c17
    mul r22.xyz, r2.y, c61.xyww
    mad r22.xyz, r2.x, c60.xyww, r22
    mad r22.xyz, r2.z, c62.xyww, r22
    add r1.w, r1.w, c0.w
    mul_sat r1.w, r1.w, c1.x
    mul r4.xyz, c61.xyww, v4.y
    mad r4.xyz, v4.x, c60.xyww, r4
    mad r4.xyz, v4.z, c62.xyww, r4
    add r4.xyz, r4, c63.xyww
    dp3 r2.w, c14, v4
    add r5.xyz, -r2.w, -c54
    cmp r5.yzw, r5.xxyz, c1.y, c1.z
    mov r5.x, c1.y
    mad r21, r5, c110.yyyw, -r5.yzww // shadow cascade mask
    // ---------------------------------------------------------------- Shadow Fixes -----------------------------------------------------------------
    // m4x4 r20, r21_abs, c114
    // dp4 r20.x, r20, c220
    // add r1.z, r1.z, -r20.x
    
    add r20, c54.w, -c54
    add r20, c53.w, -r20 // cascade ranges
    dp4 r23.x, r21_abs, r20
    dp4 r23.y, r21_abs, r20.yzww
    
    mad r24, r20.xxyz, -c110.wyyy, r20
    dp4 r24.x, r21_abs, r24 // curr_range - prev_range
    mul r24.x, r24.x, c218_abs.z
    rcp r24.y, r24.x
    add r24.x, r23.x, -r24.x
    add r24.x, v9.w, -r24.x
    mul_sat r22.w, r24.x, r24.y // blending factor
    
    rcp r23.w, r23.x
    mul r23.w, r23.y, r23.w
    mov r23.z, c110.y
    
    lrp r20.xy, r22.w, r23.yw, r23.xz
    mul r20.xy, r20.xy, c53.z // scale bias and blur with resolution
    
    mul r20.xy, r20.xy, c218_abs.yx
    mul r20.x, r20.x, c223.y // scale bias with FOV
    mad r4.xyz, r22.xyz, r20.x, r4 // normal offset bias
    
    rcp r20.x, c58.x
    mul r20.x, r20.x, c57.x
    mul r20.x, r20.x, r20.y // fix filter stretching
    
    dp4 r20.z, r21_abs, c119 // fix pixels leaking into other cascades
    dp4 r20.w, r21_abs, c120
    // ----------------------------------------------------------------------------------------------------------------------------------------------
    dp4 r6.x, r5, c57
    dp4 r6.y, r5, c58
    dp4 r7.x, r5, c59
    dp4 r7.y, r5, c56
    mad r4.xy, r4, r6, r7
    add r5.xyz, c15, -v4
    dp3 r2.w, r5, r5
    rsq r2.w, r2.w
    rcp r2.w, r2.w
    /* removed 1.0.6.0 filter
    rcp r3.w, c53.w
    mul r3.w, r2.w, r3.w
    mul r3.w, r3.w, r3.w
    mul r3.w, r3.w, c1.w
    mov r5.y, c53.y
    mad r5.xz, r5.y, c10.xyyw, r4.xyyw
    texld r6, r5.xzzw, s15
    add r4.w, r4.z, -r6.x
    cmp r4.w, r4.w, c1.y, c1.z
    mad r5.xz, r5.y, c10.zyww, r4.xyyw
    texld r6, r5.xzzw, s15
    add r5.x, r4.z, -r6.x
    cmp r5.x, r5.x, c1.y, c1.z
    add r4.w, r4.w, r5.x
    mad r5.xz, r5.y, c9.xyyw, r4.xyyw
    texld r6, r5.xzzw, s15
    add r5.x, r4.z, -r6.x
    cmp r5.x, r5.x, c1.y, c1.z
    add r4.w, r4.w, r5.x
    mad r5.xz, r5.y, c9.zyww, r4.xyyw
    texld r6, r5.xzzw, s15
    add r5.x, r4.z, -r6.x
    cmp r5.x, r5.x, c1.y, c1.z
    add r4.w, r4.w, r5.x
    mad r5.xz, r5.y, c8.xyyw, r4.xyyw
    texld r6, r5.xzzw, s15
    add r5.x, r4.z, -r6.x
    cmp r5.x, r5.x, c1.y, c1.z
    add r4.w, r4.w, r5.x
    mad r5.xz, r5.y, c8.zyww, r4.xyyw
    texld r6, r5.xzzw, s15
    add r5.x, r4.z, -r6.x
    cmp r5.x, r5.x, c1.y, c1.z
    add r4.w, r4.w, r5.x
    mad r5.xz, r5.y, c7.xyyw, r4.xyyw
    texld r6, r5.xzzw, s15
    add r5.x, r4.z, -r6.x
    cmp r5.x, r5.x, c1.y, c1.z
    add r4.w, r4.w, r5.x
    mad r5.xz, r5.y, c7.zyww, r4.xyyw
    texld r6, r5.xzzw, s15
    add r5.x, r4.z, -r6.x
    cmp r5.x, r5.x, c1.y, c1.z
    add r4.w, r4.w, r5.x
    mad r5.xz, r5.y, c6.xyyw, r4.xyyw
    texld r6, r5.xzzw, s15
    add r5.x, r4.z, -r6.x
    cmp r5.x, r5.x, c1.y, c1.z
    add r4.w, r4.w, r5.x
    mad r5.xz, r5.y, c6.zyww, r4.xyyw
    texld r6, r5.xzzw, s15
    add r5.x, r4.z, -r6.x
    cmp r5.x, r5.x, c1.y, c1.z
    add r4.w, r4.w, r5.x
    mad r5.xz, r5.y, c5.xyyw, r4.xyyw
    texld r6, r5.xzzw, s15
    add r5.x, r4.z, -r6.x
    cmp r5.x, r5.x, c1.y, c1.z
    add r4.w, r4.w, r5.x
    mad r4.xy, r5.y, c5.zwzw, r4
    texld r5, r4, s15
    add r4.x, r4.z, -r5.x
    cmp r4.x, r4.x, c1.y, c1.z
    add r4.x, r4.w, r4.x
    mad r3.w, r4.x, c3.x, r3.w
    add r2.w, r2.w, -c53.w
    cmp r4.xy, r2.w, c4, c4.zwzw
    add r2.w, r3.w, r4.y
    cmp_sat r2.w, r2.w, r3.w, r4.x
    removed 1.0.6.0 filter */
    // ---------------------------------------------------------- Improved Shadow Filter ------------------------------------------------------------
    mov r21.x, c110.y
    if_lt c221.x, r21.x
      dp2add r21.y, vPos, c112.xy, c112.w
      mad r21.y, r21.y, c111.x, c111.y
      frc r21.y, r21.y
      mad r21.y, r21.y, c111.z, c111.w
      sincos r22.xy, r21.y
      mul r21, r22.yxxy, c110.xxyz
      mul r22, r22.yxxy, c113.xxyz
      mad r21, r21, r20.xyxy, r4.xyxy
      mad r22, r22, r20.xyxy, r4.xyxy
      max r21.xz, r21, r20.z
      min r21.xz, r21, r20.w
      max r22.xz, r22, r20.z
      min r22.xz, r22, r20.w
      texldl r24, r21.xy, s15
      texldl r23, r22.zw, s15
      mov r24.y, r23.x
      texldl r23, r22.xy, s15
      mov r24.z, r23.x
      texldl r23, r21.zw, s15
      mov r24.w, r23.x
      add r24, r4.z, -r24
      cmp r24, r24, c110.y, c110.w
      dp4 r20.x, r24, -c110.x
    else
      mul r21.xy, vPos.xy, c112.z
      texldl r21, r21, s10
      mul r21.x, r21.z, c111.z
      sincos r22.xy, r21.x
      mul r22, r22.xyyx, c110.yzyy
      
      mul r21, c130.xyxy, r22
      add r23.xy, r21.xzxz, r21.ywyw
      mul r21, c130.zwzw, r22
      add r23.zw, r21.xzxz, r21.ywyw
      mad r21, r23, r20.xyxy, r4.xyxy
      max r21.xz, r21, r20.z
      min r21.xz, r21, r20.w
      texldl r24, r21.xy, s15
      texldl r23, r21.zw, s15
      mov r24.y, r23.x
      mul r21, c131.xyxy, r22
      add r23.xy, r21.xzxz, r21.ywyw
      mul r21, c131.zwzw, r22
      add r23.zw, r21.xzxz, r21.ywyw
      mad r21, r23, r20.xyxy, r4.xyxy
      max r21.xz, r21, r20.z
      min r21.xz, r21, r20.w
      texldl r23, r21.xy, s15
      mov r24.z, r23.x
      texldl r23, r21.zw, s15
      mov r24.w, r23.x
      add r24, r4.z, -r24
      cmp r24, r24, c110.y, c110.w
      dp4 r25.x, r24, -c110.x
      
      mul r21, c132.xyxy, r22
      add r23.xy, r21.xzxz, r21.ywyw
      mul r21, c132.zwzw, r22
      add r23.zw, r21.xzxz, r21.ywyw
      mad r21, r23, r20.xyxy, r4.xyxy
      max r21.xz, r21, r20.z
      min r21.xz, r21, r20.w
      texldl r24, r21.xy, s15
      texldl r23, r21.zw, s15
      mov r24.y, r23.x
      mul r21, c133.xyxy, r22
      add r23.xy, r21.xzxz, r21.ywyw
      mul r21, c133.zwzw, r22
      add r23.zw, r21.xzxz, r21.ywyw
      mad r21, r23, r20.xyxy, r4.xyxy
      max r21.xz, r21, r20.z
      min r21.xz, r21, r20.w
      texldl r23, r21.xy, s15
      mov r24.z, r23.x
      texldl r23, r21.zw, s15
      mov r24.w, r23.x
      add r24, r4.z, -r24
      cmp r24, r24, c110.y, c110.w
      dp4 r25.y, r24, -c110.x
      
      mul r21, c134.xyxy, r22
      add r23.xy, r21.xzxz, r21.ywyw
      mul r21, c134.zwzw, r22
      add r23.zw, r21.xzxz, r21.ywyw
      mad r21, r23, r20.xyxy, r4.xyxy
      max r21.xz, r21, r20.z
      min r21.xz, r21, r20.w
      texldl r24, r21.xy, s15
      texldl r23, r21.zw, s15
      mov r24.y, r23.x
      mul r21, c135.xyxy, r22
      add r23.xy, r21.xzxz, r21.ywyw
      mul r21, c135.zwzw, r22
      add r23.zw, r21.xzxz, r21.ywyw
      mad r21, r23, r20.xyxy, r4.xyxy
      max r21.xz, r21, r20.z
      min r21.xz, r21, r20.w
      texldl r23, r21.xy, s15
      mov r24.z, r23.x
      texldl r23, r21.zw, s15
      mov r24.w, r23.x
      add r24, r4.z, -r24
      cmp r24, r24, c110.y, c110.w
      dp4 r25.z, r24, -c110.x
      
      mul r21, c136.xyxy, r22
      add r23.xy, r21.xzxz, r21.ywyw
      mul r21, c136.zwzw, r22
      add r23.zw, r21.xzxz, r21.ywyw
      mad r21, r23, r20.xyxy, r4.xyxy
      max r21.xz, r21, r20.z
      min r21.xz, r21, r20.w
      texldl r24, r21.xy, s15
      texldl r23, r21.zw, s15
      mov r24.y, r23.x
      mul r21, c137.xyxy, r22
      add r23.xy, r21.xzxz, r21.ywyw
      mul r21, c137.zwzw, r22
      add r23.zw, r21.xzxz, r21.ywyw
      mad r21, r23, r20.xyxy, r4.xyxy
      max r21.xz, r21, r20.z
      min r21.xz, r21, r20.w
      texldl r23, r21.xy, s15
      mov r24.z, r23.x
      texldl r23, r21.zw, s15
      mov r24.w, r23.x
      add r24, r4.z, -r24
      cmp r24, r24, c110.y, c110.w
      dp4 r25.w, r24, -c110.x
      
      dp4 r20.x, r25, -c110.x
    endif
    // ----------------------------------------------------------------------------------------------------------------------------------------------
    // -------------------------------------------------------------- Improved Fadeout --------------------------------------------------------------
    rcp r20.y, c53.w
    mul_sat r20.y, r20.y, r2.w
    mul r20.y, r20.y, r20.y
    lrp r2.w, r20.y, c110.y, r20.x // improved fadeout
    // ----------------------------------------------------------------------------------------------------------------------------------------------
    mul r4.xyz, r3, r1.w
    mul r4.xyz, r2.w, r4
    mad r1.xyz, r1, v3.x, r4
    add r4, c19, -v4.x
    add r5, c20, -v4.y
    add r6, c21, -v4.z
    mul r7, r4, r4
    mad r7, r5, r5, r7
    mad r7, r6, r6, r7
    add r8, r7, c0.x
    rsq r9.x, r8.x
    rsq r9.y, r8.y
    rsq r9.z, r8.z
    rsq r9.w, r8.w
    mov r8.y, c1.y
    mad r7, r7, -c25, r8.y
    max r10, r7, c1.z
    mul r7, r10, r10
    mad r7, r7, r7, c3.y
    mul r10, r7, c3.z
    cmp r7, r7, r10, c1.z
    mul r10, r2.x, r4
    mad r10, r5, r2.y, r10
    mad r10, r6, r2.z, r10
    mul r7, r7, r10
    mul_sat r7, r9, r7
    mul r10, r4, -c22
    mad r10, r5, -c23, r10
    mad r10, r6, -c24, r10
    mul r10, r9, r10
    mov r11, c26
    mad_sat r10, r10, r11, c27
    mul r7, r7, r10
    dp4 r10.x, c29, r7
    dp4 r10.y, c30, r7
    dp4 r10.z, c31, r7
    add r1.xyz, r1, r10
    add r10, c32, -v4.x
    add r11, c33, -v4.y
    add r12, c34, -v4.z
    mul r13, r10, r10
    mad r13, r11, r11, r13
    mad r13, r12, r12, r13
    add r14, r13, c0.x
    rsq r15.x, r14.x
    rsq r15.y, r14.y
    rsq r15.z, r14.z
    rsq r15.w, r14.w
    mad r8, r13, -c36, r8.y
    max r13, r8, c1.z
    mul r8, r13, r13
    mad r8, r8, r8, c3.y
    mul r13, r8, c3.z
    cmp r8, r8, r13, c1.z
    mul r13, r2.x, r10
    mad r13, r11, r2.y, r13
    mad r13, r12, r2.z, r13
    mul r8, r8, r13
    mul_sat r8, r15, r8
    mul r13, r10, -c67
    mad r13, r11, -c68, r13
    mad r13, r12, -c69, r13
    mul r13, r15, r13
    mov r14, c70
    mad_sat r13, r13, r14, c71
    mul r8, r8, r13
    dp4 r13.x, c35, r8
    dp4 r13.y, c64, r8
    dp4 r13.z, c65, r8
    add r1.xyz, r1, r13
    mov r1.w, c1.y
    mul r0, r0, r1
    mul r0.w, r0.w, r31.w
    /* removed stipple
    mov_sat r1.x, r0.w
    mul r1.x, r1.x, c3.w
    frc r1.y, r1.x
    mul r1.z, r1.y, c2.x
    frc r1.w, r1.z
    add r13.xy, r1.zxzw, -r1.wyzw
    mul r1.xy, c2.y, vPos
    frc r1.xy, r1_abs
    cmp r1.xy, vPos, r1, -r1
    mul r1.xy, r1, -c0.w
    mad r1.xy, r13, -c0.w, r1
    mov r1.zw, c1.z
    texldl r1, r1, s10
    cmp r1, -r1.y, -c1.y, -c1.z
    texkill r1
    removed stipple */
    add r1.xyz, c0.x, v2
    nrm r13.xyz, r1
    dp3 r1.x, -r13, r2
    add r1.x, r1.x, r1.x
    mad r1.xyz, r2, -r1.x, -r13
    dp3_sat r1.w, -c17, r1
    add r1.w, r1.w, c2.z
    mov r2.z, c2.z
    add r2.x, r2.z, c66.x
    pow r3.w, r1.w, r2.x
    mul r2.xyz, r3, r3.w
    mul r2.xyz, r2.w, r2
    mov r1.w, c0.w
    mul r1.w, -r1.w, c66.x
    mul r3, r4, r1.x
    mad r3, r1.y, r5, r3
    mad r3, r1.z, r6, r3
    mul r3, r9, r3
    log r4.x, r3_abs.x
    log r4.y, r3_abs.y
    log r4.z, r3_abs.z
    log r4.w, r3_abs.w
    mul r3, r1.w, r4
    exp r4.x, r3.x
    exp r4.y, r3.y
    exp r4.z, r3.z
    exp r4.w, r3.w
    mul r3, r7, r4
    dp4 r4.x, c29, r3
    dp4 r4.y, c30, r3
    dp4 r4.z, c31, r3
    mad r2.xyz, r2, c17.w, r4
    mul r3, r10, r1.x
    mad r3, r1.y, r11, r3
    mad r3, r1.z, r12, r3
    mul r3, r15, r3
    log r4.x, r3_abs.x
    log r4.y, r3_abs.y
    log r4.z, r3_abs.z
    log r4.w, r3_abs.w
    mul r1, r1.w, r4
    exp r3.x, r1.x
    exp r3.y, r1.y
    exp r3.z, r1.z
    exp r3.w, r1.w
    mul r1, r8, r3
    dp4 r3.x, c35, r1
    dp4 r3.y, c64, r1
    dp4 r3.z, c65, r1
    add r1.xyz, r2, r3
    mad oC0.xyz, c72.x, r1, r0
    mov oC0.w, r0.w
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

// approximately 244 instruction slots used (15 texture, 229 arithmetic)
