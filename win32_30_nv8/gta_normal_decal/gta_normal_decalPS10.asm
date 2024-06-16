// Summary: removed unnecessary stipple + improved shadow filter + restored normal offset bias + improved shadow fadeout
// Generated by Microsoft (R) HLSL Shader Compiler 9.26.952.2844
//
// Parameters:
//
//   sampler2D BumpSampler;
//   sampler2D StippleTexture;
//   sampler2D TextureSampler;
//   float bumpiness;
//   float4 gDepthFxParams;
//   float4 gDirectionalColour;
//   float4 gDirectionalLight;
//   float4 gFacetCentre;
//   float4 gLightAmbient0;
//   float4 gLightAmbient1;
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
//   specularFactor       c66      1
//   specularColorFactor  c72      1
//   bumpiness            c73      1
//   TextureSampler       s0       1
//   BumpSampler          s1       1
//   StippleTexture       s10      1
//   gShadowZSamplerDir   s15      1
//

    ps_3_0
	// -------------------------------------------------------------- Shadow Constants --------------------------------------------------------------
    def c110, -0.25, 1, -1, 0
    def c111, 0.159154937, 0.5, 6.28318548, -3.14159274
    def c112, 3, 7.13800001, 0.00390625, 0
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
    def c219, 1.8395173895e+25, 3.9938258725e+24, 4.5435787456e+30, 4.3440252394e-43 // 310
    def c127, 0.9999999, 1, 0, 0	// LogDepth constants
    def c0, -0.5, 9.99999975e-006, 0.5, 1.33333337
    def c1, 9.99999975e-005, 1.5, -0.326211989, -0.405809999
    def c2, -0.791558981, -0.597710013, 0.0833333358, 1.00000001e-007
    def c3, 3.99600005, 4, 0.125, 0.25
    def c4, 0.212500006, 0.715399981, 0.0720999986, 0
    def c5, 0, -1, -0, 1
    def c6, 0.896420002, 0.412458003, -0.321940005, -0.932614982
    def c7, 0.185461, -0.893123984, 0.507430971, 0.0644249991
    def c8, 0.473434001, -0.480026007, 0.519456029, 0.767022014
    def c9, -0.203345001, 0.620715976, 0.962339997, -0.194983006
    def c10, -0.840143979, -0.0735799968, -0.69591397, 0.457136989
    dcl_texcoord v0.xy
    dcl_texcoord1 v1
    dcl_texcoord3 v2.xyz
    dcl_texcoord4 v3.xyz
    dcl_texcoord5 v4.xyz
    dcl_color v5.xw
    dcl_texcoord6 v6.xyz
    dcl vPos.xy
    dcl_texcoord9 v9
    dcl_2d s0
    dcl_2d s1
    dcl_2d s10
    dcl_2d s15
    /* removed stipple
    mov_sat r0.x, c39.x
    mul r0.x, r0.x, c3.x
    frc r0.y, r0.x
    mul r0.z, r0.y, c3.y
    frc r0.w, r0.z
    add r1.xy, r0.zxzw, -r0.wyzw
    mul r0.xy, c3.z, vPos
    frc r0.xy, r0_abs
    cmp r0.xy, vPos, r0, -r0
    mul r0.xy, r0, c3.w
    mad r0.xy, r1, c3.w, r0
    mov r0.zw, c5.x
    texldl r0, r0, s10
    cmp r0, -r0.y, c5.y, c5.z
    texkill r0
    removed stipple */
    texld r0, v0, s1
    add r0.z, -r0.w, c5.w
    add r0.z, -r0.x, r0.z
    cmp r0.xy, r0.z, r0.wyzw, r0
    texld r1, v0, s0
    add r0.zw, r0.xyxy, c0.x
    mul r0.zw, r0, c73.x
    dp2add r0.x, r0, -r0, c5.w
    rsq r0.x, r0.x
    rcp r0.x, r0.x
    mul r2.xyz, r0.z, v3
    mad r0.xyz, v1, r0.x, r2
    mad r0.xyz, r0.w, v4, r0
    add r0.xyz, r0, c0.y
    nrm r2.xyz, r0
    mul r1.w, r1.w, v5.w
    add r0.xyz, c0.y, v2
    nrm r3.xyz, r0
    mad_sat r0.x, r2.z, c0.x, c0.z
    mov r4.xyz, c38
    mad r0.xyz, r4, r0.x, c37
    dp3 r0.w, -r3, r2
    add r0.w, r0.w, r0.w
    mad r3.xyz, r2, -r0.w, -r3
    mul r4.xyz, c18.w, c18
    dp3 r0.w, r2, -c17
    mul r20.xyz, r2.y, c61.xyww
    mad r20.xyz, r2.x, c60.xyww, r20
    mad r20.xyz, r2.z, c62.xyww, r20
    add r0.w, r0.w, -c3.w
    mul_sat r0.w, r0.w, c0.w
    dp3_sat r2.x, -c17, r3
    add r2.x, r2.x, c1.x
    mov r3.xzw, c1
    add r2.y, r3.x, c66.x
    pow r3.x, r2.x, r2.y
    mul r2.xyz, c61.xyww, v6.y
    mad r2.xyz, v6.x, c60.xyww, r2
    mad r2.xyz, v6.z, c62.xyww, r2
    add r2.xyz, r2, c63.xyww
    dp3 r2.w, c14, v6
    add r5.xyz, -r2.w, -c54
    cmp r5.yzw, r5.xxyz, c5.w, c5.x
    mov r5.x, c5.w
    mad r21, r5, c110.yyyw, -r5.yzww // shadow cascade mask
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
    add r2.z, r2.z, -r24.x // undo static bias
    
    mul r22.y, r22.y, c223.y // scale bias with FOV
    mad r2.xyz, r20.xyz, r22.y, r2 // normal offset bias
    
    mul r20.xy, r22.x, c53.y
    rcp r20.x, c58.x
    mul r20.x, r20.x, c57.x
    mul r20.x, r20.x, r20.y // fix filter stretching
    
    mul r20.xy, r20.xy, c218_abs.x
    
    dp4 r20.z, r21_abs, c119 // fix pixels leaking into other cascades
    dp4 r20.w, r21_abs, c120
    // ----------------------------------------------------------------------------------------------------------------------------------------------
    dp4 r6.x, r5, c57
    dp4 r6.y, r5, c58
    dp4 r7.x, r5, c59
    dp4 r7.y, r5, c56
    mad r2.xy, r2, r6, r7
    add r5.xyz, c15, -v6
    dp3 r2.w, r5, r5
    rsq r2.w, r2.w
    rcp r2.w, r2.w
    /* removed 1.0.6.0 filter
    rcp r3.y, c53.w
    mul r3.y, r2.w, r3.y
    mul r3.y, r3.y, r3.y
    mul r3.y, r3.y, c1.y
    mad r3.zw, c53.y, r3, r2.xyxy
    texld r5, r3.zwzw, s15
    add r3.z, r2.z, -r5.x
    cmp r3.z, r3.z, c5.w, c5.x
    mov r5.y, c53.y
    mad r5.xz, r5.y, c10.xyyw, r2.xyyw
    texld r6, r5.xzzw, s15
    add r3.w, r2.z, -r6.x
    cmp r3.w, r3.w, c5.w, c5.x
    add r3.z, r3.z, r3.w
    mad r5.xz, r5.y, c10.zyww, r2.xyyw
    texld r6, r5.xzzw, s15
    add r3.w, r2.z, -r6.x
    cmp r3.w, r3.w, c5.w, c5.x
    add r3.z, r3.z, r3.w
    mad r5.xz, r5.y, c9.xyyw, r2.xyyw
    texld r6, r5.xzzw, s15
    add r3.w, r2.z, -r6.x
    cmp r3.w, r3.w, c5.w, c5.x
    add r3.z, r3.z, r3.w
    mad r5.xz, r5.y, c9.zyww, r2.xyyw
    texld r6, r5.xzzw, s15
    add r3.w, r2.z, -r6.x
    cmp r3.w, r3.w, c5.w, c5.x
    add r3.z, r3.z, r3.w
    mad r5.xz, r5.y, c8.xyyw, r2.xyyw
    texld r6, r5.xzzw, s15
    add r3.w, r2.z, -r6.x
    cmp r3.w, r3.w, c5.w, c5.x
    add r3.z, r3.z, r3.w
    mad r5.xz, r5.y, c8.zyww, r2.xyyw
    texld r6, r5.xzzw, s15
    add r3.w, r2.z, -r6.x
    cmp r3.w, r3.w, c5.w, c5.x
    add r3.z, r3.z, r3.w
    mad r5.xz, r5.y, c7.xyyw, r2.xyyw
    texld r6, r5.xzzw, s15
    add r3.w, r2.z, -r6.x
    cmp r3.w, r3.w, c5.w, c5.x
    add r3.z, r3.z, r3.w
    mad r5.xz, r5.y, c7.zyww, r2.xyyw
    texld r6, r5.xzzw, s15
    add r3.w, r2.z, -r6.x
    cmp r3.w, r3.w, c5.w, c5.x
    add r3.z, r3.z, r3.w
    mad r5.xz, r5.y, c6.xyyw, r2.xyyw
    texld r6, r5.xzzw, s15
    add r3.w, r2.z, -r6.x
    cmp r3.w, r3.w, c5.w, c5.x
    add r3.z, r3.z, r3.w
    mad r5.xz, r5.y, c6.zyww, r2.xyyw
    texld r6, r5.xzzw, s15
    add r3.w, r2.z, -r6.x
    cmp r3.w, r3.w, c5.w, c5.x
    add r3.z, r3.z, r3.w
    mad r2.xy, r5.y, c2, r2
    texld r5, r2, s15
    add r2.x, r2.z, -r5.x
    cmp r2.x, r2.x, c5.w, c5.x
    add r2.x, r3.z, r2.x
    mad r2.x, r2.x, c2.z, r3.y
    add r2.y, r2.w, -c53.w
    cmp r2.yz, r2.y, c5.xwyw, c5.xxzw
    add r2.z, r2.x, r2.z
    cmp_sat r2.x, r2.z, r2.x, r2.y
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
		mad r23, r23, r20.xyxy, r2.xyxy
		mad r21, r21, r20.xyxy, r2.xyxy
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
		add r25, r2.z, -r25
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
		mad r26, r27, r20.xyxy, r2.xyxy
		max r26.xz, r26, r20.z
		min r26.xz, r26, r20.w
		texldl r28, r26.xy, s15
		texldl r27, r26.zw, s15
		mov r28.y, r27.x
		mul r26, c131.xyxy, r25
		add r27.xy, r26.xzxz, r26.ywyw
		mul r26, c131.zwzw, r25
		add r27.zw, r26.xzxz, r26.ywyw
		mad r26, r27, r20.xyxy, r2.xyxy
		max r26.xz, r26, r20.z
		min r26.xz, r26, r20.w
		texldl r27, r26.xy, s15
		mov r28.z, r27.x
		texldl r27, r26.zw, s15
		mov r28.w, r27.x
		add r28, r2.z, -r28
		cmp r28, r28, c110.y, c110.w
		dp4 r29.x, r28, -c110.x
		mul r26, c132.xyxy, r25
		add r27.xy, r26.xzxz, r26.ywyw
		mul r26, c132.zwzw, r25
		add r27.zw, r26.xzxz, r26.ywyw
		mad r26, r27, r20.xyxy, r2.xyxy
		max r26.xz, r26, r20.z
		min r26.xz, r26, r20.w
		texldl r28, r26.xy, s15
		texldl r27, r26.zw, s15
		mov r28.y, r27.x
		mul r26, c133.xyxy, r25
		add r27.xy, r26.xzxz, r26.ywyw
		mul r26, c133.zwzw, r25
		add r27.zw, r26.xzxz, r26.ywyw
		mad r26, r27, r20.xyxy, r2.xyxy
		max r26.xz, r26, r20.z
		min r26.xz, r26, r20.w
		texldl r27, r26.xy, s15
		mov r28.z, r27.x
		texldl r27, r26.zw, s15
		mov r28.w, r27.x
		add r28, r2.z, -r28
		cmp r28, r28, c110.y, c110.w
		dp4 r29.y, r28, -c110.x
		mul r26, c134.xyxy, r25
		add r27.xy, r26.xzxz, r26.ywyw
		mul r26, c134.zwzw, r25
		add r27.zw, r26.xzxz, r26.ywyw
		mad r26, r27, r20.xyxy, r2.xyxy
		max r26.xz, r26, r20.z
		min r26.xz, r26, r20.w
		texldl r28, r26.xy, s15
		texldl r27, r26.zw, s15
		mov r28.y, r27.x
		mul r26, c135.xyxy, r25
		add r27.xy, r26.xzxz, r26.ywyw
		mul r26, c135.zwzw, r25
		add r27.zw, r26.xzxz, r26.ywyw
		mad r26, r27, r20.xyxy, r2.xyxy
		max r26.xz, r26, r20.z
		min r26.xz, r26, r20.w
		texldl r27, r26.xy, s15
		mov r28.z, r27.x
		texldl r27, r26.zw, s15
		mov r28.w, r27.x
		add r28, r2.z, -r28
		cmp r28, r28, c110.y, c110.w
		dp4 r29.z, r28, -c110.x
		mul r26, c136.xyxy, r25
		add r27.xy, r26.xzxz, r26.ywyw
		mul r26, c136.zwzw, r25
		add r27.zw, r26.xzxz, r26.ywyw
		mad r26, r27, r20.xyxy, r2.xyxy
		max r26.xz, r26, r20.z
		min r26.xz, r26, r20.w
		texldl r28, r26.xy, s15
		texldl r27, r26.zw, s15
		mov r28.y, r27.x
		mul r26, c137.xyxy, r25
		add r27.xy, r26.xzxz, r26.ywyw
		mul r26, c137.zwzw, r25
		add r27.zw, r26.xzxz, r26.ywyw
		mad r26, r27, r20.xyxy, r2.xyxy
		max r26.xz, r26, r20.z
		min r26.xz, r26, r20.w
		texldl r27, r26.xy, s15
		mov r28.z, r27.x
		texldl r27, r26.zw, s15
		mov r28.w, r27.x
		add r28, r2.z, -r28
		cmp r28, r28, c110.y, c110.w
		dp4 r29.w, r28, -c110.x
		dp4 r20.x, r29, -c110.x
	endif
	// ----------------------------------------------------------------------------------------------------------------------------------------------
    // -------------------------------------------------------------- Improved Fadeout --------------------------------------------------------------
    rcp r20.y, c53.w
    mul_sat r20.y, r20.y, r2.w
    mul r20.y, r20.y, r20.y
    lrp r2.x, r20.y, c110.y, r20.x // improved fadeout
	// ----------------------------------------------------------------------------------------------------------------------------------------------
    mul r2.yzw, r4.xxyz, r3.x
    mul r2.yzw, r2.x, r2
    mul r3.xyz, r4, r0.w
    mul r3.xyz, r2.x, r3
    mul r2.xyz, r2.yzww, c17.w
    mad r0.xyz, r0, v5.x, r3
    mov r0.w, c5.w
    mul r0, r1, r0
    mad r0.xyz, c72.x, r2, r0
    mul oC0.w, r0.w, c39.x
    add r0.w, c16.w, -v1.w
    add r1.x, -c16.z, c16.w
    rcp r1.x, r1.x
    mul_sat r0.w, r0.w, r1.x
    add r0.w, -r0.w, c5.w
    mov r1.y, c5.y
    add r1.xy, r1.y, c16
    mul r1.y, r0.w, r1.y
    mad r0.w, r0.w, r1.x, c5.w
    dp3 r1.x, r0, c4
    lrp r2.xyz, r0.w, r0, r1.x
    add r0.x, r1.x, c2.w
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

// approximately 181 instruction slots used (16 texture, 165 arithmetic)
