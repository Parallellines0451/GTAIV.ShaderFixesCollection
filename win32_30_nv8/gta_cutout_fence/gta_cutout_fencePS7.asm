// Summary: simplified transparency code
// Generated by Microsoft (R) HLSL Shader Compiler 9.26.952.2844
//
// Parameters:
//
//   sampler2D StippleTexture;
//   sampler2D TextureSampler;
//   float4 gDirectionalColour;
//   float4 gDirectionalLight;
//   float4 gLightAmbient0;
//   float4 gLightAmbient1;
//   float4 globalFogColor;
//   float4 globalFogParams;
//   float4 globalScalars;
//
//
// Registers:
//
//   Name               Reg   Size
//   ------------------ ----- ----
//   gDirectionalLight  c17      1
//   gDirectionalColour c18      1
//   gLightAmbient0     c37      1
//   gLightAmbient1     c38      1
//   globalScalars      c39      1
//   globalFogParams    c41      1
//   globalFogColor     c42      1
//   TextureSampler     s0       1
//   StippleTexture     s10      1
//

    ps_3_0
    def c219, 1.8395173895e+25, 3.9938258725e+24, 4.5435787456e+30, 1.1911036947e-43 // 85
    def c152, 0.2, 0.4, 0.6, 0.8 // c152-c154 = new stipple constants
    def c153, 0.5, 2, 1, 0
    def c154, 1.6, 0, 0, 0
    def c0, -512, 9.99999975e-006, -0.5, 0.5
    def c1, -0.25, 1.33333337, 1, 3.99600005
    def c2, 4, 0.125, 0, 1
    def c3, 64, 0, 0, 0
    dcl_texcoord v0.xy
    dcl_texcoord1 v1
    dcl_texcoord3 v2.z
    dcl_color v3.xw
    dcl vPos.xy
    dcl_2d s0
    dcl_2d s10
    add r0, c0.x, v2.z
    texkill r0
    texld r0, v0, s0
    mul_sat r0.w, r0.w, c154.x
    add r1.xyz, c0.y, v1
    nrm r2.xyz, r1
    mul r0.w, r0.w, v3.w
    mad_sat r1.x, r2.z, c0.z, c0.w
    mov r3.xyz, c38
    mad r1.xyz, r3, r1.x, c37
    mul r3.xyz, c18.w, c18
    dp3 r1.w, r2, -c17
    add r1.w, r1.w, c1.x
    mul_sat r1.w, r1.w, c1.y
    mul r2.xyz, r3, r1.w
    mad r1.xyz, r1, v3.x, r2
    mov r1.w, c1.z
    mul r2, r0, r1
    mul r0.w, r2.w, c39.x
    /* removed stipple
    mov_sat r1.w, r0.w
    mul r1.w, r1.w, c1.w
    frc r2.w, r1.w
    mul r3.x, r2.w, c2.x
    frc r3.y, r3.x
    add r3.x, r3.x, -r3.y
    add r3.y, r1.w, -r2.w
    mul r3.zw, c2.y, vPos.xyxy
    frc r3.zw, r3_abs
    cmp r3.zw, vPos.xyxy, r3, -r3
    mul r3.zw, r3, -c1.x
    mad r3.xy, r3, -c1.x, r3.zwzw
    mov r3.zw, c2.z
    texldl r3, r3, s10
    cmp r3, -r3.y, -c2.w, -c2.z
    texkill r3
    removed stipple */
    mul r20.xy, vPos.xy, c153.x
    frc r20.xy, r20.xy
    mad r20, r20.xxyy, -c153.y, c153.zwzw
    mul r20, r20.xxyy, r20.zwzw
    dp4 r20.x, r20_abs, c152.xzwy
    add r20.y, -r20.x, r0.w
    texkill r20.y
    add r1.w, -c41.x, v1.w
    add r2.w, -c41.x, c41.y
    rcp r2.w, r2.w
    mul_sat r1.w, r1.w, r2.w
    mad r0.xyz, r0, -r1, c42
    mad r0.xyz, r1.w, r0, r2
    add r1.x, c3.x, -v1.w
    mul_sat r1.x, r1.x, -c1.x
    mul oC0.w, r0.w, r1.x
    mov oC0.xyz, r0

// approximately 47 instruction slots used (3 texture, 44 arithmetic)
