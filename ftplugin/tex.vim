filetype plugin indent on
let g:vimtex_view_method = 'zathura'
let g:Tex_BibtexFlavor = 'biblatex'

let g:vimtex_quickfix_ignore_filters = [
            \ 'Underfull',
            \ 'Overfull',
            \ 'XeLaTeX',
            \ 'lipsum',
            \]

let maplocalleader = ' '
set cc =

Copilot disable

inoremap <C-i> \textit
