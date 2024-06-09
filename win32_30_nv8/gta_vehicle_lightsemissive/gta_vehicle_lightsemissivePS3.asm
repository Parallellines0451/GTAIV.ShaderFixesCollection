// Summary: Disabled PC parameters that cause the dirt level in vehicle.ide to affect reflection intensity + console-like ambient reflection intensity + improved shadow filter + restored normal offset bias + improved shadow fadeout
// Generated by Microsoft (R) HLSL Shader Compiler 9.26.952.2844
//
// Parameters:
//
//   sampler2D DirtSampler;
//   sampler2D EnvironmentSampler;
//   sampler2D SpecSampler;
//   sampler2D TextureSampler;
//   float3 dirtColor;
//   float dirtLevel;
//   float emissiveMultiplier;
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
//   float3 matDiffuseColor;
//   float reflectivePowerED;
//   float3 specMapIntMask;
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
//   matDiffuseColor      c66      1
//   emissiveMultiplier   c72      1
//   dirtLevel            c73      1
//   dirtColor            c74      1
//   specMapIntMask       c75      1
//   reflectivePowerED    c76      1
//   TextureSampler       s0       1
//   DirtSampler          s1       1
//   SpecSampler          s2       1
//   EnvironmentSampler   s4       1
//   gShadowZSamplerDir   s15      1
//

    ps_3_0
	// ----------------------------------------------------- Improved Shadow Filter Constants -------------------------------------------------------
    def c110, -0.25, 1, -1, 0
    def c111, 0.159154937, 0.5, 6.28318548, -3.14159274
    def c112, 3, 7.13800001, 0.00390625, 0
    def c113, 0.75, -0.5, 0.5, 0
	
    def c114, 0.1, 0.22, 0.5, 0.8 // c114-c117 = biases for each cascade of each quality setting
    def c115, 0.22, 0.42, 1.07, 1.22
    def c116, 0.28, 0.53, 0.98, 1.08
    def c117, 0.5, 0.8, 1.35, 1.5
	
	def c118, 4, 3, 2, 1 // quality ID's
	def c119, 0.16, 0.08, 0.04, 0 // 1/blend_distance
	
	def c120, 0, 0.25, 0.5, 0.75 // UV clamps
	def c121, 0.2499, 0.4999, 0.7499, 1
	
	def c130, 0.18993645671348536, 0.027087114076591513, -0.21261242652069953, 0.23391293246949066
	def c131, 0.04771781344140756, -0.3666840644525993, 0.297730981239584, 0.398259878229082
	def c132, -0.509063425827436, -0.06528681462854097, 0.507855152944665, -0.2875976005206389
	def c133, -0.15230616564632418, 0.6426121151781916, -0.30240170651828074, -0.5805072900736001
	def c134, 0.6978019230005561, 0.2771173334141519, -0.6990963248129052, 0.3210960724922725
	def c135, 0.3565142601623699, -0.7066415061851589, 0.266890002328106, 0.8360191043249159
	def c136, -0.7515861305520581, -0.41609876195815027, 0.9102937449894895, -0.17014527555321657
	def c137, -0.5343471434373126, 0.8058593459499529, -0.1133270115046468, -0.9490025827627441
	// ----------------------------------------------------------------------------------------------------------------------------------------------
    def c219, 1.8395173895e+25, 3.9938258725e+24, 4.5435787456e+30, 9.4027126956e-43 // 671
    def c99, 0.1, 0, 0, 0 // normal offset bias magnitude
    def c127, 0.9999999, 1, 0, 0	// LogDepth constants
    def c0, 9.99999975e-005, 190, 1.5, 0.0833333358
    def c1, 9.99999975e-006, 0.224999994, 1, 0.5
    def c2, 0.800000012, 0.5, 0.200000003, 0
    def c3, 5, 18, 0, 1
    def c4, -0.5, 0.5, -0.25, 1.33333337
    def c5, 0.212500006, 0.715399981, 0.0720999986, 1.00000001e-007
    def c6, 1, -1, 0, -0
    def c7, -0.321940005, -0.932614982, -0.791558981, -0.597710013
    def c8, 0.507430971, 0.0644249991, 0.896420002, 0.412458003
    def c9, 0.519456029, 0.767022014, 0.185461, -0.893123984
    def c10, 0.962339997, -0.194983006, 0.473434001, -0.480026007
    def c11, -0.69591397, 0.457136989, -0.203345001, 0.620715976
    def c12, -0.326211989, -0.405809999, -0.840143979, -0.0735799968
    def c76, 1, 1, 1, 1 // disable IDE dirt influence
	def c100, 1.6666667, 0, 0, 0	// Reflection intensity multiplier
    dcl vPos.xy
    dcl_texcoord v0.xy
    dcl_texcoord1 v1
    dcl_texcoord3 v2.xyz
    dcl_color v3
    dcl_texcoord2 v4.xyz
    dcl_texcoord7 v5.xy
    dcl_texcoord9 v9
    dcl_2d s0
    dcl_2d s1
    dcl_2d s2
    dcl_2d s4
    dcl_2d s10
    dcl_2d s15
    texld r0, v0, s0
    add r1.xyz, c1.x, v1
    nrm r2.xyz, r1
    texld r1, v0, s2
    mul r1.w, r1.w, c76.x
    dp3 r1.x, r1, c75
    mul r1.x, r1.x, c76.x
    mul r1.x, r1.x, c1.y
    add r3.xyz, c1.x, v2
    nrm r4.xyz, r3
    dp3 r1.y, r4, r2
    add r1.y, -r1_abs.y, c1.z
    mul r1.y, r1.y, r1.y
    mul r1.y, r1.y, r1.y
    mad r1.yz, r1.y, c2.xyxw, c2
    add r1.z, r1.z, r1.z
    min r2.w, r1.x, c1.z
    dp3 r1.x, -r4, r2
    add r1.x, r1.x, r1.x
    mad r3.xyz, r2, -r1.x, -r4
    add r4.xyz, r3, c1.x
    nrm r5.xyz, r4
    mov_sat r1.x, r5.z
    add r1.x, r1.x, c1.z
    add r1.x, r1.x, r1.x
    rcp r1.x, r1.x
    mad r4.xy, r5, r1.x, c1.w
    add r4.xy, -r4, c1.z
    mov r4.zw, c2.w
    texldl r4, r4, s4
	mul r4, r4, c100.x
    mul_sat r1.x, r5.z, c3.x
    mul r4.xyz, r4, r1.x
    mul r4.xyz, r1.z, r4
    mul r4.xyz, r4, c76.x
    mul r4.xyz, r4, c3.y
    mul r0.xyz, r0, c66
    mul r5, r0, v3
    mov r3.w, c2.w
    if_lt -c73.x, r3.w
      texld r6, v5, s1
      mul r1.x, r6.x, c73.x
      mov r1.z, c1.z
      mad r7.x, r6.x, -c73.x, r1.z
      lrp r7.yzw, r1.x, c74.xxyz, r0.xxyz
      mad r8, r0.xxyz, c3.zwww, c3.wzzz
      cmp r0, -r6.x, r8.yzwx, r7.yzwx
    else
      mov r0.w, c1.z
    endif
    mul r1.x, r2.w, r0.w
    mad_sat r1.z, r2.z, c4.x, c4.y
    mov r6.xyz, c38
    mad r6.xyz, r6, r1.z, c37
    mul r7.xyz, c18.w, c18
    dp3 r1.z, r2, -c17
    mul r20.xyz, r2.y, c61.xyww
    mad r20.xyz, r2.x, c60.xyww, r20
    mad r20.xyz, r2.z, c62.xyww, r20
    add r1.z, r1.z, c4.z
    mul_sat r1.z, r1.z, c4.w
    dp3_sat r2.x, -c17, r3
    add r2.x, r2.x, c0.x
    mad r1.w, r1.w, c0.y, c0.x
    pow r3.x, r2.x, r1.w
    mul r2.xyz, c61.xyww, v4.y
    mad r2.xyz, v4.x, c60.xyww, r2
    mad r2.xyz, v4.z, c62.xyww, r2
    add r2.xyz, r2, c63.xyww
    mad r2.xyz, r20.xyz, c99.x, r2 // normal offset bias
    dp3 r1.w, c14, v4
    add r3.yzw, -r1.w, -c54.xxyz
    cmp r8.yzw, r3, c3.w, c3.z
    mov r8.x, c1.z
    mad r21, r8, c110.yyyw, -r8.yzww // shadow cascade mask
    dp4 r9.x, r8, c57
    dp4 r9.y, r8, c58
    dp4 r10.x, r8, c59
    dp4 r10.y, r8, c56
    mad r2.xy, r2, r9, r10
    add r3.yzw, c15.xxyz, -v4.xxyz
    dp3 r1.w, r3.yzww, r3.yzww
    rsq r1.w, r1.w
    rcp r1.w, r1.w
    /* removed 1.0.6.0 filter
    rcp r2.w, c53.w
    mul r2.w, r1.w, r2.w
    mul r2.w, r2.w, r2.w
    mul r2.w, r2.w, c0.z
    mov r3.y, c53.y
    mad r3.zw, r3.y, c12.xyxy, r2.xyxy
    texld r8, r3.zwzw, s15
    add r3.z, r2.z, -r8.x
    cmp r3.z, r3.z, c3.w, c3.z
    mad r8.xy, r3.y, c12.zwzw, r2
    texld r8, r8, s15
    add r3.w, r2.z, -r8.x
    cmp r3.w, r3.w, c3.w, c3.z
    add r3.z, r3.z, r3.w
    mad r8.xy, r3.y, c11, r2
    texld r8, r8, s15
    add r3.w, r2.z, -r8.x
    cmp r3.w, r3.w, c3.w, c3.z
    add r3.z, r3.z, r3.w
    mad r8.xy, r3.y, c11.zwzw, r2
    texld r8, r8, s15
    add r3.w, r2.z, -r8.x
    cmp r3.w, r3.w, c3.w, c3.z
    add r3.z, r3.z, r3.w
    mad r8.xy, r3.y, c10, r2
    texld r8, r8, s15
    add r3.w, r2.z, -r8.x
    cmp r3.w, r3.w, c3.w, c3.z
    add r3.z, r3.z, r3.w
    mad r8.xy, r3.y, c10.zwzw, r2
    texld r8, r8, s15
    add r3.w, r2.z, -r8.x
    cmp r3.w, r3.w, c3.w, c3.z
    add r3.z, r3.z, r3.w
    mad r8.xy, r3.y, c9, r2
    texld r8, r8, s15
    add r3.w, r2.z, -r8.x
    cmp r3.w, r3.w, c3.w, c3.z
    add r3.z, r3.z, r3.w
    mad r8.xy, r3.y, c9.zwzw, r2
    texld r8, r8, s15
    add r3.w, r2.z, -r8.x
    cmp r3.w, r3.w, c3.w, c3.z
    add r3.z, r3.z, r3.w
    mad r8.xy, r3.y, c8, r2
    texld r8, r8, s15
    add r3.w, r2.z, -r8.x
    cmp r3.w, r3.w, c3.w, c3.z
    add r3.z, r3.z, r3.w
    mad r8.xy, r3.y, c8.zwzw, r2
    texld r8, r8, s15
    add r3.w, r2.z, -r8.x
    cmp r3.w, r3.w, c3.w, c3.z
    add r3.z, r3.z, r3.w
    mad r8.xy, r3.y, c7, r2
    texld r8, r8, s15
    add r3.w, r2.z, -r8.x
    cmp r3.w, r3.w, c3.w, c3.z
    add r3.z, r3.z, r3.w
    mad r2.xy, r3.y, c7.zwzw, r2
    texld r8, r2, s15
    add r2.x, r2.z, -r8.x
    cmp r2.x, r2.x, c3.w, c3.z
    add r2.x, r3.z, r2.x
    mad r2.x, r2.x, c0.w, r2.w
    add r1.w, r1.w, -c53.w
    cmp r2.yz, r1.w, c6.xxyw, c6.xzww
    add r1.w, r2.x, r2.z
    cmp_sat r1.w, r1.w, r2.x, r2.y
    removed 1.0.6.0 filter */
// ---------------------------------------------------------- Improved Shadow Filter ------------------------------------------------------------
	mov r20.xy, c53.y
	rcp r20.z, c58.x
	mul r20.z, r20.z, c57.x
	mul r20.x, r20.x, r20.z // fix filter stretching
	
	add r22, c54.w, -c54
	add r22, c53.w, -r22 // cascade distances
	dp4 r23.x, r21_abs, r22
	dp4 r23.y, r21_abs, r22.xxyz
	dp4 r23.z, r21_abs, c119.xxyz
	add r23.w, v9.w, -r23.y
	mul_sat r23.z, r23.z, r23.w
	rcp r23.x, r23.x
	mul r23.w, r23.x, r23.y
	lrp r20.z, r23.z, c110.y, r23.w
	mul r20.xy, r20.xy, r20.z // apply pseudo cascade blending
	
	mov r24, c118
	add r24, r24, -c221.y
	add_sat r24, c110.y, -r24_abs
	m4x4 r25, r21_abs, c114
	dp4 r25.x, r25, r24
	add r2.z, r2.z, -r25.x // apply per cascade bias
	
	dp4 r20.z, r21_abs, c120 // fix pixels leaking into other cascades
	dp4 r20.w, r21_abs, c121
	
	mov r21.x, c110.y
	if_lt c223.y, r21.x
		dp2add r21.y, vPos, c112.xy, c112.w
		mad r21.y, r21.y, c111.x, c111.y
		frc r21.y, r21.y
		mad r21.y, r21.y, c111.z, c111.w
		sincos r22.xy, r21.y
		mul r23, r22.yxxy, c110.xxyz
		mul r21, r22.yxxy, c113.xxyz
		mul r20.xy, r20.xy, c112.x
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
		mul r20.xy, r20.xy, c112.x
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
    mul_sat r20.y, r20.y, r1.w
    mul r20.y, r20.y, r20.y
    lrp r1.w, r20.y, c110.y, r20.x // improved fadeout
	// ----------------------------------------------------------------------------------------------------------------------------------------------
    mul r2.xyz, r7, r3.x
    mul r2.xyz, r1.w, r2
    mul r3.xyz, r7, r1.z
    mul r3.xyz, r1.w, r3
    mad r3.xyz, r6, c39.z, r3
    mov_sat r1.y, r1.y
    mul r1.x, r1.x, r1.y
    mul r1.yzw, r4.xxyz, r1.x
    mul r1.yzw, r1, c39.z
    mad r1.yzw, r2.xxyz, c17.w, r1
    mov r0.w, r5.w
    mov r3.w, c1.z
    mul r0, r0, r3
    mad r0.xyz, r1.x, r1.yzww, r0
    mad r0.xyz, r5, c72.x, r0
    mul oC0.w, r0.w, c39.x
    add r0.w, c16.w, -v1.w
    add r1.x, -c16.z, c16.w
    rcp r1.x, r1.x
    mul_sat r0.w, r0.w, r1.x
    add r0.w, -r0.w, c1.z
    mov r1.z, c1.z
    add r1.xy, -r1.z, c16
    mul r1.y, r0.w, r1.y
    mad r0.w, r0.w, r1.x, c1.z
    dp3 r1.x, r0, c5
    lrp r2.xyz, r0.w, r0, r1.x
    add r0.x, r1.x, c5.w
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

// approximately 203 instruction slots used (17 texture, 186 arithmetic)
