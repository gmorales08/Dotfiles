" PLUGINS

" Gestor de plugins -> vim-plug
" Instalar desde https://github.com/junegunn/vim-plug
" Los plugins se pueden buscar en https://vimawesome.com/

" :PlugInstall para instalar un plugin
" :PlugUpdate  para actualizar un plugin
" :PlugClean   para desinstalar los plugins no utilizados

call plug#begin()

" TEMAS DEL EDITOR
"Plug 'morhetz/gruvbox'

" PLUGINS PARA DIRECTORIOS Y ARCHIVOS
" Nerdtree. Explorador de archivos por terminal
Plug 'preservim/nerdtree'
" FuzzyFinder. Busqueda de archivos inteligente
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'


" PLUGINS PARA NAVEGACION
" Tmux navigator. Permite navegar entre ventanas con la tecla ctrl + h/j/k/l
Plug 'christoomey/vim-tmux-navigator'


" PLUGINS PARA PROGRAMACION
" Ale. Linter y formater para muchos lenguajes.
Plug 'dense-analysis/ale'
" Language Server Protocol. Para autocompletado, hover, etc.
" vim-lsp : cliente lsp
Plug 'prabirshrestha/vim-lsp'
" vim-lsp-settings : autoinstalador de lsp servers
Plug 'mattn/vim-lsp-settings'
" vim-lsp-ultisnips y snippets : para poder usar snippets con vim-lsp
Plug 'thomasfaingnaert/vim-lsp-snippets'
Plug 'thomasfaingnaert/vim-lsp-ultisnips'
" Asyncomplete : para autocompletado
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'

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
" Endwise. Autocierre de estructuras del preprocesador
Plug 'tpope/vim-endwise'

" Previm. Para preview de documentos markdown
Plug 'kannokanno/previm'

call plug#end()
