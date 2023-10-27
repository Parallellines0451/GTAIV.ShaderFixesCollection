// Added FXAA thanks to RaphaelK12, fixed blurry screen, improved Definition, console-like gamma + dithering mask + HQ motion blur + fixed motion blur FPS scaling
// Custom registers: c222, 221
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
	def c11, 0.0166667, 0, 0, 0 // frametime target (normally it'd be 0.0333333, but it's halved because motion blur sample count is doubled)
	// --------------------------------------------------------------- FXAA Constants ---------------------------------------------------------------
	// NVIDIA FXAA 3.11 by Timothy Lottes
	def c20, 0.25, 0, 0, 0		// Subpix				0.25, 0, 0, 0
	def c21, 0.125, 0, 0, 0		// EdgeThreshold		0.125, 0, 0, 0
	def c22, 0, 0, 0, 0			// EdgeThresholdMin		0, 0, 0, 0
    def c23, 0.0833333358, 0.5, -2, 3
    def c24, 0.25, 1.5, 4, 12
    def c25, 1, 0, -1, -2
	def c26, 0.298999995, 0.587000012, 0.114, 0
	// ----------------------------------------------------------------------------------------------------------------------------------------------
	// ---------------------------------------------------------- Dithering Mask Constants ----------------------------------------------------------
	def c130, -1, 0, 1, 0
	def c131, 0.01171875, 0.015625, 0.0234375, 2 // xyz = 3, 4, 6
	defi i1, 3, 0, 0, 0
	// ----------------------------------------------------------------------------------------------------------------------------------------------
    defi i0, 14, 0, 0, 0  // doubled motion blur samples
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
	mov r23, c130.y
	mov r24.xy, c130.x
	rep i1
		rep i1
			mad r21.xy, c76, r24.xy, v0
			texld r21, r21, s5
			add r25.xyz, r21.x, -c131
			cmp r22.xyz, -r25_abs, c130.z, c130.y
			add r23.xyz, r23, r22
			add r24.y, r24.y, c130.z
		endrep
		mad r24.xy, r24.x, c130.zw, c130.zx
	endrep
	dp3 r30.x, r23, c130.z
	// ----------------------------------------------------------------------------------------------------------------------------------------------
	// -------------------------------------------------------------------- FXAA --------------------------------------------------------------------
	if_ne c222.x, r31.x
		if_le r30.x, c1.x
			mov r11, c76
			mul r13, c25.xxyy, v0.xyxx
			texldl r13, r13, s2
			mul r12.xyz, r13, r13
			dp3 r13.w, r12, c26
			rsq r13.w, r13.w
			rcp r13.w, r13.w
			mov r14.xyz, c25
			mad r15.xyz, r11.yxyw, r14.xxyw, v0.yxyw
			mul r16.xzw, c25.xyyy, v0.x
			mov r16.y, r15.x
			texldl r16, r16, s2
			mul r12.xyz, r16, r16
			dp3 r16.w, r12, c26
			rsq r16.w, r16.w
			rcp r16.w, r16.w
			mul r15, r15.yzyy, c25.xxyy
			texldl r15, r15, s2
			mul r12.xyz, r15, r15
			dp3 r15.w, r12, c26
			rsq r15.w, r15.w
			rcp r15.w, r15.w
			mad r15.xyz, r11.yxyw, r14.zzyw, v0.yxyw
			mul r17.xzw, c25.xyyy, v0.x
			mov r17.y, r15.x
			texldl r17, r17, s2
			mul r12.xyz, r17, r17
			dp3 r17.w, r12, c26
			rsq r17.w, r17.w
			rcp r17.w, r17.w
			mul r18, r15.yzyy, c25.xxyy
			texldl r18, r18, s2
			mul r12.xyz, r18, r18
			dp3 r18.w, r12, c26
			rsq r18.w, r18.w
			rcp r18.w, r18.w
			max r14.w, r16.w, r13.w
			min r15.x, r13.w, r16.w
			max r16.x, r15.w, r14.w
			min r14.w, r15.x, r15.w
			max r15.x, r17.w, r18.w
			min r15.y, r18.w, r17.w
			max r17.x, r15.x, r16.x
			min r16.x, r14.w, r15.y
			mul r14.w, r17.x, c21.x
			add r15.x, -r16.x, r17.x
			max r15.y, c22.x, r14.w
			if_lt r15.x, r15.y
			else
			add r19.xy, -r11, v0
			mov r19.zw, c25.y
			texldl r19, r19, s2
			mul r12.xyz, r19, r19
			dp3 r19.w, r12, c26
			rsq r19.w, r19.w
			rcp r19.w, r19.w
			add r20.xy, r11, v0
			mov r20.zw, c25.y
			texldl r20, r20, s2
			mul r12.xyz, r20, r20
			dp3 r20.w, r12, c26
			rsq r20.w, r20.w
			rcp r20.w, r20.w
			mad r21, r11.xyxy, r14.xzzx, v0.xyxy
			mul r22, r21.xyxx, c25.xxyy
			texldl r22, r22, s2
			mul r12.xyz, r22, r22
			dp3 r22.w, r12, c26
			rsq r22.w, r22.w
			rcp r22.w, r22.w
			mul r21, r21.zwxx, c25.xxyy
			texldl r21, r21, s2
			mul r12.xyz, r21, r21
			dp3 r21.w, r12, c26
			rsq r21.w, r21.w
			rcp r21.w, r21.w
			add r14.x, r16.w, r17.w
			add r14.z, r15.w, r18.w
			rcp r14.w, r15.x
			add r15.x, r14.z, r14.x
			mad r14.x, r13.w, c25.w, r14.x
			mad r14.z, r13.w, c25.w, r14.z
			add r15.y, r20.w, r22.w
			add r15.z, r19.w, r22.w
			mad r16.x, r15.w, c25.w, r15.y
			mad r15.z, r17.w, c25.w, r15.z
			add r16.y, r19.w, r21.w
			add r16.z, r20.w, r21.w
			mad r14.x, r14_abs.x, -c25.w, r16_abs.x
			mad r14.z, r14_abs.z, -c25.w, r15_abs.z
			mad r15.z, r18.w, c25.w, r16.y
			mad r16.x, r16.w, c25.w, r16.z
			add r14.x, r14.x, r15_abs.z
			add r14.z, r14.z, r16_abs.x
			add r15.y, r15.y, r16.y
			add r14.x, -r14.z, r14.x
			mad r14.z, r15.x, -c25.w, r15.y
			cmp r15.x, r14.x, r17.w, r18.w
			cmp r15.y, r14.x, r16.w, r15.w
			cmp r15.z, r14.x, r11.y, r11.x
			mad r14.z, r14.z, c23.x, -r13.w
			add r15.w, -r13.w, r15.x
			add r16.x, -r13.w, r15.y
			add r15.xy, r13.w, r15
			add r16.y, r15_abs.w, -r16_abs.x
			max r17.x, r15_abs.w, r16_abs.x
			cmp r15.z, r16.y, -r15.z, r15.z
			mul_sat r14.z, r14.w, r14_abs.z
			cmp r14.w, r14.x, r11.x, r14.y
			cmp r14.y, r14.x, r14.y, r11.y
			mad r16.xz, r15.z, c23.y, v0.xyyw
			cmp r15.w, r14.x, v0.x, r16.x
			cmp r16.x, r14.x, r16.z, v0.y
			add r18.x, -r14.w, r15.w
			add r18.y, -r14.y, r16.x
			add r19.x, r14.w, r15.w
			add r19.y, r14.y, r16.x
			mad r15.w, r14.z, c23.z, c23.w
			mov r18.zw, c25.y
			texldl r20, r18, s2
			mul r12.xyz, r20, r20
			dp3 r20.w, r12, c26
			rsq r20.w, r20.w
			rcp r20.w, r20.w
			mul r14.z, r14.z, r14.z
			mov r19.zw, c25.y
			texldl r21, r19, s2
			mul r12.xyz, r21, r21
			dp3 r21.w, r12, c26
			rsq r21.w, r21.w
			rcp r21.w, r21.w
			cmp r15.x, r16.y, r15.x, r15.y
			mul r15.y, r17.x, c24.x
			mad r16.x, r15.x, -c23.y, r13.w
			mul r14.z, r14.z, r15.w
			mad r16.y, r15.x, -c23.y, r20.w
			mad r16.z, r15.x, -c23.y, r21.w
			mad r17.yz, r17.x, -c24.x, r16_abs
			mad r15.w, r14.w, -c24.y, r18.x
			cmp r20.x, r17.y, r18.x, r15.w
			mad r15.w, r14.y, -c24.y, r18.y
			cmp r20.y, r17.y, r18.y, r15.w
			cmp r18.xy, r17.yzzw, c25.y, c25.x
			add r15.w, r18.y, r18.x
			mad r16.w, r14.w, c24.y, r19.x
			cmp r18.x, r17.z, r19.x, r16.w
			mad r16.w, r14.y, c24.y, r19.y
			cmp r18.y, r17.z, r19.y, r16.w
			if_lt -r15.w, c25.y
				if_ge r16_abs.y, r15.y
				else
				mov r20.zw, c25.y
				texldl r19, r20, s2
				mul r12.xyz, r19, r19
				dp3 r19.w, r12, c26
				rsq r19.w, r19.w
				rcp r19.w, r19.w
				mov r16.y, r19.w
				endif
				if_ge r16_abs.z, r15.y
				else
				mov r18.zw, c25.y
				texldl r19, r18, s2
				mul r12.xyz, r19, r19
				dp3 r19.w, r12, c26
				rsq r19.w, r19.w
				rcp r19.w, r19.w
				mov r16.z, r19.w
				endif
				mad r15.w, r15.x, -c23.y, r16.y
				cmp r16.y, r17.y, r16.y, r15.w
				mad r15.w, r15.x, -c23.y, r16.z
				cmp r16.z, r17.z, r16.z, r15.w
				mad r17.yz, r17.x, -c24.x, r16_abs
				mad r15.w, r14.w, c25.w, r20.x
				cmp r20.x, r17.y, r20.x, r15.w
				mad r15.w, r14.y, c25.w, r20.y
				cmp r20.y, r17.y, r20.y, r15.w
				cmp r19.xy, r17.yzzw, c25.y, c25.x
				add r15.w, r19.y, r19.x
				mad r16.w, r14.w, -c25.w, r18.x
				cmp r18.x, r17.z, r18.x, r16.w
				mad r16.w, r14.y, -c25.w, r18.y
				cmp r18.y, r17.z, r18.y, r16.w
				if_lt -r15.w, c25.y
				if_ge r16_abs.y, r15.y
				else
					mov r20.zw, c25.y
					texldl r19, r20, s2
					mul r12.xyz, r19, r19
					dp3 r19.w, r12, c26
					rsq r19.w, r19.w
					rcp r19.w, r19.w
					mov r16.y, r19.w
				endif
				if_ge r16_abs.z, r15.y
				else
					mov r18.zw, c25.y
					texldl r19, r18, s2
					mul r12.xyz, r19, r19
					dp3 r19.w, r12, c26
					rsq r19.w, r19.w
					rcp r19.w, r19.w
					mov r16.z, r19.w
				endif
				mad r15.w, r15.x, -c23.y, r16.y
				cmp r16.y, r17.y, r16.y, r15.w
				mad r15.w, r15.x, -c23.y, r16.z
				cmp r16.z, r17.z, r16.z, r15.w
				mad r17.yz, r17.x, -c24.x, r16_abs
				mad r15.w, r14.w, c25.w, r20.x
				cmp r20.x, r17.y, r20.x, r15.w
				mad r15.w, r14.y, c25.w, r20.y
				cmp r20.y, r17.y, r20.y, r15.w
				cmp r19.xy, r17.yzzw, c25.y, c25.x
				add r15.w, r19.y, r19.x
				mad r16.w, r14.w, -c25.w, r18.x
				cmp r18.x, r17.z, r18.x, r16.w
				mad r16.w, r14.y, -c25.w, r18.y
				cmp r18.y, r17.z, r18.y, r16.w
				if_lt -r15.w, c25.y
					if_ge r16_abs.y, r15.y
					else
					mov r20.zw, c25.y
					texldl r19, r20, s2
					mul r12.xyz, r19, r19
					dp3 r19.w, r12, c26
					rsq r19.w, r19.w
					rcp r19.w, r19.w
					mov r16.y, r19.w
					endif
					if_ge r16_abs.z, r15.y
					else
					mov r18.zw, c25.y
					texldl r19, r18, s2
					mul r12.xyz, r19, r19
					dp3 r19.w, r12, c26
					rsq r19.w, r19.w
					rcp r19.w, r19.w
					mov r16.z, r19.w
					endif
					mad r15.w, r15.x, -c23.y, r16.y
					cmp r16.y, r17.y, r16.y, r15.w
					mad r15.w, r15.x, -c23.y, r16.z
					cmp r16.z, r17.z, r16.z, r15.w
					mad r17.yz, r17.x, -c24.x, r16_abs
					mad r15.w, r14.w, c25.w, r20.x
					cmp r20.x, r17.y, r20.x, r15.w
					mad r15.w, r14.y, c25.w, r20.y
					cmp r20.y, r17.y, r20.y, r15.w
					cmp r19.xy, r17.yzzw, c25.y, c25.x
					add r15.w, r19.y, r19.x
					mad r16.w, r14.w, -c25.w, r18.x
					cmp r18.x, r17.z, r18.x, r16.w
					mad r16.w, r14.y, -c25.w, r18.y
					cmp r18.y, r17.z, r18.y, r16.w
					if_lt -r15.w, c25.y
					if_ge r16_abs.y, r15.y
					else
						mov r20.zw, c25.y
						texldl r19, r20, s2
						mul r12.xyz, r19, r19
						dp3 r19.w, r12, c26
						rsq r19.w, r19.w
						rcp r19.w, r19.w
						mov r16.y, r19.w
					endif
					if_ge r16_abs.z, r15.y
					else
						mov r18.zw, c25.y
						texldl r19, r18, s2
						mul r12.xyz, r19, r19
						dp3 r19.w, r12, c26
						rsq r19.w, r19.w
						rcp r19.w, r19.w
						mov r16.z, r19.w
					endif
					mad r15.w, r15.x, -c23.y, r16.y
					cmp r16.y, r17.y, r16.y, r15.w
					mad r15.w, r15.x, -c23.y, r16.z
					cmp r16.z, r17.z, r16.z, r15.w
					mad r17.yz, r17.x, -c24.x, r16_abs
					mad r15.w, r14.w, c25.w, r20.x
					cmp r20.x, r17.y, r20.x, r15.w
					mad r15.w, r14.y, c25.w, r20.y
					cmp r20.y, r17.y, r20.y, r15.w
					cmp r19.xy, r17.yzzw, c25.y, c25.x
					add r15.w, r19.y, r19.x
					mad r16.w, r14.w, -c25.w, r18.x
					cmp r18.x, r17.z, r18.x, r16.w
					mad r16.w, r14.y, -c25.w, r18.y
					cmp r18.y, r17.z, r18.y, r16.w
					if_lt -r15.w, c25.y
						if_ge r16_abs.y, r15.y
						else
						mov r20.zw, c25.y
						texldl r19, r20, s2
						mul r12.xyz, r19, r19
						dp3 r19.w, r12, c26
						rsq r19.w, r19.w
						rcp r19.w, r19.w
						mov r16.y, r19.w
						endif
						if_ge r16_abs.z, r15.y
						else
						mov r18.zw, c25.y
						texldl r19, r18, s2
						mul r12.xyz, r19, r19
						dp3 r19.w, r12, c26
						rsq r19.w, r19.w
						rcp r19.w, r19.w
						mov r16.z, r19.w
						endif
						mad r15.w, r15.x, -c23.y, r16.y
						cmp r16.y, r17.y, r16.y, r15.w
						mad r15.w, r15.x, -c23.y, r16.z
						cmp r16.z, r17.z, r16.z, r15.w
						mad r17.yz, r17.x, -c24.x, r16_abs
						mad r15.w, r14.w, -c24.z, r20.x
						cmp r20.x, r17.y, r20.x, r15.w
						mad r15.w, r14.y, -c24.z, r20.y
						cmp r20.y, r17.y, r20.y, r15.w
						cmp r19.xy, r17.yzzw, c25.y, c25.x
						add r15.w, r19.y, r19.x
						mad r16.w, r14.w, c24.z, r18.x
						cmp r18.x, r17.z, r18.x, r16.w
						mad r16.w, r14.y, c24.z, r18.y
						cmp r18.y, r17.z, r18.y, r16.w
						if_lt -r15.w, c25.y
						if_ge r16_abs.y, r15.y
						else
							mov r20.zw, c25.y
							texldl r19, r20, s2
							mul r12.xyz, r19, r19
							dp3 r19.w, r12, c26
							rsq r19.w, r19.w
							rcp r19.w, r19.w
							mov r16.y, r19.w
						endif
						if_ge r16_abs.z, r15.y
						else
							mov r18.zw, c25.y
							texldl r19, r18, s2
							mul r12.xyz, r19, r19
							dp3 r19.w, r12, c26
							rsq r19.w, r19.w
							rcp r19.w, r19.w
							mov r16.z, r19.w
						endif
						mad r15.y, r15.x, -c23.y, r16.y
						mad r15.x, r15.x, -c23.y, r16.z
						cmp r16.yz, r17, r16, r15.xyxw
						mad r15.xy, r17.x, -c24.x, r16_abs.yzzw
						mad r15.w, r14.w, -c24.w, r20.x
						cmp r20.x, r15.x, r20.x, r15.w
						mad r15.w, r14.y, -c24.w, r20.y
						cmp r20.y, r15.x, r20.y, r15.w
						mad r14.w, r14.w, c24.w, r18.x
						mad r14.y, r14.y, c24.w, r18.y
						cmp r18.xy, r15.y, r18, r14.wyzw
						endif
					endif
					endif
				endif
				endif
			endif
			add r14.y, -r20.x, v0.x
			add r14.w, r18.x, -v0.x
			add r15.x, -r20.y, v0.y
			cmp r14.y, r14.x, r14.y, r15.x
			add r15.x, r18.y, -v0.y
			cmp r14.w, r14.x, r14.w, r15.x
			cmp r15.xy, r16.yzzw, c25.y, c25.x
			cmp r15.w, r16.x, -c25.y, -c25.x
			add r15.xy, r15.w, r15
			add r15.w, r14.y, r14.w
			rcp r15.w, r15.w
			add r16.x, -r14.w, r14.y
			min r16.y, r14.w, r14.y
			cmp r14.y, r16.x, r15_abs.y, r15_abs.x
			mul r14.z, r14.z, r14.z
			mad r14.w, r16.y, -r15.w, c23.y
			mul r14.z, r14.z, c20.x
			cmp r14.y, -r14.y, c25.y, r14.w
			max r15.x, r14.y, r14.z
			mad r14.yz, r15.x, r15.z, v0.xxyw
			cmp r15.x, r14.x, v0.x, r14.y
			cmp r15.y, r14.x, r14.z, v0.y
			mov r15.zw, c25.y
			texldl r14, r15, s2
			mul r12.xyz, r14, r14
			dp3 r14.w, r12, c26
			rsq r14.w, r14.w
			rcp r14.w, r14.w
			mov r13.xyz, r14
			endif
			mov r1, r13
		else
			texld r1, v0, s2
		endif
	else
		texld r1, v0, s2
	endif
	// ----------------------------------------------------------------------------------------------------------------------------------------------
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
	mov r0.y, c223.z
	add r0.y, r0.y, -c2.z
	cmp r30.x, r0.y, r30.x, -c2.z
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
	rcp r20.x, c221.z
	mul r20.x, r20.x, c11.x
	mul r20.x, r20.x, c79.x
	min r20.x, r20.x, c4.w
    mul r0.xz, r0, r20.x
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
