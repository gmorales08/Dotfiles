set confirm off
set print pretty on
set disassembly-flavor att
tui enable
tui layout src

define asm
    tui layout asm
    tui layout regs
end

define stack
    x/64xb $rsp
end

define stack32
    x/64xb $esp
end
