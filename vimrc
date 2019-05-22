syntax enable
set tabstop=4
set shiftwidth=0
set expandtab                   " Dont use actual tab, instead expand into spaces
set number
filetype indent on
set autoindent
set smartindent
set cindent
set wildmenu
set showmatch
set hlsearch
set pastetoggle=<F3>            " Use F3 function key to enter in paste mode - useful not to have each line indented incrementally while pasting
set nowrap
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWritePre * :%s/\s\+$//e
