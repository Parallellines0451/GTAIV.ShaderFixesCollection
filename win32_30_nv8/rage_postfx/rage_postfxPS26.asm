// Removed edge blur + added console-like gamma + fixed DOF resolution scaling + fixed TLAD noise tiling + added dithering filter mask + fixed motion blur at high fps + added DOF and motion blur toggles + added noise and bloom toggles
// Generated by Microsoft (R) HLSL Shader Compiler 9.26.952.2844
//
// Parameters:
//
//   sampler2D AdapLumSampler;
//   sampler2D BloomSampler;
//   sampler2D BlurSampler;
//   float4 ColorCorrect;
//   float4 ColorShift;
//   float Exposure;
//   sampler2D GBufferTextureSampler2;
//   sampler2D GBufferTextureSampler3;
//   sampler2D HDRSampler;
//   sampler2D JitterSampler;
//   float4 NoiseParams;
//   float PLAYER_MASK;
//   sampler2D StencilCopySampler;
//   float4 TexelSize;
//   float4 ToneMapParams;
//   float4 deSatContrastGamma;
//   float4 dofBlur;
//   float4 dofDist;
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
//   dofDist                      c78      1
//   dofBlur                      c79      1
//   gDirectionalMotionBlurLength c80      1
//   ToneMapParams                c81      1
//   deSatContrastGamma           c82      1
//   ColorCorrect                 c83      1
//   ColorShift                   c84      1
//   NoiseParams                  c85      1
//   PLAYER_MASK                  c86      1
//   GBufferTextureSampler2       s0       1
//   GBufferTextureSampler3       s1       1
//   HDRSampler                   s2       1
//   BlurSampler                  s3       1
//   BloomSampler                 s4       1
//   AdapLumSampler               s5       1
//   JitterSampler                s6       1
//   StencilCopySampler           s7       1
//

    ps_3_0
    def c219, 1.8395173895e+25, 3.9938258725e+24, 4.5435787456e+30, 1.1616764269e-42 // 829
    def c127, 0.9999999, 1, 0, 0	// LogDepth constants
    def c0, 58.1640015, 47.1300011, 3.20000005, 1.79999995
    def c1, 0, 0.212500006, 0.715399981, 0.0720999986
    def c2, 0.25, 1, 256, 0
    def c3, 0, 2, 4, 8
    def c4, -0.5, -1.5, 1.5, 0.5
    def c5, 2, -1, 0.125, 0
    def c6, 1.10000002, 0, 0, 0
    def c7, 256, 2, 4, 8
	
	def c8, 0.012156862745098, 0.016078431372549, 0.0435294117647059, 0.0474509803921569 // 3.1, 4.1, 11.1, 12.1
	def c9, 0.5141176470588235, 0.5180392156862745, 0.5454901960784314, 0.5494117647058824 // 131.1, 132.1, 139.1, 140.1
	def c10, 0.027843137254902, 0.0007843137254902, 0, 0 // 7.1, 0.2
	def c11, 1.2, 0, 0, 0
	
	def c14, 0.0625, 0.0322581, 0.000926, 0.000617
	def c15, -0.500, -1.500, -1.581, 0.012
	def c16, -0.477, 1.507, 1.286, 0.920
	def c17, 1.272, -0.939, -1.000, -3.000
	def c18, -2.572, -1.839, -3.162, 0.024
	def c19, -2.544, 1.878, -0.954, 3.015
	def c20, 1.000, 3.000, 2.572, 1.839
	def c21, 3.162, -0.024, 2.544, -1.878
	def c22, 0.954, -3.015, -1.500, -4.500
	def c23, -3.201, -3.501, -4.348, -1.896
	def c24, -4.743, 0.036, -4.319, 1.962
	def c25, -3.147, 3.549, -1.432, 4.522
	def c26, 0.532, 4.714, 2.403, 4.090
	def c27, 3.859, 2.759, 4.647, 0.951
	def c28, 4.632, -1.021, 3.816, -2.817
	def c29, 2.340, -4.126, 0.460, -4.721
	
    defi i0, 7, 0, 0, 0
    dcl_texcoord v0.xy
    dcl_2d s0
    dcl_2d s1
    dcl_2d s2
    dcl_2d s3
    dcl_2d s4
    dcl_2d s5
    dcl_2d s6
    dcl_2d s7
	mov r31, c1.x
	add r31.y, c222.y, c222.w // dof || mb
	if_ne r31.x, r31.y
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
		mul r0.y, r0.z, r0.x
	endif
	
    mov r3, c4
    mad r4.xy, c76.xyxy, r3.xyxy, v0.xyxy
    mad r4.zw, c76.xyxy, r3.zxzx, v0.xyxy
    mad r6.xy, c76.xyxy, r3.wzwz, v0.xyxy
    mad r6.zw, c76.xyxy, r3.ywyw, v0.xyxy
    texld r7.xyz, v0, s2
    texld r3.xyz, r4.xy, s2
    texld r4.xyz, r4.zw, s2
    texld r5.xyz, r6.xy, s2
    texld r6.xyz, r6.zw, s2
	
	// depth of field
	if_ne r31.x, c222.y
		mad r1.w, r0.z, -r0.x, c78.w // cutscene
		mad r1.w, c78.y, -r3.w, r1.w // cutscene
		max r2.w, r1.w, c1.x // cutscene
		mad r0.x, r0.z, r0.x, -c78.w
		mad r0.x, c78.y, -r3.w, r0.x
		max r1.w, r0.x, c1.x
		rcp r0.x, c78.x // cutscene
		mul r0.x, r2.w, r0.x // cutscene
		lrp r2.w, r0.x, c79.x, c79.y // cutscene
		min r0.x, c79.x, r2.w // cutscene
		rcp r0.z, c78.z
		mul r0.z, r1.w, r0.z
		lrp r1.w, r0.z, c79.z, c79.y
		min r0.z, c79.z, r1.w
		max r0.z, r0.x, r0.z // cutscene
		mul r1.w, r0.z, r0.z
		
		// new scalable blur
		mov r20, c76.xyxy
		mul r20, r20, c44.y
		mov r21.xyz, r7 // center
		mov r21.w, c14.z
		if_ge r21.w, c44.w // use two rings for 1080p and below, three for above
			mul r20, r20, c14.z
			
			mad r22, r20, c15, v0.xyxy
			texldl r23.xyz, r22.xy, s2
			add r21.xyz, r21, r23
			texldl r23.xyz, r22.zw, s2
			add r21.xyz, r21, r23
			
			mad r22, r20, c16, v0.xyxy
			texldl r23.xyz, r22.xy, s2
			add r21.xyz, r21, r23
			texldl r23.xyz, r22.zw, s2
			add r21.xyz, r21, r23
			
			mad r22, r20, c17, v0.xyxy
			texldl r23.xyz, r22.xy, s2
			add r21.xyz, r21, r23
			texldl r23.xyz, r22.zw, s2
			add r21.xyz, r21, r23
			
			mad r22, r20, c18, v0.xyxy
			texldl r23.xyz, r22.xy, s2
			add r21.xyz, r21, r23
			texldl r23.xyz, r22.zw, s2
			add r21.xyz, r21, r23
			
			mad r22, r20, c19, v0.xyxy
			texldl r23.xyz, r22.xy, s2
			add r21.xyz, r21, r23
			texldl r23.xyz, r22.zw, s2
			add r21.xyz, r21, r23
			
			mad r22, r20, c20, v0.xyxy
			texldl r23.xyz, r22.xy, s2
			add r21.xyz, r21, r23
			texldl r23.xyz, r22.zw, s2
			add r21.xyz, r21, r23
			
			mad r22, r20, c21, v0.xyxy
			texldl r23.xyz, r22.xy, s2
			add r21.xyz, r21, r23
			texldl r23.xyz, r22.zw, s2
			add r21.xyz, r21, r23
			
			mad r22, r20, c22, v0.xyxy
			texldl r23.xyz, r22.xy, s2
			add r21.xyz, r21, r23
			
			mul r24.xyz, r21, c14.x
		else
			mul r20, r20, c14.w
			
			mad r22, r20, c15, v0.xyxy
			texldl r23.xyz, r22.xy, s2
			add r21.xyz, r21, r23
			texldl r23.xyz, r22.zw, s2
			add r21.xyz, r21, r23
			
			mad r22, r20, c16, v0.xyxy
			texldl r23.xyz, r22.xy, s2
			add r21.xyz, r21, r23
			texldl r23.xyz, r22.zw, s2
			add r21.xyz, r21, r23
			
			mad r22, r20, c17, v0.xyxy
			texldl r23.xyz, r22.xy, s2
			add r21.xyz, r21, r23
			texldl r23.xyz, r22.zw, s2
			add r21.xyz, r21, r23
			
			mad r22, r20, c18, v0.xyxy
			texldl r23.xyz, r22.xy, s2
			add r21.xyz, r21, r23
			texldl r23.xyz, r22.zw, s2
			add r21.xyz, r21, r23
			
			mad r22, r20, c19, v0.xyxy
			texldl r23.xyz, r22.xy, s2
			add r21.xyz, r21, r23
			texldl r23.xyz, r22.zw, s2
			add r21.xyz, r21, r23
			
			mad r22, r20, c20, v0.xyxy
			texldl r23.xyz, r22.xy, s2
			add r21.xyz, r21, r23
			texldl r23.xyz, r22.zw, s2
			add r21.xyz, r21, r23
			
			mad r22, r20, c21, v0.xyxy
			texldl r23.xyz, r22.xy, s2
			add r21.xyz, r21, r23
			texldl r23.xyz, r22.zw, s2
			add r21.xyz, r21, r23
			
			mad r22, r20, c22, v0.xyxy
			texldl r23.xyz, r22.xy, s2
			add r21.xyz, r21, r23
			texldl r23.xyz, r22.zw, s2
			add r21.xyz, r21, r23
			
			mad r22, r20, c23, v0.xyxy
			texldl r23.xyz, r22.xy, s2
			add r21.xyz, r21, r23
			texldl r23.xyz, r22.zw, s2
			add r21.xyz, r21, r23
			
			mad r22, r20, c24, v0.xyxy
			texldl r23.xyz, r22.xy, s2
			add r21.xyz, r21, r23
			texldl r23.xyz, r22.zw, s2
			add r21.xyz, r21, r23
			
			mad r22, r20, c25, v0.xyxy
			texldl r23.xyz, r22.xy, s2
			add r21.xyz, r21, r23
			texldl r23.xyz, r22.zw, s2
			add r21.xyz, r21, r23
			
			mad r22, r20, c26, v0.xyxy
			texldl r23.xyz, r22.xy, s2
			add r21.xyz, r21, r23
			texldl r23.xyz, r22.zw, s2
			add r21.xyz, r21, r23
			
			mad r22, r20, c27, v0.xyxy
			texldl r23.xyz, r22.xy, s2
			add r21.xyz, r21, r23
			texldl r23.xyz, r22.zw, s2
			add r21.xyz, r21, r23
			
			mad r22, r20, c28, v0.xyxy
			texldl r23.xyz, r22.xy, s2
			add r21.xyz, r21, r23
			texldl r23.xyz, r22.zw, s2
			add r21.xyz, r21, r23
			
			mad r22, r20, c29, v0.xyxy
			texldl r23.xyz, r22.xy, s2
			add r21.xyz, r21, r23
			texldl r23.xyz, r22.zw, s2
			add r21.xyz, r21, r23
			
			mul r24.xyz, r21, c14.y
		endif
	else
		mov r1.w, c2.w
		
		add r24.xyz, r3, r4
		add r24.xyz, r24, r5
		add r24.xyz, r24, r6
		mul r24.xyz, r24, c2.x
	endif
	
	// stipple filter
    dp3 r0.x, r7, c1.yzww
    dp3 r8.x, r3, c1.yzww
    dp3 r8.y, r4, c1.yzww
    dp3 r8.z, r5, c1.yzww
    dp3 r8.w, r6, c1.yzww
    dp4 r0.z, r8, c2.x
    add r8, r8, -r0.z
    dp4 r2.w, r8, r8
    add r0.x, r0.x, -r0.z
    mad r0.x, r0.x, r0.x, -r2.w
	if_ne r31.x, c223.z // Definition mask
		mov r20, c2.w
		mov r21, c76
		
		texld r22, v0, s7
		add r23, r22.x, -c8
		add_sat r23, -r23_abs, c10.y
		add r20, r20, r23
		add r23, r22.x, -c9
		add_sat r23, -r23_abs, c10.y
		add r20, r20, r23
		add r23.x, r22.x, -c10.x
		add_sat r23.x, -r23_abs, c10.y
		add r20.x, r20, r23
		
		mad r22.xy, r21, c2.yw, v0
		texldl r22, r22, s7
		add r23, r22.x, -c8
		add_sat r23, -r23_abs, c10.y
		add r20, r20, r23
		add r23, r22.x, -c9
		add_sat r23, -r23_abs, c10.y
		add r20, r20, r23
		add r23.x, r22.x, -c10.x
		add_sat r23.x, -r23_abs, c10.y
		add r20.x, r20, r23
		
		mad r22.xy, r21, c2.wy, v0
		texldl r22, r22, s7
		add r23, r22.x, -c8
		add_sat r23, -r23_abs, c10.y
		add r20, r20, r23
		add r23, r22.x, -c9
		add_sat r23, -r23_abs, c10.y
		add r20, r20, r23
		add r23.x, r22.x, -c10.x
		add_sat r23.x, -r23_abs, c10.y
		add r20.x, r20, r23
		
		mad r22.xy, r21, c2.yy, v0
		texldl r22, r22, s7
		add r23, r22.x, -c8
		add_sat r23, -r23_abs, c10.y
		add r20, r20, r23
		add r23, r22.x, -c9
		add_sat r23, -r23_abs, c10.y
		add r20, r20, r23
		add r23.x, r22.x, -c10.x
		add_sat r23.x, -r23_abs, c10.y
		add r20.x, r20, r23
		
		dp4 r20.x, r20, c2.y
		cmp r0.x, -r20_abs.x, -c2.y, r0.x
	endif
    cmp r0.x, r0.x, c2.y, r1.w
	
	// average
    add r0.z, -r0.x, c2.y
	mul r3.xyz, r24, r0.x
	mad r3.xyz, r7, r0.z, r3
	
	// motion blur
	if_ne r31.x, c222.w
		mad r4.xyz, v0.yxyw, c5.x, c5.y
		mul r0.z, r4.y, c77.z
		mul r0.z, r0.y, r0.z
		mul r1.w, -r4.x, c77.w
		mul r1.w, r0.y, r1.w
		mul r5.xyz, r1.w, c73
		mad r5.xyz, r0.z, c72, r5
		mad r5.xyz, -r0.y, c74, r5
		add r5.xyz, r5, c75
		mul r0.y, -r5.z, c77.z
		rcp r0.y, r0.y
		mul r6.x, r5.x, r0.y
		mul r0.y, r5.z, c77.w
		rcp r0.y, r0.y
		mul r6.y, r5.y, r0.y
		add r0.yz, -r4, r6.xxyw
		mov r20.x, c221.z // fix motion blur at high fps
		mul_sat r20.x, r20.x, c80.x
		mul r0.yz, r0, r20.x
		mul r4.xy, r0.yzzw, c5.z
		texld r5, v0, s7
		add r1.w, r5.x, -c86.x
		mul r4.zw, c0.xyxy, v0.xyxy
		mad r4.zw, r3.xyxy, c3.w, r4
		texldl r5, r4.zwzw, s6
		add r2.w, r5.x, c4.x
		mad r4.zw, r4.xyxy, r2.w, v0.xyxy
		mov r5.xyz, r3
		mov r2.w, c2.y
		mov r3.w, c2.y
		rep i0
		  mad r6.xy, r4, r3.w, r4.zwzw
		  texldl r7, r6, s7
		  add r5.w, r7.x, -c86.x
		  cmp r5.w, r5.w, c2.w, c2.y
		  texldl r6, r6, s2
		  mad r5.xyz, r6, r5.w, r5
		  add r2.w, r2.w, r5.w
		  add r3.w, r3.w, c2.y
		endrep
		rcp r2.w, r2.w
		mul r0.yz, r0, c44.xxyw
		dp2add r0.y, r0.yzzw, r0.yzzw, c1.x
		rsq r0.y, r0.y
		rcp r0.y, r0.y
		mul r0.y, r0.y, c4.w
		add r0.x, r0.x, c2.y
		rcp r0.x, r0.x
		mul_sat r0.x, r0.y, r0.x
		mad r4.xyz, r5, r2.w, -r3
		mad r0.xyz, r0.x, r4, r3
		cmp r3.xyz, r1.w, r3, r0
	endif
	
	// noise
	if_ne r31.x, c220.y
		mov r1.zw, c0
		mad r1.xy, v0, r1.zwzw, c85
		frc r1.xy, r1
		mul r1.xy, r1.xy, c221.x // fix noise being affected by water quality: Low, Medium, High, Very High = 2, 1, 0.5, 0.25
		mul r1.x, r1.x, c44.x
		mul r1.x, r1.x, c44.w // *(width/height): fix noise aspect ratio
		texldl r1, r1, s3
		add r0.w, r1.z, c4.x
		mul r0.w, r0.w, c85.z
		mad r3.xyz, r0.w, c6.x, r3
	endif
	
    texld r1, c1.x, s5
    rcp r0.w, r1.x
    mul r0.w, r0.w, c81.y
	
	// bloom
	if_ne r31.x, c220.x
		rcp r1.x, r0.w
		mul r1.x, r1.x, c81.x
		texld r2, v0, s4
		mad r1.xyz, r2, c66.x, -r1.x
		mul r2.xyz, r1, c81.z
		mul r2.xyz, r2, c2.x
		cmp r1.xyz, r1, r2, c1.x
		mad r0.xyz, r3, c66.x, r1
	else
		mul r0.xyz, r3, c66.x
	endif
	
    mul r1.xyz, r0.w, r0
    dp3 r1.x, r1, c1.yzww
    mad r0.xyz, r0, r0.w, -r1.x
    mad r0.xyz, c82.x, r0, r1.x
    mul r0.w, r1.x, c84.w
    mul r1.yzw, r0.w, c84.xxyz
    mov_sat r2.x, r0.w
    mad r0.xyz, c84, -r0.w, r0
    mad r0.xyz, r2.x, r0, r1.yzww
    mul r0.xyz, r0, c83
    add r0.xyz, r0, r0
    mov_sat r1.x, r1.x
    mov r8.y, c2.y
    add r0.w, -r8.y, c82.z
    pow r2.x, r1.x, r0.w
	if_ne r31.x, c222.z // PS3-like gamma
		mul_sat r0.xyz, r0, r2.x
		pow r0.x, r0.x, c11.x
		pow r0.y, r0.y, c11.x
		pow r0.z, r0.z, c11.x
		mov oC0.xyz, r0
	else
		mul oC0.xyz, r0, r2.x
	endif
    mov oC0.w, c2.y

// approximately 176 instruction slots used (14 texture, 162 arithmetic)
