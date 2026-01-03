# Permitir .gdbinit local
set auto-load local-gdbinit on
set auto-load safe-path /
set confirm off
set print pretty on
set history save on
# Imprimir los array en horizontal en vez de vertical
set print array off
# Imprimir los indices en los array
set print array-indexes on
set disassembly-flavor intel
# Permitir uso de debuginfod para debug symbols
set debuginfod enabled on
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
