syntax match LLDBMeValue /0x\x\+/
syntax match LLDBMeAddress /^0x\x\+:/

highlight default link LLDBMeValue Number
highlight default link LLDBMeAddress Constant
