// Summary: Disabled PC parameters that cause the dirt level in vehicle.ide to affect reflection intensity + improved shadow filter + restored normal offset bias + improved shadow fadeout
// Generated by Microsoft (R) HLSL Shader Compiler 9.26.952.2844
//
// Parameters:
//
//   sampler2D DirtSampler;
//   float3 LuminanceConstants;
//   sampler2D SpecSampler;
//   sampler2D TextureSampler;
//   float3 dirtColor;
//   float dirtLevel;
//   float4 gDepthFxParams;
//   float4 gDirectionalColour;
//   float4 gDirectionalLight;
//   float4 gFacetCentre;
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
//   row_major float4x4 gShadowMatrix;
//   float4 gShadowParam0123;
//   float4 gShadowParam14151617;
//   float4 gShadowParam18192021;
//   float4 gShadowParam4567;
//   float4 gShadowParam891113;
//   sampler2D gShadowZSamplerDir;
//   row_major float4x4 gViewInverse;
//   float4 globalFogColor;
//   float4 globalFogColorN;
//   float4 globalFogParams;
//   float4 globalScalars;
//   float3 matDiffuseColor;
//   float reflectivePowerED;
//   float3 specMapIntMask;
//   float specularColorFactor;
//   float specularFactor;
//
//
// Registers:
//
//   Name                 Reg   Size
//   -------------------- ----- ----
//   gViewInverse         c12      4
//   gDepthFxParams       c16      1
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
//   gLightAmbient0       c37      1
//   gLightAmbient1       c38      1
//   globalScalars        c39      1
//   globalFogParams      c41      1
//   globalFogColor       c42      1
//   globalFogColorN      c43      1
//   gShadowParam18192021 c53      1
//   gFacetCentre         c54      1
//   gShadowParam14151617 c56      1
//   gShadowParam0123     c57      1
//   gShadowParam4567     c58      1
//   gShadowParam891113   c59      1
//   gShadowMatrix        c60      4
//   matDiffuseColor      c66      1
//   dirtLevel            c72      1
//   dirtColor            c73      1
//   specularFactor       c74      1
//   specularColorFactor  c75      1
//   specMapIntMask       c76      1
//   reflectivePowerED    c77      1
//   LuminanceConstants   c78      1
//   TextureSampler       s0       1
//   DirtSampler          s1       1
//   SpecSampler          s2       1
//   gShadowZSamplerDir   s15      1
//

    ps_3_0
	// -------------------------------------------------------------- Shadow Constants --------------------------------------------------------------
    def c110, -0.25, 1, -1, 0
    def c111, 0.159154937, 0.5, 6.28318548, -3.14159274
    def c112, 3, 7.13800001, 0.03125, 0
    def c113, 0.75, -0.5, 0.5, 0
	
    def c114, 0.14, 0.24, 0.5, 0.75 // static bias
    def c115, 0.24, 0.44, 1.1, 1.15
    def c116, 0.3, 0.54, 1.1, 0.95
    def c117, 0.64, 1.04, 2.2, 2.3
	
	def c118, 8, 0.3, 0, 0 // normal offset bias and blend params
	
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
    def c219, 1.8395173895e+25, 3.9938258725e+24, 4.5435787456e+30, 1.0089348943e-42 // 720
    def c127, 0.9999999, 1, 0, 0	// LogDepth constants
    def c0, 9.99999975e-006, 0, 1, -0
    def c1, -0.5, 0.5, -0.25, 1.33333337
    def c2, 9.99999975e-005, 1.5, -0.326211989, -0.405809999
    def c3, -0.791558981, -0.597710013, 0.0833333358, -0.100000001
    def c4, 1, -1, 0, -0
    def c5, 1.11111116, 0.212500006, 0.715399981, 0.0720999986
    def c6, 1.00000001e-007, 0, 0, 0
    def c7, 0.896420002, 0.412458003, -0.321940005, -0.932614982
    def c8, 0.185461, -0.893123984, 0.507430971, 0.0644249991
    def c9, 0.473434001, -0.480026007, 0.519456029, 0.767022014
    def c10, -0.203345001, 0.620715976, 0.962339997, -0.194983006
    def c11, -0.840143979, -0.0735799968, -0.69591397, 0.457136989
    def c77, 1, 1, 1, 1 // disable IDE dirt influence
    dcl vPos.xy
    dcl_texcoord v0.xy
    dcl_texcoord1 v1
    dcl_texcoord3 v2.xyz
    dcl_color v3
    dcl_texcoord2 v4.xyz
    dcl_texcoord9 v9
    dcl_2d s0
    dcl_2d s1
    dcl_2d s2
    dcl_2d s10
    dcl_2d s15
    texld r0, v0, s0
    add r1.xyz, c0.x, v1
    nrm r2.xyz, r1
    texld r1, v0, s2
    mul r1.w, r1.w, c74.x
    mul r2.w, r1.w, c77.x
    dp3 r1.x, r1, c76
    mul r1.x, r1.x, c75.x
    mul r1.x, r1.x, c77.x
    mul r0.xyz, r0, c66
    mul r0, r0, v3
    dp3 r1.y, v3, c78
    mul r1.y, r1.y, c39.z
    mov r3.yz, c0
    if_lt -c72.x, r3.y
      texld r4, v0, s1
      mul r1.z, r4.x, c72.x
      mad r5.x, r4.x, -c72.x, r3.z
      lrp r5.yzw, r1.z, c73.xxyz, r0.xxyz
      mad r6, r0.xxyz, c0.yzzz, c0.zwww
      cmp r4, -r4.x, r6, r5
      mov r0.xyz, r4.yzww
    else
      mov r4.x, c0.z
    endif
    mul r1.x, r1.x, r4.x
    add r3.xyw, c0.x, v2.xyzz
    nrm r4.xyz, r3.xyww
    mad_sat r1.z, r2.z, c1.x, c1.y
    mov r5.xyz, c38
    mad r3.xyw, r5.xyzz, r1.z, c37.xyzz
    dp3 r1.z, -r4, r2
    add r1.z, r1.z, r1.z
    mad r5.xyz, r2, -r1.z, -r4
    mul r6.xyz, c18.w, c18
    dp3 r1.z, r2, -c17
    mul r20.xyz, r2.y, c61.xyww
    mad r20.xyz, r2.x, c60.xyww, r20
    mad r20.xyz, r2.z, c62.xyww, r20
    add r1.z, r1.z, c1.z
    mul_sat r1.z, r1.z, c1.w
    dp3_sat r4.w, -c17, r5
    add r4.w, r4.w, c2.x
    mov r7.xzw, c2
    mad r1.w, r1.w, c77.x, r7.x
    pow r5.w, r4.w, r1.w
    mul r8.xyz, c61.xyww, v4.y
    mad r8.xyz, v4.x, c60.xyww, r8
    mad r8.xyz, v4.z, c62.xyww, r8
    add r8.xyz, r8, c63.xyww
    dp3 r1.w, c14, v4
    add r9.xyz, -r1.w, -c54
    cmp r9.yzw, r9.xxyz, c0.z, c0.y
    mov r9.x, c0.z
    mad r21, r9, c110.yyyw, -r9.yzww // shadow cascade mask
    // ---------------------------------------------------------------- Shadow Fixes -----------------------------------------------------------------
    add r22, c54.w, -c54
    add r22, c53.w, -r22 // cascade ranges
    dp4 r23.x, r21_abs, r22
    dp4 r23.y, r21_abs, r22.yzww
    
    rcp r23.z, r22.x
    mul r23.zw, r23.xyxy, r23.z // (curr_range, next_range) / first_range
    mul r24.x, r22.x, c53.y
    mul r24.x, r24.x, c218_abs.y
    mul r23.zw, r23, r24.x // bias magnitude
    
    mad r24, r22.xxyz, -c110.wyyy, r22
    dp4 r24.x, r21_abs, r24 // curr_range - prev_range
    mul r24.x, r24.x, c218_abs.z
    rcp r24.z, r24.x
    add r24.x, r23.x, -r24.x
    add r24.x, v9.w, -r24.x
    mul_sat r24.x, r24.x, r24.z // blending factor
    
    rcp r24.z, r23.x
    mul r23.xy, r23.xy, r24.z // 1.0, next_range / curr_range
    
    lrp r22.xy, r24.x, r23.yw, r23.xz
    
    m4x4 r24, r21_abs, c114
    dp4 r24.x, r24, c220
    add r8.z, r8.z, -r24.x // undo static bias
    
    mul r22.y, r22.y, c223.y // scale bias with FOV
    mad r8.xyz, r20.xyz, r22.y, r8 // normal offset bias
    
    mul r20.xy, r22.x, c53.y
    rcp r20.x, c58.x
    mul r20.x, r20.x, c57.x
    mul r20.x, r20.x, r20.y // fix filter stretching
    
    mul r20.xy, r20.xy, c218_abs.x
    
    dp4 r20.z, r21_abs, c119 // fix pixels leaking into other cascades
    dp4 r20.w, r21_abs, c120
    // ----------------------------------------------------------------------------------------------------------------------------------------------
    dp4 r7.x, r9, c57
    dp4 r7.y, r9, c58
    dp4 r10.x, r9, c59
    dp4 r10.y, r9, c56
    mad r7.xy, r8, r7, r10
    add r8.xyw, c15.xyzz, -v4.xyzz
    dp3 r1.w, r8.xyww, r8.xyww
    rsq r1.w, r1.w
    rcp r1.w, r1.w
    /* removed 1.0.6.0 filter
    rcp r4.w, c53.w
    mul r4.w, r1.w, r4.w
    mul r4.w, r4.w, r4.w
    mul r4.w, r4.w, c2.y
    mad r7.zw, c53.y, r7, r7.xyxy
    texld r9, r7.zwzw, s15
    add r6.w, r8.z, -r9.x
    cmp r6.w, r6.w, c0.z, c0.y
    mov r8.y, c53.y
    mad r7.zw, r8.y, c11.xyxy, r7.xyxy
    texld r9, r7.zwzw, s15
    add r7.z, r8.z, -r9.x
    cmp r7.z, r7.z, c0.z, c0.y
    add r6.w, r6.w, r7.z
    mad r7.zw, r8.y, c11, r7.xyxy
    texld r9, r7.zwzw, s15
    add r7.z, r8.z, -r9.x
    cmp r7.z, r7.z, c0.z, c0.y
    add r6.w, r6.w, r7.z
    mad r7.zw, r8.y, c10.xyxy, r7.xyxy
    texld r9, r7.zwzw, s15
    add r7.z, r8.z, -r9.x
    cmp r7.z, r7.z, c0.z, c0.y
    add r6.w, r6.w, r7.z
    mad r7.zw, r8.y, c10, r7.xyxy
    texld r9, r7.zwzw, s15
    add r7.z, r8.z, -r9.x
    cmp r7.z, r7.z, c0.z, c0.y
    add r6.w, r6.w, r7.z
    mad r7.zw, r8.y, c9.xyxy, r7.xyxy
    texld r9, r7.zwzw, s15
    add r7.z, r8.z, -r9.x
    cmp r7.z, r7.z, c0.z, c0.y
    add r6.w, r6.w, r7.z
    mad r7.zw, r8.y, c9, r7.xyxy
    texld r9, r7.zwzw, s15
    add r7.z, r8.z, -r9.x
    cmp r7.z, r7.z, c0.z, c0.y
    add r6.w, r6.w, r7.z
    mad r7.zw, r8.y, c8.xyxy, r7.xyxy
    texld r9, r7.zwzw, s15
    add r7.z, r8.z, -r9.x
    cmp r7.z, r7.z, c0.z, c0.y
    add r6.w, r6.w, r7.z
    mad r7.zw, r8.y, c8, r7.xyxy
    texld r9, r7.zwzw, s15
    add r7.z, r8.z, -r9.x
    cmp r7.z, r7.z, c0.z, c0.y
    add r6.w, r6.w, r7.z
    mad r7.zw, r8.y, c7.xyxy, r7.xyxy
    texld r9, r7.zwzw, s15
    add r7.z, r8.z, -r9.x
    cmp r7.z, r7.z, c0.z, c0.y
    add r6.w, r6.w, r7.z
    mad r7.zw, r8.y, c7, r7.xyxy
    texld r9, r7.zwzw, s15
    add r7.z, r8.z, -r9.x
    cmp r7.z, r7.z, c0.z, c0.y
    add r6.w, r6.w, r7.z
    mad r7.xy, r8.y, c3, r7
    texld r7, r7, s15
    add r7.x, r8.z, -r7.x
    cmp r7.x, r7.x, c0.z, c0.y
    add r6.w, r6.w, r7.x
    mad r4.w, r6.w, c3.z, r4.w
    add r1.w, r1.w, -c53.w
    cmp r7.xy, r1.w, c4, c4.zwzw
    add r1.w, r4.w, r7.y
    cmp_sat r1.w, r1.w, r4.w, r7.x
    removed 1.0.6.0 filter */
	// ---------------------------------------------------------- Improved Shadow Filter ------------------------------------------------------------
	mov r21.x, c110.y
	if_lt c223.z, r21.x
		dp2add r21.y, vPos, c112.xy, c112.w
		mad r21.y, r21.y, c111.x, c111.y
		frc r21.y, r21.y
		mad r21.y, r21.y, c111.z, c111.w
		sincos r22.xy, r21.y
		mul r23, r22.yxxy, c110.xxyz
		mul r21, r22.yxxy, c113.xxyz
		mad r23, r23, r20.xyxy, r7.xyxy
		mad r21, r21, r20.xyxy, r7.xyxy
		max r23.xz, r23, r20.z
		min r23.xz, r23, r20.w
		max r21.xz, r21, r20.z
		min r21.xz, r21, r20.w
		texldl r25, r23.xy, s15
		texldl r24, r21.zw, s15
		mov r25.y, r24.x
		texldl r24, r21.xy, s15
		mov r25.z, r24.x
		texldl r24, r23.zw, s15
		mov r25.w, r24.x
		add r25, r8.z, -r25
		cmp r25, r25, c110.y, c110.w
		dp4 r20.x, r25, -c110.x
	else
		mul r24.xy, vPos.xy, c112.z
		texldl r24, r24, s10
		mul r24.x, r24.z, c111.z
		sincos r25.xy, r24.x
		mul r25, r25.xyyx, c110.yzyy
		mul r26, c130.xyxy, r25
		add r27.xy, r26.xzxz, r26.ywyw
		mul r26, c130.zwzw, r25
		add r27.zw, r26.xzxz, r26.ywyw
		mad r26, r27, r20.xyxy, r7.xyxy
		max r26.xz, r26, r20.z
		min r26.xz, r26, r20.w
		texldl r28, r26.xy, s15
		texldl r27, r26.zw, s15
		mov r28.y, r27.x
		mul r26, c131.xyxy, r25
		add r27.xy, r26.xzxz, r26.ywyw
		mul r26, c131.zwzw, r25
		add r27.zw, r26.xzxz, r26.ywyw
		mad r26, r27, r20.xyxy, r7.xyxy
		max r26.xz, r26, r20.z
		min r26.xz, r26, r20.w
		texldl r27, r26.xy, s15
		mov r28.z, r27.x
		texldl r27, r26.zw, s15
		mov r28.w, r27.x
		add r28, r8.z, -r28
		cmp r28, r28, c110.y, c110.w
		dp4 r29.x, r28, -c110.x
		mul r26, c132.xyxy, r25
		add r27.xy, r26.xzxz, r26.ywyw
		mul r26, c132.zwzw, r25
		add r27.zw, r26.xzxz, r26.ywyw
		mad r26, r27, r20.xyxy, r7.xyxy
		max r26.xz, r26, r20.z
		min r26.xz, r26, r20.w
		texldl r28, r26.xy, s15
		texldl r27, r26.zw, s15
		mov r28.y, r27.x
		mul r26, c133.xyxy, r25
		add r27.xy, r26.xzxz, r26.ywyw
		mul r26, c133.zwzw, r25
		add r27.zw, r26.xzxz, r26.ywyw
		mad r26, r27, r20.xyxy, r7.xyxy
		max r26.xz, r26, r20.z
		min r26.xz, r26, r20.w
		texldl r27, r26.xy, s15
		mov r28.z, r27.x
		texldl r27, r26.zw, s15
		mov r28.w, r27.x
		add r28, r8.z, -r28
		cmp r28, r28, c110.y, c110.w
		dp4 r29.y, r28, -c110.x
		mul r26, c134.xyxy, r25
		add r27.xy, r26.xzxz, r26.ywyw
		mul r26, c134.zwzw, r25
		add r27.zw, r26.xzxz, r26.ywyw
		mad r26, r27, r20.xyxy, r7.xyxy
		max r26.xz, r26, r20.z
		min r26.xz, r26, r20.w
		texldl r28, r26.xy, s15
		texldl r27, r26.zw, s15
		mov r28.y, r27.x
		mul r26, c135.xyxy, r25
		add r27.xy, r26.xzxz, r26.ywyw
		mul r26, c135.zwzw, r25
		add r27.zw, r26.xzxz, r26.ywyw
		mad r26, r27, r20.xyxy, r7.xyxy
		max r26.xz, r26, r20.z
		min r26.xz, r26, r20.w
		texldl r27, r26.xy, s15
		mov r28.z, r27.x
		texldl r27, r26.zw, s15
		mov r28.w, r27.x
		add r28, r8.z, -r28
		cmp r28, r28, c110.y, c110.w
		dp4 r29.z, r28, -c110.x
		mul r26, c136.xyxy, r25
		add r27.xy, r26.xzxz, r26.ywyw
		mul r26, c136.zwzw, r25
		add r27.zw, r26.xzxz, r26.ywyw
		mad r26, r27, r20.xyxy, r7.xyxy
		max r26.xz, r26, r20.z
		min r26.xz, r26, r20.w
		texldl r28, r26.xy, s15
		texldl r27, r26.zw, s15
		mov r28.y, r27.x
		mul r26, c137.xyxy, r25
		add r27.xy, r26.xzxz, r26.ywyw
		mul r26, c137.zwzw, r25
		add r27.zw, r26.xzxz, r26.ywyw
		mad r26, r27, r20.xyxy, r7.xyxy
		max r26.xz, r26, r20.z
		min r26.xz, r26, r20.w
		texldl r27, r26.xy, s15
		mov r28.z, r27.x
		texldl r27, r26.zw, s15
		mov r28.w, r27.x
		add r28, r8.z, -r28
		cmp r28, r28, c110.y, c110.w
		dp4 r29.w, r28, -c110.x
		dp4 r20.x, r29, -c110.x
	endif
	// ----------------------------------------------------------------------------------------------------------------------------------------------
    // -------------------------------------------------------------- Improved Fadeout --------------------------------------------------------------
    rcp r20.y, c53.w
    mul_sat r20.y, r20.y, r1.w
    mul r20.y, r20.y, r20.y
    lrp r1.w, r20.y, c110.y, r20.x // improved fadeout
	// ----------------------------------------------------------------------------------------------------------------------------------------------
    mul r7.xyz, r6, r5.w
    mul r7.xyz, r1.w, r7
    mul r6.xyz, r6, r1.z
    mul r6.xyz, r1.w, r6
    mad r1.yzw, r3.xxyw, r1.y, r6.xxyz
    mul r2.w, r2.w, -c1.z
    add r6, c19, -v4.x
    add r8, c20, -v4.y
    add r9, c21, -v4.z
    mul r10, r6, r6
    mad r10, r8, r8, r10
    mad r10, r9, r9, r10
    add r11, r10, c0.x
    rsq r12.x, r11.x
    rsq r12.y, r11.y
    rsq r12.z, r11.z
    rsq r12.w, r11.w
    mad r10, r10, -c25, r3.z
    max r11, r10, c0.y
    mul r10, r11, r11
    mad r10, r10, r10, c3.w
    mul r11, r10, c5.x
    cmp r10, r10, r11, c0.y
    mul r11, r2.x, r6
    mad r11, r8, r2.y, r11
    mad r11, r9, r2.z, r11
    mul r10, r10, r11
    mul_sat r10, r12, r10
    mul r11, r6, -c22
    mad r11, r8, -c23, r11
    mad r11, r9, -c24, r11
    mul r11, r12, r11
    mov r13, c26
    mad_sat r11, r11, r13, c27
    mul r10, r10, r11
    mul r6, r5.x, r6
    mad r6, r5.y, r8, r6
    mad r5, r5.z, r9, r6
    mul r5, r12, r5
    log r6.x, r5_abs.x
    log r6.y, r5_abs.y
    log r6.z, r5_abs.z
    log r6.w, r5_abs.w
    mul r5, r2.w, r6
    exp r6.x, r5.x
    exp r6.y, r5.y
    exp r6.z, r5.z
    exp r6.w, r5.w
    mul r5, r10, r6
    dp4 r6.x, c29, r10
    dp4 r6.y, c30, r10
    dp4 r6.z, c31, r10
    dp4 r8.x, c29, r5
    dp4 r8.y, c30, r5
    dp4 r8.z, c31, r5
    add r5.xyz, r1.yzww, r6
    mad r1.yzw, r7.xxyz, c17.w, r8.xxyz
    dp3 r2.x, r4, r2
    add r2.x, -r2_abs.x, c0.z
    mul r2.x, r2.x, r2.x
    mul r2.x, r2.x, r2.x
    mad_sat r2.x, r2.x, c1.y, c1.y
    mul r1.x, r1.x, r2.x
    mov r5.w, c0.z
    mul r0, r0, r5
    mad r0.xyz, r1.x, r1.yzww, r0
    mul oC0.w, r0.w, c39.x
    add r0.w, c16.w, -v1.w
    add r1.x, -c16.z, c16.w
    rcp r1.x, r1.x
    mul_sat r0.w, r0.w, r1.x
    add r0.w, -r0.w, c0.z
    add r1.xy, -r3.z, c16
    mul r1.y, r0.w, r1.y
    mad r0.w, r0.w, r1.x, c0.z
    dp3 r1.x, r0, c5.yzww
    lrp r2.xyz, r0.w, r0, r1.x
    add r0.x, r1.x, c6.x
    pow r2.w, r0_abs.x, r1.y
    mul r0.xyz, r2, r2.w
    rcp r0.w, c41.x
    mul_sat r0.w, r0.w, v1.w
    add r1.x, -c41.x, v1.w
    add r1.y, -c41.x, c41.y
    rcp r1.y, r1.y
    mul_sat r1.x, r1.x, r1.y
    lrp r3.x, c41.w, r0.w, r1.x
    add r0.w, r3.x, c41.z
    mov r3.xyz, c43
    add r1.yzw, -r3.xxyz, c42.xxyz
    mad r1.xyz, r1.x, r1.yzww, c43
    mad r1.xyz, r2, -r2.w, r1
    mad oC0.xyz, r0.w, r1, r0
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

// approximately 232 instruction slots used (15 texture, 217 arithmetic)
