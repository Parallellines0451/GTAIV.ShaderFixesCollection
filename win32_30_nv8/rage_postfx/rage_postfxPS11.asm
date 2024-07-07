// Summary: changes derived from PS26
// Generated by Microsoft (R) HLSL Shader Compiler 9.26.952.2844
//
// Parameters:
//
//   sampler2D StippleTexture;
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
//   StippleTexture               s10      1
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
    def c219, 1.8395173895e+25, 3.9938258725e+24, 4.5435787456e+30, 1.1406569500e-42 // 814
    def c127, 0.9999999, 1, 0, 0	// LogDepth constants
    def c0, 58.1640015, 47.1300011, 3.20000005, 1.79999995
    def c1, 0, 0.212500006, 0.715399981, 0.0720999986
    def c2, 0.25, 1, 0.5, 0
    def c3, 0, 2, 4, 8
    def c4, -0.5, -1.5, 1.5, 0.5
    def c5, 2, -1, 0.125, 0
    def c6, 1.10000002, 0, 0, 0
	
	def c11, 1.06, 0.002, 1.15, 0.03125
	
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
    dcl_2d s10
    mov r31, c2.w
	// depth used by DOF
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
	
	// samples used by DOF and stipple filter
    mov r3, c4
    mad r4, c76.xyxy, r3.xyzx, v0.xyxy
    mad r6, c76.xyxy, r3.wzyw, v0.xyxy
    texld r7.xyz, v0, s2
    texld r3.xyz, r4.xy, s2
    texld r4.xyz, r4.zw, s2
    texld r5.xyz, r6.xy, s2
    texld r6.xyz, r6.zw, s2
	
	// depth of field
    mad r0.x, r0.z, r0.x, -c78.w
    mad r0.x, c78.y, -r3.w, r0.x
    max r1.w, r0.x, c1.x
    rcp r0.z, c78.z
    mul r0.z, r1.w, r0.z
    lrp r1.w, r0.z, c79.z, c79.y
    min r0.z, c79.z, r1.w
    mul r1.w, r0.z, r0.z
	
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
    cmp r0.x, r0.x, c2.y, r1.w
	
	// depth of field and stipple filter average
	add r3.xyz, r3, r4
	add r3.xyz, r3, r5
	add r3.xyz, r3, r6
	mul r3.xyz, r3, c2.x
	lrp r3.xyz, r0.x, r3, r7
	
	// tonemap and color correction
    texld r1, c1.x, s5
    rcp r0.w, r1.x
    mul r0.w, r0.w, c81.y
	
	// bloom
    rcp r1.x, r0.w
    mul r1.x, r1.x, c81.x
    texld r2, v0, s4
    mad r1.xyz, r2, c66.x, -r1.x
    mul r2.xyz, r1, c81.z
    mul r2.xyz, r2, c2.x
    cmp r1.xyz, r1, r2, c1.x
    mad r0.xyz, r3, c66.x, r1
	
	// tonemap and color correction
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
    mov r20.x, c11.x
    mad r0.w, r20.x, c82.z, -r8.y // boost timecyc gamma
    pow r2.x, r1.x, r0.w
    mul_sat r0.xyz, r0, r2.x
	
	// XBOX-like gamma, just an approximation
	if_ne r31.x, c222.z
		pow r20.x, r0.x, c11.z
		pow r20.y, r0.y, c11.z
		pow r20.z, r0.z, c11.z
		add r21.xyz, c2.y, -r0
		mul r21.xyz, r21, r21
		mul r21.xyz, r21, r21
		mad r21.xyz, r21, -r21, c2.y
		mul_sat r0.xyz, r20, r21
	endif
	
	// dithering
	mul r1.xy, v0.xy, c44.xy
	mul r1.xy, r1.xy, c11.w
	texld r1, r1, s10
	mad r1.z, r1.z, c5.x, c5.y
	mad_sat oC0.xyz, r1.z, c11.y, r0
    mov oC0.w, c2.y

// approximately 176 instruction slots used (14 texture, 162 arithmetic)
