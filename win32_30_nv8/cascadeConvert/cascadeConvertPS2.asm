// Removed improper blur before the shadowmap is sampled by lighting
// Generated by Microsoft (R) HLSL Shader Compiler 9.26.952.2844
//
// Parameters:
//
//   sampler2D ConvertSampler;
//   float4 gShadowParam18192021;
//
//
// Registers:
//
//   Name                 Reg   Size
//   -------------------- ----- ----
//   gShadowParam18192021 c53      1
//   ConvertSampler       s0       1
//

    ps_3_0
    def c219, 1.8395173895e+25, 3.9938258725e+24, 4.5435787456e+30, 1.4012984643e-45 // 1
    def c0, 0.5, 1, 0.25, 0
    dcl_texcoord v0.xy
    dcl_2d s0
    texld r0, v0, s0
    mov oC0.x, r0.x
    mov oC0.yzw, c0.w

// approximately 18 instruction slots used (4 texture, 14 arithmetic)
