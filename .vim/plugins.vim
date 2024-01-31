" PLUGINS

" Gestor de plugins -> vim-plug
" Instalar desde https://github.com/junegunn/vim-plug
" Los plugins se pueden buscar en https://vimawesome.com/

" :PlugInstall para instalar un plugin
" :PlugUpdate  para actualizar un plugin
" :PlugClean   para desinstalar los plugins no utilizados

call plug#begin()

" TEMAS DEL EDITOR
Plug 'morhetz/gruvbox'

" PLUGINS PARA DIRECTORIOS Y ARCHIVOS
" Nerdtree. Explorador de archivos por terminal
Plug 'preservim/nerdtree'
" FuzzyFinder. Busqueda de archivos inteligente
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" PLUGINS PARA LAS VENTANAS
" Tmux navigator. Permite navegar entre ventanas con la tecla ctrl + h/j/k/l
Plug 'christoomey/vim-tmux-navigator'

" PLUGINS PARA PROGRAMACION
" YouCompleteMe. Para autocompletado.
Plug 'valloric/youcompleteme'
" AutoPairs. Para cierre automatico de llaves, parentesis, etc.
Plug 'jiangmiao/auto-pairs'
" Editorconfig. Para que reconozca .editorconfig
Plug 'editorconfig/editorconfig-vim'
" Ultisnips. Macros y snippets para varios lenguajes.
Plug 'sirver/ultisnips'
" Vin snippets. Necesario para ultisnips. Contiene snippets predefinidos.
Plug 'honza/vim-snippets'
" Nerd commenter. Para comentar codigo con atajos.
Plug 'scrooloose/nerdcommenter'

call plug#end()
