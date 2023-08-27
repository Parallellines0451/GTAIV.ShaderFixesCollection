// Disabled PC parameters that cause the dirt level in vehicle.ide to affect reflection intensity
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
//   float4 gDirectionalLight;
//   float4 globalScalars;
//   float3 matDiffuseColor;
//   float4 matDiffuseColor2;
//   float reflectivePowerED;
//   float3 specMapIntMask;
//   float specular2ColorIntensityED;
//   float specular2ColorIntensityRE;
//   float specular2Factor;
//   float specular2FactorED;
//   float specularColorFactor;
//   float specularColorFactorED;
//   float specularFactor;
//   float specularFactorED;
//   float4 stencil;
//
//
// Registers:
//
//   Name                      Reg   Size
//   ------------------------- ----- ----
//   gDirectionalLight         c17      1
//   globalScalars             c39      1
//   stencil                   c52      1
//   matDiffuseColor           c66      1
//   matDiffuseColor2          c72      1
//   dirtLevel                 c73      1
//   dirtColor                 c74      1
//   specularFactor            c75      1
//   specularFactorED          c76      1
//   specularColorFactor       c77      1
//   specularColorFactorED     c78      1
//   specMapIntMask            c79      1
//   specular2Factor           c80      1
//   specular2FactorED         c81      1
//   specular2ColorIntensityRE c82      1
//   specular2ColorIntensityED c83      1
//   reflectivePowerED         c84      1
//   LuminanceConstants        c85      1
//   TextureSampler            s0       1
//   DirtSampler               s1       1
//   SpecSampler               s2       1
//

    ps_3_0
    def c0, 9.99999975e-006, 0, 1, 9.99999975e-005
    def c1, -13.2877121, 0.5, 0.001953125, 0
    dcl_texcoord v0.xy
    dcl_texcoord1 v1.xyz
    dcl_texcoord3 v2.xyz
    dcl_color v3
    dcl_texcoord9 v9
    dcl_2d s0
    dcl_2d s1
    dcl_2d s2
    texld r0, v0, s0
    add r1.xyz, c0.x, v1
    dp3 r1.w, r1, r1
    rsq r1.w, r1.w
    mul r2.xyz, r1, r1.w
    texld r3, v0, s2
    mul r2.w, r3.w, c75.x
    mul r2.w, r2.w, c0.z
    dp3 r3.x, r3, c79
    mul r3.x, r3.x, c77.x
    mul r3.x, r3.x, c0.z
    mul r0.xyz, r0, c66
    mul r0, r0, v3
    dp3 r3.y, v3, c85
    mul oC2.z, r3.y, c39.z
    mov r3.yz, c0
    if_lt -c73.x, r3.y
      texld r4, v0, s1
      mul r3.w, r4.x, c73.x
      mad r5.x, r4.x, -c73.x, r3.z
      lrp r5.yzw, r3.w, c74.xxyz, r0.xxyz
      mad r6, r0.xxyz, c0.yzzz, c0.zyyy
      cmp r4, -r4.x, r6, r5
      mov r0.xyz, r4.yzww
    else
      mov r4.x, c0.z
    endif
    mul r3.w, r3.x, r4.x
    mov r4.x, c0.z
    mul r4.x, r4.x, c0.z
    mov r5.x, c80.x
    mul r4.y, r5.x, c0.z
    mov r5.x, c75.x
    mul r4.z, r5.x, c0.z
    rcp r4.z, r4.z
    mul r4.z, r2.w, r4.z
    mov r5.x, c77.x
    mul r4.w, r5.x, c0.z
    rcp r4.w, r4.w
    mul r3.x, r3.x, r4.w
    mul r4.yz, r4.xzxw, r4.xyxw
    mul r3.x, r3.x, r4.z
    add r5.xyz, c0.x, v2
    nrm r6.xyz, r5
    dp3 r4.z, -r6, r2
    add r4.z, r4.z, r4.z
    mad r2.xyz, r2, -r4.z, -r6
    dp3 r2.x, -c17, r2
    add r2.y, r2.x, c0.w
    log r2.y, r2.y
    cmp r2.x, r2.x, r2.y, c1.x
    mul r2.x, r4.y, r2.x
    exp r2.x, r2.x
    mad r2.xyz, r3.x, r2.x, r0
    cmp oC0.xyz, -r4.x, r0, r2
    mul r0.x, r3.w, c72.w
    mul r0.y, r2.w, c72.w
    mad r1.xyz, r1, r1.w, c0.z
    mul oC1.xyz, r1, c1.y
    mul oC2.x, r0.x, c1.y
    mul r0.x, r0.y, c1.z
    rsq r0.x, r0.x
    rcp oC2.y, r0.x
    mul r0.x, r0.w, c39.x
    mov oC0.w, r0.x
    mov oC1.w, r0.x
    mov oC2.w, r0.x
    mul oC3, r3.zyyy, c52.x
	// ----------------------------------------------------------------- Linear2Log -----------------------------------------------------------------
	rcp r20.z, c128.x
	mul r20.x, v9.w, r20.z
	mul r20.y, c128.y, r20.z
	log r20.x, r20.x
	log r20.y, r20.y
	rcp r20.y, r20.y
	mul oDepth, r20.x, r20.y
	// ----------------------------------------------------------------------------------------------------------------------------------------------

// approximately 72 instruction slots used (3 texture, 69 arithmetic)
