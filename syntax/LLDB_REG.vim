syntax match LLDBRegNumber /\d\+/

syntax keyword AArch64Register  w0  w1  w2  w3  w4  w5  w6  w7  w8  w9 w10
syntax keyword AArch64Register w10 w11 w12 w13 w14 w15 w16 w17 w18 w19 w20
syntax keyword AArch64Register w20 w21 w22 w23 w24 w25 w26 w27 w28 w29 w30
syntax keyword AArch64Register w31

syntax keyword AArch64Register  x0  x1  x2  x3  x4  x5  x6  x7  x8  x9 x10
syntax keyword AArch64Register x10 x11 x12 x13 x14 x15 x16 x17 x18 x19 x20
syntax keyword AArch64Register x20 x21 x22 x23 x24 x25 x26 x27 x28 x29 x30
syntax keyword AArch64Register x31

syntax keyword AArch64Register  v0  v1  v2  v3  v4  v5  v6  v7  v8  v9 v10
syntax keyword AArch64Register v10 v11 v12 v13 v14 v15 v16 v17 v18 v19 v20
syntax keyword AArch64Register v20 v21 v22 v23 v24 v25 v26 v27 v28 v29 v30
syntax keyword AArch64Register v31

syntax keyword AArch64Register  q0  q1  q2  q3  q4  q5  q6  q7  q8  q9 q10
syntax keyword AArch64Register q10 q11 q12 q13 q14 q15 q16 q17 q18 q19 q20
syntax keyword AArch64Register q20 q21 q22 q23 q24 q25 q26 q27 q28 q29 q30
syntax keyword AArch64Register q31

syntax keyword AArch64Register  d0  d1  d2  d3  d4  d5  d6  d7  d8  d9 d10
syntax keyword AArch64Register d10 d11 d12 d13 d14 d15 d16 d17 d18 d19 d20
syntax keyword AArch64Register d20 d21 d22 d23 d24 d25 d26 d27 d28 d29 d30
syntax keyword AArch64Register d31

syntax keyword AArch64Register  s0  s1  s2  s3  s4  s5  s6  s7  s8  s9 s10
syntax keyword AArch64Register s10 s11 s12 s13 s14 s15 s16 s17 s18 s19 s20
syntax keyword AArch64Register s20 s21 s22 s23 s24 s25 s26 s27 s28 s29 s30
syntax keyword AArch64Register s31

syntax keyword AArch64Register wzr xzr
syntax keyword AArch64Register fp lr cpsr

syntax keyword AArch64Register sp pc pstate

syntax match LLDBRegAddress /\<0x\x\+\>/
syntax match LLDBRegOperator /\<[=+-]\</
syntax match LLDBRegOperator /\<=\</

syntax match LLDBRegDir /\h\+\.\h\+/
syntax match LLDBRegDir /\"\?\(\/\h\+\)\+\/\h\+\.\?\h\+\"\?/

syntax match LLDBRegLabel /\(\h\+`\)\+\h\+\.\?\h\+\"\?/
"TODO add more character support for directories

highlight default link LLDBRegNumber Number
highlight default link AArch64Register StorageClass
highlight default link LLDBRegAddress Constant
highlight default link LLDBRegOperator Operator
highlight default link LLDBRegDir Directory
highlight default link LLDBRegLabel Label

