// Summary: Ported XBOX auto exposure
// Generated by Microsoft (R) HLSL Shader Compiler 9.26.952.2844
//
// Parameters:
//
//   sampler2D HDRSampler;
//   float4 TexelSize;
//
//
// Registers:
//
//   Name         Reg   Size
//   ------------ ----- ----
//   TexelSize    c66      1
//   HDRSampler   s0       1
//

    ps_3_0
    def c219, 1.8395173895e+25, 3.9938258725e+24, 4.5435787456e+30, 1.1294465622e-42 // 806
    dcl_texcoord v0.xy
    dcl_2d s0
	texld r0, v0, s0
    mov oC0, r0.x

// approximately 13 instruction slots used (4 texture, 9 arithmetic)
