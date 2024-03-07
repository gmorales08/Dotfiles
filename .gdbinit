set confirm off
set print pretty on
set disassembly-flavor intel
tui enable
tui layout src

define asm
    tui layout asm
    tui layout regs
end

define stack
    x/64xb $rsp
end
