" NERDTree
map <C-n> :NERDTreeToggle<CR> " Ctrl + n
" open a NERDTree automatically when vim starts up if no file were speicified
" autocmd StdinReadPre * let s:std_in=1
" autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
" close vim if the onl window left option is a NERDTree
" autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
let NERDTreeShowHidden	= 1
let NERDTreeIgnore			= ['.git$[[dir]]', '.swp', 'node_modules', '\.png$', '\.jpg$', 'deps', '.elixir_ls', '_build']
let NERDTreeDirArrowExpandable = "+"
let NERDTreeDirArrowCollapsible = "-"
let g:NERDTreeNodeDelimiter = "\u00a0"
