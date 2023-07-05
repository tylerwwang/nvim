syntax match LLDBVarNumber /-\?\d\+/
syntax match LLDBVarNumber /-\?0x\x\+/
syntax match LLDBVarNumber /-\?0b[01]\+/
syntax match LLDBVarNumber /-\?\d\+\.\d\+/

syntax match LLDBVarString /".*"/
syntax match LLDBVarString /\'.*\'/

syntax match LLDBVarBool /\<true\|false\>/

syn keyword	LLDBVarType		_Bool bool _Complex complex _Imaginary imaginary
syn keyword	LLDBVarType		int8_t int16_t int32_t int64_t
syn keyword	LLDBVarType		uint8_t uint16_t uint32_t uint64_t
syn keyword	LLDBVarType		u_int8_t u_int16_t u_int32_t u_int64_t
syn keyword	LLDBVarType		int_least8_t int_least16_t int_least32_t int_least64_t
syn keyword	LLDBVarType		uint_least8_t uint_least16_t uint_least32_t uint_least64_t
syn keyword	LLDBVarType		int_fast8_t int_fast16_t int_fast32_t int_fast64_t
syn keyword	LLDBVarType		uint_fast8_t uint_fast16_t uint_fast32_t uint_fast64_t
syn keyword	LLDBVarType		intptr_t uintptr_t

syn keyword	LLDBVarType		int long short char void
syn keyword	LLDBVarType		signed unsigned float double

highlight default link LLDBVarNumber Number
highlight default link LLDBVarString String
highlight default link LLDBBool Constant
highlight default link LLDBVarType Type
