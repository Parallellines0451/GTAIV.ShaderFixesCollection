// Summary: added slope scale bias
// Generated by Microsoft (R) HLSL Shader Compiler 9.26.952.2844
    ps_3_0
    def c219, 1.8395173895e+25, 3.9938258725e+24, 4.5435787456e+30, 1.0411647590e-42 // 743
    def c0, 1, 0, 0, 0 // w = slope scale bias factor
    dcl_texcoord v0.x
    // mad oC0, v0.x, c0.xxxy, c0.yyyx
    dsx r1.x, v0.x
    dsy r1.y, v0.x
    add r1.x, r1_abs.x, r1_abs.y
    mad r1.x, r1.x, -c0.w, v0.x
    mad oC0, r1.x, c0.xxxy, c0.yyyx

// approximately 1 instruction slot used
