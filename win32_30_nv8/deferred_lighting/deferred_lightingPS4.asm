// Summary: Console-like ambient reflection intensity + console tree lighting thanks to AssaultKifle47 + dithering mask + fixed trees' orange glow
// Custom registers: c223
// Generated by Microsoft (R) HLSL Shader Compiler 9.26.952.2844
//
// Parameters:
//
//   sampler2D GBufferStencilTextureSampler;
//   sampler2D GBufferTextureSampler0;
//   sampler2D GBufferTextureSampler1;
//   sampler2D GBufferTextureSampler2;
//   sampler2D GBufferTextureSampler3;
//   sampler2D ParabSampler;
//   float4 dReflectionParams;
//   float4 gDeferredProjParams;
//   float4 gDirectionalColour;
//   float4 gDirectionalLight;
//   float4 gLightAmbient0;
//   float4 gLightAmbient1;
//   float4 globalScalars;
//
//
// Registers:
//
//   Name                         Reg   Size
//   ---------------------------- ----- ----
//   gDirectionalLight            c17      1
//   gDirectionalColour           c18      1
//   gLightAmbient0               c37      1
//   gLightAmbient1               c38      1
//   globalScalars                c39      1
//   gDeferredProjParams          c66      1
//   dReflectionParams            c72      1
//   GBufferTextureSampler0       s0       1
//   GBufferTextureSampler1       s1       1
//   GBufferTextureSampler2       s2       1
//   GBufferTextureSampler3       s4       1
//   GBufferStencilTextureSampler s5       1
//   ParabSampler                 s6       1
//

    ps_3_0
    def c219, 1.8395173895e+25, 3.9938258725e+24, 4.5435787456e+30, 1.2611686179e-44 // 9
    def c127, 0.9999999, 1, 0, 0	// LogDepth constants
    def c0, 0, 512, 4096, 0.00200000009
    def c1, 0.99609375, 7.96875, 63.75, 0.25
    def c2, 256, -127.999992, 0.000392156857, 4
    def c3, 2, 0.5, 1, 9.99999975e-006
    def c4, 1.33333337, -0.5, 0.5, 5
    def c5, 0.0199999996, 0.00999999978, 0.75, 0.25
    def c6, 10, 1, 0, 0
	def c20, 1.6666667, 0, 0, 0	// Reflection intensity multiplier
	def c21, 3, 2, 1, 0	// Console tree lighting constants
	def c22, 0.01171875, 0.01953125, 0.0234375, 0
	def c23, 0.35, 0.5, 0.3333333, 0
    dcl_texcoord v0.xy
    dcl_texcoord1 v1
    dcl_2d s0
    dcl_2d s1
    dcl_2d s2
    dcl_2d s4
    dcl_2d s5
    dcl_2d s6
	
	texld r21, v0, s5
	add r21.yz, r21.x, -c22
	cmp r21.yz, -r21_abs, c6.y, c6.z
	add_sat r21.x, r21.y, r21.z // masks 5 and 6
	mov r21.y, c223.x
	add r21.y, r21.y, -c21.y
	cmp r21.y, -r21_abs.y, r21.x, c0.x	// Console tree lighting toggle
	if_eq r21.y, c0.x
		texld r0, v0, s1
		mul r1.xyz, r0.w, c1
		frc r1.xyz, r1
		add r2.xyz, r1, r1
		mad r2.xy, r1.yzzw, -c1.w, r2
		mad r0.xyz, r0, c2.x, r2
		add r0.xyz, r0, c2.y
		nrm r1.xyz, r0
		texld r0, v0, s4
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
		mad r0.x, r0.x, c66.z, -c66.w
		mul r0.x, r0.x, v1.w
		rcp r0.x, r0.x
		mad r0.yzw, v1.xxyz, -r0.x, c3.w
		mul r2.xyz, r0.x, v1
		nrm r3.xyz, r0.yzww
		dp3 r0.x, r3, r1
		add r0.y, r0.x, r0.x
		add r0.x, -r0_abs.x, c3.z
		mul r0.x, r0.x, r0.x
		mul r0.x, r0.x, r0.x
		mad r0.x, r0.x, c5.z, c5.w
		mad r0.yzw, r1.xxyz, -r0.y, r3.xxyz
		dp3 r1.w, r3, -r2
		mul_sat r2.xy, r1.w, c5
		mad r0.yzw, r3.xxyz, r2.x, r0
		add r1.w, -r2.y, c3.z
		add r0.yzw, r0, c3.w
		nrm r2.xyz, r0.yzww
		mov_sat r0.y, r2.z
		add r0.y, r0.y, c3.z
		add r0.y, r0.y, r0.y
		rcp r0.y, r0.y
		mad r0.yz, r2.xxyw, r0.y, c3.y
		mul_sat r0.w, r2.z, c4.w
		add r2.xy, -r0.yzzw, c3.z
		mul r0.y, r1.z, c2.w
		mov_sat r0.y, r0.y
		mul r0.y, r0.y, c72.y
		texld r3, v0, s5
		add r20.xy, r3.x, -c22.xw
		cmp r20.xy, -r20_abs.xy, c6.y, c6.z
		add_sat r20.x, r20.x, r20.y
		add r3.x, r20.x, -c6.y // masks 0 and 3 (0 by default)
		cmp r0.y, r3.x, r0.y, c0.x
		texld r3, v0, s2
		mul r0.z, r3.y, r3.y
		mul r3.yw, r0.z, c0.xyzz
		min r4.x, r3.w, c2.x
		mad r0.z, r0.z, -c0.y, r4.x
		mad r0.z, r0.y, r0.z, r3.y
		max r4.x, r3.y, r0.z
		mul_sat r0.z, r4.x, c72.x
		mul r3.y, r4.x, c0.w
		min r4.x, r3.y, c1.w
		mad r3.y, r3.x, -c3.x, r4.x
		mad r2.w, r0.z, -c2.w, c2.w
		mov r2.z, c0.x
		texldl r2, r2, s6
		mul r2, r2, c20.x	// reflection intensity tweak
		mul r2.xyz, r0.w, r2
		mul r2.xyz, r1.w, r2
		mul r2.xyz, r3.z, r2
		mul r2.xyz, r2, c39.w
		mul r0.xzw, r0.x, r2.xyyz
		add r1.w, r3.x, r3.x
		mad r2.x, r0.y, r3.y, r1.w
		mad r0.y, r0.y, -c3.y, c3.z
		max r3.x, r1.w, r2.x
		mul r0.xzw, r0, r3.x
		mul r0.xzw, r0, c6.x
		texld r2, v0, s0
		mul r2.xyz, r0.y, r2
		mad_sat r0.y, r1.z, c4.y, c4.z
		dp3 r1.x, r1, -c17
		add r1.x, r1.x, -c1.w
		mul_sat r1.x, r1.x, c4.x
		mov r10, c38
		mov r11, c37
		if_ne -r21_abs.x, c0.x // Tree orange glow fix
			dp3 r12.x, r10, c23.z
			dp3 r12.y, r11, c23.z
			lrp r10, c23.x, r10, r12.x
			lrp r11, c23.y, r11, r12.y
		endif
		mov r4.xyz, r10
		mad r1.yzw, r4.xxyz, r0.y, r11.xxyz
		mul r1.yzw, r3.z, r1
		mul r3.xyz, c18.w, c18
		mad r1.xyz, r3, r1.x, r1.yzww
		mad oC0.xyz, r2, r1, r0.xzww
		mov oC0.w, c3.z
	else
		texld r0, v0, s1
		mul r1.xyz, r0.w, c1
		frc r1.xyz, r1
		add r2.xyz, r1, r1
		mad r2.xy, r1.yzzw, -c1.w, r2
		mad r0.xyz, r0, c2.x, r2
		add r0.xyz, r0, c2.y
		nrm r1.xyz, r0
		
		texld r0, v0, s4
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
		mad r0.x, r0.x, c66.z, -c66.w
		mul r0.x, r0.x, v1.w
		rcp r0.x, r0.x
		mad r0.yzw, v1.xxyz, -r0.x, c3.w
		nrm r3.xyz, r0.yzww

		//dot(viewDir, normal)
		dp3 r4.y, r3.xyz, r1.xyz
		//saturate(viewDir.z)
		mov_sat r4.x, r3.z
		//                 (3, 2, 1)
		add r0.xyz, r4.yxy, c21.xyz
		
		add r1.y, r0.y, r4.x
		rcp r1.y, r1.y
		//                        0.5
		mad r1.yz, r3.yxyx, r1.y, c3.xx
		//                    1
		add r1.yz, -r1.yzyz, c3.y
		
		mov r1.xy, r1.zy
		//0
		mov r1.z, c0.x
		//4
		mov r1.w, c2.w
		texldl r4.xyz, r1, s6
		
		//viewDir.z * -0.5 + 0.5
		mad_sat r1.y, r3.z, c4.z, c4.w
		
		mul r6.xyz, c18.xyz, c18.w
		//dot(normal, -dirLight) * dirLightColor
		dp3_sat r0.w, r1.xyz, -c17.xyz
		mul r5.xyz, r6, r0.w
		
		//saturate(viewDir.z * 2)
		add_sat r0.w, r3.z, r3.z
		
		//remappedViewDir.z * ambient1 + ambient0
		mov r8.yzw, c38.xxyz
		mad r1.yzw, r1.y, r8.yyzw, c37.xxyz
		
		//paraboloid - ambient
		add r4.xyz, -r1.yzw, r4.xyz
		
		//        0.25
		mul r2.w, c1.w, r0.x
		
		//parabAmbient * saturate(viewDir.z * 2) + ambient
		mad r4.xyz, r4.xyz, r0.w, r1.yzw
		
		max r1.yzw, r4.xxyz, r1.yyzw
		//        0.25
		mul r0.w, c1.w, r0.z
		
		mul r0.xyz, r2.w, r1.yzw
		//diffuseLight + r0
		add r0.xyz, r5.xyz, r0.xyz
		
		//diffuse * r0
		texld r2.xyz, v0, s0
		mul r0.xyz, r0.xyz, r2.xyz
		
		mul r0.w, r0.w, r0.w
		
		mad oC0.xyz, r0.w, r1.yzw, r0.xyz
		mov oC0.w, c2.w
	endif
// approximately 86 instruction slots used (7 texture, 79 arithmetic)