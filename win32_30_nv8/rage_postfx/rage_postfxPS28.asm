// Summary: Fixed blurry screen, improved Definition, console-like gamma + dithering mask + HQ motion blur + fixed motion blur FPS scaling
// Generated by Microsoft (R) HLSL Shader Compiler 9.26.952.2844
//
// Parameters:
//
//   sampler2D AdapLumSampler;
//   float4 ColorCorrect;
//   float4 ColorShift;
//   float Exposure;
//   sampler2D GBufferTextureSampler2;
//   sampler2D GBufferTextureSampler3;
//   sampler2D HDRSampler;
//   sampler2D JitterSampler;
//   float PLAYER_MASK;
//   sampler2D StencilCopySampler;
//   float4 TexelSize;
//   float4 ToneMapParams;
//   float4 deSatContrastGamma;
//   float4 dofBlur;
//   float4 dofProj;
//   float gDirectionalMotionBlurLength;
//   float4 globalScreenSize;
//   row_major float4x4 motionBlurMatrix;
//
//
// Registers:
//
//   Name                         Reg   Size
//   ---------------------------- ----- ----
//   globalScreenSize             c44      1
//   Exposure                     c66      1
//   motionBlurMatrix             c72      4
//   TexelSize                    c76      1
//   dofProj                      c77      1
//   dofBlur                      c78      1
//   gDirectionalMotionBlurLength c79      1
//   ToneMapParams                c80      1
//   deSatContrastGamma           c81      1
//   ColorCorrect                 c82      1
//   ColorShift                   c83      1
//   PLAYER_MASK                  c84      1
//   GBufferTextureSampler2       s0       1
//   GBufferTextureSampler3       s1       1
//   HDRSampler                   s2       1
//   AdapLumSampler               s3       1
//   JitterSampler                s4       1
//   StencilCopySampler           s5       1
//

    ps_3_0
    def c219, 1.8395173895e+25, 3.9938258725e+24, 4.5435787456e+30, 1.1644790239e-42 // 831
    def c127, 0.9999999, 1, 0, 0	// LogDepth constants
    def c0, 58.1640015, 47.1300011, 0, 0
    def c1, 0, 0.212500006, 0.715399981, 0.0720999986
    def c2, 0.25, 256, 1, 0
    def c3, 0, 2, 4, 8
    def c4, -0.5, -1.5, 1.5, 0.5
    def c5, 2, -1, 0.125, 0
    def c6, 256, 2, 4, 8
    def c7, 0, 0.25, 0.5, 1
	def c10, 1.3333333, 1.0526316, 1.05577, 0.0762		// Gamma Constants
	def c11, 0.0333333, 0, 0, 0 // frametime target
	// ---------------------------------------------------------- Dithering Mask Constants ----------------------------------------------------------
	def c130, -1, 0, 1, 0
	def c131, 0.012156862745098, 0.016078431372549, 0.0435294117647059, 0.0474509803921569 // 3.1, 4.1, 11.1, 12.1
	def c132, 0.5141176470588235, 0.5180392156862745, 0.5454901960784314, 0.5494117647058824 // 131.1, 132.1, 139.1, 140.1
	def c133, 0.027843137254902, 0.0007843137254902, 0, 0 // 7
	defi i1, 3, 0, 0, 0
	// ----------------------------------------------------------------------------------------------------------------------------------------------
    defi i0, 7, 0, 0, 0
    dcl_texcoord v0.xy
    dcl_2d s0
    dcl_2d s1
    dcl_2d s2
    dcl_2d s3
    dcl_2d s4
    dcl_2d s5
	mov r31, c1.x
    texld r0, v0, s1
	// ----------------------------------------------------------------- Log2Linear -----------------------------------------------------------------
	if_ne r0.x, c127.y
		rcp r20.x, c128.x
		mul r20.x, r20.x, c128.y
		pow r20.x, r20.x, r0.x
		mul r20.x, r20.x, c128.x	// W_clip
		
		add r20.y, r20.x, -c128.x
		add r20.z, c128.y, -c128.x
		mul r20.y, r20.y, c128.y
		mul r20.z, r20.z, r20.x
		rcp r20.z, r20.z
		mul r20.w, r20.y, r20.z		// Linear depth
		
		min r0, r20.w, c127.x		// FP error hack
	endif
	// ----------------------------------------------------------------------------------------------------------------------------------------------
    add r0.y, -c77.x, c77.y
    rcp r0.y, r0.y
    mul r0.z, r0.y, c77.y
    mul r0.z, r0.z, -c77.x
    mad r0.x, c77.y, -r0.y, r0.x
    rcp r0.x, r0.x
    mul r0.x, r0.z, r0.x
	// --------------------------------------------------------------- Dithering Mask ---------------------------------------------------------------
	mov r30.y, c223.z
	if_ne r30.y, c130.y
		mov r20, c130.y
		mov r21.xy, c130.x
		rep i1
			rep i1
				mad r22.xy, c76, r21.xy, v0
				texldl r22, r22, s5
				
				add r23, r22.x, -c131
				add_sat r23, -r23_abs, c133.y
				add r20, r20, r23
				add r23, r22.x, -c132
				add_sat r23, -r23_abs, c133.y
				add r20, r20, r23
				add r23, r22.x, -c133.x
				add_sat r23, -r23_abs, c133.y
				add r20, r20, r23
				
				add r21.y, r21.y, c130.z
			endrep
			mad r21.xy, r21.x, c130.zy, c130.zx
		endrep
		dp4 r30.x, r20, c130.z
	else
		mov r30.x, c130.z
	endif
	// ----------------------------------------------------------------------------------------------------------------------------------------------
    texld r1, v0, s2
    abs r0.y, c78.w
    mov r2, c4
    mad r0.zw, c76.xyxy, r2.xyxy, v0.xyxy
    texld r3, r0.zwzw, s2
    mad r0.zw, c76.xyxy, r2.xyzx, v0.xyxy
    texld r4, r0.zwzw, s2
    mad r0.zw, c76.xyxy, r2.xywz, v0.xyxy
    texld r5, r0.zwzw, s2
    mad r0.zw, c76.xyxy, r2.xyyw, v0.xyxy
    texld r2, r0.zwzw, s2
    dp3 r0.z, r3, r3
    rcp r0.z, r0.z
    cmp r3.xyz, -r0_abs.z, c1.x, r3
    dp3 r0.z, r4, r4
    rcp r0.z, r0.z
    cmp r4.xyz, -r0_abs.z, c1.x, r4
    dp3 r0.z, r5, r5
    rcp r0.z, r0.z
    cmp r5.xyz, -r0_abs.z, c1.x, r5
    dp3 r0.z, r2, r2
    rcp r0.z, r0.z
    cmp r2.xyz, -r0_abs.z, c1.x, r2
    dp3 r0.z, r1, r1
    rcp r0.z, r0.z
    cmp r6.xyz, -r0_abs.z, c1.x, r1
    dp3 r0.z, r6, c1.yzww
    dp3 r7.x, r3, c1.yzww
    dp3 r7.y, r4, c1.yzww
    dp3 r7.z, r5, c1.yzww
    dp3 r7.w, r2, c1.yzww
    dp4 r0.w, r7, c2.x
    add r7, r7, -r0.w
    dp4 r1.w, r7, r7
    add r0.z, r0.z, -r0.w
	mad r0.z, r0.z, r0.z, -r1.w
	cmp r0.z, -r30_abs.x, -r1.w, r0.z // Definition toggle
    texld r7, v0, s0
    mov r7.yz, c2
    mad r8, r7.w, -r7.y, c3
    cmp r8, r8, c2.z, c2.w
    mad r9, r7.w, -c6.x, c6.yzwx
    cmp r9, r9, -c2.z, -c2.w
    add r8, r8, r9
    mul r8, r8, c1.x // fix blurry screen
    dp4 r0.w, r8, c2.z
    add r0.w, r0.w, c4.w
    rcp r0.w, r0.w
    mul r7.xyw, r3.xyzz, r8.x
    mad r6.xyz, r6, c4.w, r7.xyww
    mad r6.xyz, r4, r8.y, r6
    mad r6.xyz, r5, r8.z, r6
    mad r6.xyz, r2, r8.w, r6
    mul r6.xyz, r0.w, r6
    cmp r7.xyw, r0.z, c7.xyzz, c7.wxzw
    mul r3.xyz, r3, r7.y
    mad r3.xyz, r6, r7.x, r3
    mad r3.xyz, r4, r7.y, r3
    mad r3.xyz, r5, r7.y, r3
    mad r2.xyz, r2, r7.y, r3
    mad r3.xyz, v0.yxyw, c5.x, c5.y
    mul r0.z, r3.y, c77.z
    mul r0.z, r0.x, r0.z
    mul r0.w, -r3.x, c77.w
    mul r0.w, r0.x, r0.w
    mul r4.xyz, r0.w, c73
    mad r4.xyz, r0.z, c72, r4
    mad r0.xzw, -r0.x, c74.xyyz, r4.xyyz
    add r0.xzw, r0, c75.xyyz
    mul r1.w, -r0.w, c77.z
    rcp r1.w, r1.w
    mul r4.x, r0.x, r1.w
    mul r0.x, r0.w, c77.w
    rcp r0.x, r0.x
    mul r4.y, r0.z, r0.x
    add r0.xz, -r3.yyzw, r4.xyyw
	// ------------------------------------------------------------ Motion Blur FPS Fix -------------------------------------------------------------
	rcp r20.x, c221.z
	mul r20.x, r20.x, c11.x
	mul_sat r20.x, r20.x, c79.x
    mul r0.xz, r0, r20.x
	// ----------------------------------------------------------------------------------------------------------------------------------------------
    mul r3.xy, r0.xzzw, c5.z
    texld r4, v0, s5
    add r0.w, r4.x, -c84.x
    mul r3.zw, r2.xyxy, c3.w
    mad r3.zw, v0.xyxy, c0.xyxy, r3
    texld r4, r3.zwzw, s4
    add r1.w, r4.x, c4.x
    mad r3.zw, r3.xyxy, r1.w, v0.xyxy
    mov r4.xyz, r2
    mov r1.w, c2.z
    mov r2.w, c2.z
	// ---------------------------------------------------------- Motion Blur Optimization ----------------------------------------------------------
	if_ne c222.w, r31.x	// don't run if motion blur is disabled
		rep i0
		mad r5.xy, r3, r2.w, r3.zwzw
		texldl r6, r5, s5
		add r4.w, r6.x, -c84.x
		cmp r4.w, r4.w, c2.w, c2.z
		texldl r5, r5, s2
		mad r4.xyz, r5, r4.w, r4
		add r1.w, r1.w, r4.w
		add r2.w, r2.w, c2.z
		endrep
	endif
	// ----------------------------------------------------------------------------------------------------------------------------------------------
    rcp r1.w, r1.w
    mul r0.xz, r0, c44.xyyw
    dp2add r0.x, r0.xzzw, r0.xzzw, c1.x
    rsq r0.x, r0.x
    rcp r0.x, r0.x
    mul r0.x, r0.x, c4.w
    mul_sat r0.x, r7.w, r0.x
    mad r3.xyz, r4, r1.w, -r2
    mad r3.xyz, r0.x, r3, r2
    cmp r0.xzw, r0.w, r2.xyyz, r3.xyyz
    mov r0.xyz, r0.xzww	// Disable vanilla Definition behavior
    mul r0.xyz, r0, c66.x
    texld r1, c1.x, s3
    rcp r0.w, r1.x
    mul r0.w, r0.w, c80.y
    mul r1.xyz, r0, r0.w
    dp3 r1.x, r1, c1.yzww
    mad r0.xyz, r0, r0.w, -r1.x
    mad r0.xyz, c81.x, r0, r1.x
    mul r0.w, r1.x, c83.w
    mul r1.yzw, r0.w, c83.xxyz
    mov_sat r2.x, r0.w
    mad r0.xyz, c83, -r0.w, r0
    mad r0.xyz, r2.x, r0, r1.yzww
    mul r0.xyz, r0, c82
    add r0.xyz, r0, r0
    mov_sat r1.x, r1.x
    add r0.w, -r7.z, c81.z
    pow r2.x, r1.x, r0.w
	mul r12, r0, r2.x
	// ------------------------------------------------------------- Console-like Gamma -------------------------------------------------------------
	// Piecewise function to approximate Xbox gamma correction
	max r12, r12, c1.x
	if_ne c222.z, r31.x
		mov r20, c10						// copy c10
		add r21, r12, -c5.z					// r21 = r12 - 0.125
		cmp r22, r21, c2.w, c2.z			// r22 = r12 >= 0.125 ? 1 : 0
		lrp r23, r22, r20.x, r20.y			// mix(1.3333333, 1.0526316, r22(r12 >= 0.125))
		pow r24.x, r12.x, r23.x				// if r12 >= 0.125 ? 1.3333333 : 1.0526316
		pow r24.y, r12.y, r23.y				// if r12 >= 0.125 ? 1.3333333 : 1.0526316
		pow r24.z, r12.z, r23.z				// if r12 >= 0.125 ? 1.3333333 : 1.0526316
		add r25, r24, -c5.z					// if r12 >= 0.125
		mad r25, r25, r20.z, r20.w			// if r12 >= 0.125
		lrp r12.xyz, r22, r24, r25			// mix(r24, r25, r22(r12 >= 0.125))
	endif
	// ----------------------------------------------------------------------------------------------------------------------------------------------
    mov oC0.xyz, r12
    mov oC0.w, c2.z

// approximately 142 instruction slots used (12 texture, 130 arithmetic)
