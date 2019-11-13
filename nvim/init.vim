" _____ _                    _
"|_   _| |__   ___ _ __ ___ (_)___
"  | | | '_ \ / _ \ '_ ` _ \| / __|
"  | | | | | |  __/ | | | | | \__ \
"  |_| |_| |_|\___|_| |_| |_|_|___/
" Author: @oatiz

" ===
" === Auto load for first time uses
" ===
"
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

"====================
" === Editor Setup ===
" ====================

" ===
" === System
" ===
let &t_ut=''
set autochdir

" if has("termguicolors")
"     " enable true color
"     set termguicolors
" endif

set guifont=Fira\ Code:h13
if has('nvim')
    set guicursor=n-v-c:block-Cursor/lCursor-blinkon0,i-ci:ver25-Cursor/lCursor,r-cr:hor20-Cursor/lCursor
    set inccommand=nosplit
"    noremap <C-q> :confirm qall<CR>
end

filetype off  " required!
filetype plugin indent on     " required!

" ===
" === Editor behavior
" ===
set number
set relativenumber
set cursorline
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4
set autoindent
set list
" set listchars=tab:▸\ ,trail:▫
set listchars=tab:\|\ ,trail:▫
set scrolloff=4
set ttimeoutlen=0
set notimeout
set viewoptions=cursor,folds,slash,unix
set wrap
set tw=0
set indentexpr=
set foldmethod=indent
set foldlevel=99
set foldenable
" Wrapping options
set formatoptions-=tc " wrap text and comments using textwidth
" set formatoptions+=r " continue comments when pressing ENTER in I mode
" set formatoptions+=q " enable formatting of comments with gq
" set formatoptions+=n " detect lists for formatting
" set formatoptions+=b " auto-wrap in insert mode, and do not wrap old long lines
set splitright
set splitbelow
set noshowmode
set showcmd
set wildmenu
exec "nohlsearch"
set ignorecase
set smartcase
set shortmess+=c
" set inccommand=split
set ttyfast "should make scrolling faster
set lazyredraw "same as above
set visualbell
" set undo history
silent !mkdir -p ~/.config/nvim/tmp/backup
silent !mkdir -p ~/.config/nvim/tmp/undo
set backupdir=~/.config/nvim/tmp/backup,.
set directory=~/.config/nvim/tmp/backup,.
if has('persistent_undo')
  set undofile
  set undodir=~/.config/nvim/tmp/undo,.
endif

set colorcolumn=120
set updatetime=1000

" from http://sheerun.net/2014/03/21/how-to-boost-your-vim-productivity/
if executable('ag')
	set grepprg=ag\ --nogroup\ --nocolor
endif
if executable('rg')
	set grepprg=rg\ --no-heading\ --vimgrep
	set grepformat=%f:%l:%c:%m
endif

" Always draw sign column. Prevent buffer moving when adding/deleting sign.
set signcolumn=yes

" use in alacritty
" let &t_SI = "\<Esc>]50;CursorShape=1\x7"
" let &t_SR = "\<Esc>]50;CursorShape=2\x7"
" let &t_EI = "\<Esc>]50;CursorShape=0\x7"

" exec vim open lastest window
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" ===
" === Terminal Behavior
" ===
let g:neoterm_autoscroll = 1
autocmd TermOpen term://* startinsert
"tnoremap <C-N> <C-\><C-N>:q<CR>

" ===
" === Basic Mappings
" ===
" Set <LEADER> as <SPACE>,  ; as :
let mapleader=" "
map ; :

" Save & quit
map Q :q<CR>
map S :w<CR>

" Jump to start and end of line using the home row keys
map H ^
map L $

" Open the vimrc file anytime
map <LEADER>rc :e ~/.config/nvim/init.vim<CR>

" Open Startify
map <LEADER>tt :Startify<CR>

" change until
map <silent> C ct

" Copy to system clipboard
" vnoremap Y :w !xclip -i -sel c<CR>
" vnoremap Y :w !xsel -ib<CR><CR>
vnoremap Y "+y

" Open new file adjacent to current file
nnoremap <leader>e :e <C-R>=expand("%:p:h") . "/" <CR>

" Indentation
nnoremap < <<
nnoremap > >>

" Search
map <LEADER><CR> :nohlsearch<CR>
" noremap = nzz
" noremap - Nzz

" Duplicate words
map <LEADER>dw /\(\<\w\+\>\)\_s*\1

" Folding
map <silent> <LEADER>o za

" === Cursor Movement
" ===
"
" U/E keys for 5 times u/e (faster navigation)
noremap K 5k
noremap J 5j

" Faster in-line navigation
noremap W 5w
noremap B 5b

" Ctrl + D or E will move up/down the view port without moving the cursor
noremap <C-E> 5<C-y>
noremap <C-D> 5<C-e>

" ===
" === Window management
" ===
" Use ALT+SHIFT+h/j/k/l
noremap <m-H> <c-w>h
noremap <m-L> <c-w>l
noremap <m-J> <c-w>j
noremap <m-K> <c-w>k
inoremap <m-H> <esc><c-w>h
inoremap <m-L> <esc><c-w>l
inoremap <m-J> <esc><c-w>j
inoremap <m-K> <esc><c-w>k


" Disabling the default s key
noremap s <nop>

" split the screens to up (horizontal), down (horizontal), left (vertical), right (vertical)
map sj :set nosplitbelow<CR>:split<CR>:set splitbelow<CR>
map sk :set splitbelow<CR>:split<CR>
map sh :set nosplitright<CR>:vsplit<CR>:set splitright<CR>
map sl :set splitright<CR>:vsplit<CR>

" Resize splits with arrow keys
map <up> :res +5<CR>
map <down> :res -5<CR>
map <left> :vertical resize+5<CR>
map <right> :vertical resize-5<CR>

" Place the two screens up and down
noremap sH <C-w>t<C-w>K
" Place the two screens side by side
noremap sV <C-w>t<C-w>H

" ===
" === Tab management
" ===
" Create a new tab with tu
map tu :tabe<CR>
" Move around tabs with tj and tk
map tj :-tabnext<CR>
map tk :+tabnext<CR>

" Move the tabs with tmn and tmi
map tmj :-tabmove<CR>
map tmk :+tabmove<CR>

" ===
" === Custom Snippets
" ===
source ~/.config/nvim/snippits.vim
" auto spell
" autocmd BufRead,BufNewFile *.md setlocal spell spelllang=en_us


" ===
" === Other useful stuff
" ===

" Opening a terminal window
map <LEADER>/ :set splitright<CR>:vsplit<CR>:term<CR>
if has('terminal') && exists(':terminal') == 2 && has('patch-8.1.1')
	" vim 8.1 支持 termwinkey ，不需要把 terminal 切换成 normal 模式
	" 设置 termwinkey 为 CTRL 加减号（GVIM），有些终端下是 CTRL+?
	" 后面四个键位是搭配 termwinkey 的，如果 termwinkey 更改，也要改
	set termwinkey=<c-_>
	tnoremap <m-H> <c-_>h
	tnoremap <m-L> <c-_>l
	tnoremap <m-J> <c-_>j
	tnoremap <m-K> <c-_>k
	tnoremap <m-q> <c-\><c-n>
elseif has('nvim')
	" neovim 没有 termwinkey 支持，必须把 terminal 切换回 normal 模式
	tnoremap <m-H> <c-\><c-n><c-w>h
	tnoremap <m-L> <c-\><c-n><c-w>l
	tnoremap <m-J> <c-\><c-n><c-w>j
	tnoremap <m-K> <c-\><c-n><c-w>k
	tnoremap <m-q> <c-\><c-n>
endif

" Press space twice to jump to the next '<++>' and edit it
map <LEADER><LEADER> <Esc>/<++><CR>:nohlsearch<CR>c4i

" Spelling Check with <space>sc
" map <LEADER>sc :set spell!<CR>
" noremap <C-x> ea<C-x>s
" inoremap <C-x> <Esc>ea<C-x>s

" Press ` to change case (instead of ~)
map ` ~
nmap <C-c> zz

" Auto change directory to current dir
autocmd BufEnter * silent! lcd %:p:h

" Call figlet
map tx :r !figlet

" Compile function
map r :call CompileRunGcc()<CR>
func! CompileRunGcc()
        exec "w"
	if &filetype == 'c'
		exec "!g++ % -o %<"
		exec "!time ./%<"
	elseif &filetype == 'cpp'
        set splitright
            :vsp
		    :vertical resize-30
            :term g++ % -o %< && ./%<
		" exec "!g++ % -o %<"
		" exec "!time ./%<"
	elseif &filetype == 'java'
		exec "!javac %"
		exec "!time java %<"
	elseif &filetype == 'sh'
		:!time bash %
	elseif &filetype == 'python'
		set splitright
		":vsp
		":vertical resize-20
                :sp
                :term python3 %
	elseif &filetype == 'html'
		exec "!chromium % &"
	elseif &filetype == 'markdown'
		exec "MarkdownPreview"
    elseif &filetype == 'tex'
		silent! exec "VimtexStop"
		silent! exec "VimtexCompile"
	elseif &filetype == 'go'
		set splitbelow
		:sp
		:term go run %
	endif
endfunc

" <leader>s for Rg search
noremap <leader>s :Rg 
" noremap <leader>S :Rg 

let g:fzf_layout = { 'down': '~20%' }
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)

function! s:list_cmd()
  let base = fnamemodify(expand('%'), ':h:.:S')
  return base == '.' ? 'fd --type file --follow' : printf('fd --type file --follow | proximity-sort %s', shellescape(expand('%')))
endfunction

command! -bang -nargs=? -complete=dir Files
  \ call fzf#vim#files(<q-args>, {'source': s:list_cmd(),
  \                               'options': '--tiebreak=index'}, <bang>0)

" ===
" === Install Plugins with Vim-Plug
" ===
"
call plug#begin('~/.config/nvim/plugged')

Plug 'sheerun/vim-polyglot'
Plug 'junegunn/goyo.vim'

" Pretty Dress
Plug 'theniceboy/eleline.vim'
Plug 'bling/vim-bufferline'
Plug 'chriskempson/base16-vim'

" Genreal Highlighter
Plug 'jaxbot/semantic-highlight.vim'
Plug 'chrisbra/Colorizer' " Show colors with :ColorHighlight

" File navigation
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'

" Taglist
Plug 'liuchengxu/vista.vim'

" Error checking
" Plug 'dense-analysis/ale'

" Rust
Plug 'rust-lang/rust.vim'
Plug 'racer-rust/vim-racer'

" Auto Complete
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Language Server
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }

" Snippets
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

" Undo Tree
Plug 'mbbill/undotree/'

" Other visual enhancement
Plug 'mhinz/vim-startify'

" Git
Plug 'mhinz/vim-signify'
Plug 'gisphm/vim-gitignore', { 'for': ['gitignore', 'vim-plug'] }
Plug 'fszymanski/fzf-gitignore', { 'do': ':UpdateRemotePlugins' }
Plug 'tpope/vim-fugitive' " gv dependency
Plug 'junegunn/gv.vim' " gv (normal) to show git log

" HTML, CSS, JavaScript, PHP, JSON, etc.
Plug 'elzr/vim-json'
Plug 'hail2u/vim-css3-syntax'
Plug 'spf13/PIV', { 'for' :['php', 'vim-plug'] }
Plug 'gko/vim-coloresque', { 'for': ['vim-plug', 'php', 'html', 'javascript', 'css', 'less'] }
Plug 'pangloss/vim-javascript', { 'for' :['javascript', 'vim-plug'] }
Plug 'jelera/vim-javascript-syntax'

" Python
Plug 'Vimjas/vim-python-pep8-indent', { 'for' :['python', 'vim-plug'] }
Plug 'numirias/semshi', { 'do': ':UpdateRemotePlugins' }
Plug 'tweekmonster/braceless.vim'

" Markdown
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install' }
Plug 'dhruvasagar/vim-table-mode', { 'on': 'TableModeToggle' }
Plug 'dkarter/bullets.vim', { 'for' :['markdown', 'vim-plug'] }

" Editor Enhancement
Plug 'jiangmiao/auto-pairs'
Plug 'terryma/vim-multiple-cursors'
Plug 'scrooloose/nerdcommenter' " in <space>cc to comment a line
Plug 'tpope/vim-surround' " type ysks' to wrap the word with '' or type cs'` to change 'word' to `word`
Plug 'gcmt/wildfire.vim' " in Visual mode, type i' to select all text in '', or type i) i] i} ip
Plug 'godlygeek/tabular' " type ;Tabularize /= to align the =
Plug 'tpope/vim-capslock'	" Ctrl+L (insert) to toggle capslock
Plug 'easymotion/vim-easymotion'

" Other visual enhancement
Plug 'ryanoasis/vim-devicons'

" Formatter
Plug 'Chiel92/vim-autoformat'

" For general writing
" Plug 'reedes/vim-wordy'
" Plug 'ron89/thesaurus_query.vim'

" Bookmarks
Plug 'kshenoy/vim-signature'

" Find & Replace
Plug 'wsdjeg/FlyGrep.vim' " Ctrl+f (normal) to find file content
Plug 'brooth/far.vim', { 'on': ['F', 'Far', 'Fardo'] }
Plug 'osyo-manga/vim-anzu'

" Other useful utilities
Plug 'airblade/vim-rooter'
Plug 'tpope/vim-eunuch' " do stuff like :SudoWrite
Plug 'itchyny/calendar.vim'

" Dependencies
Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'kana/vim-textobj-user'
Plug 'roxma/nvim-yarp'

call plug#end()

" ===
" === Create a _machine_specific.vim file to adjust machine specific stuff, like python interpreter location
" ===
let has_machine_specific_file = 1
if empty(glob('~/.config/nvim/_machine_specific.vim'))
  let has_machine_specific_file = 0
  silent! exec "!cp ~/.config/nvim/default_configs/_machine_specific_default.vim ~/.config/nvim/_machine_specific.vim"
endif
source ~/.config/nvim/_machine_specific.vim

" ===
" === Dress up my vim
" ===
set termguicolors     " enable true colors support
let $NVIM_TUI_ENABLE_TRUE_COLOR=1

if filereadable(expand("~/.vimrc_background"))
    set background=dark
    let base16colorspace=256
    hi Normal ctermbg=NONE
    source ~/.vimrc_background
endif


" ===================== Start of Plugin Settings =====================

let g:airline_powerline_fonts = 0


" ===
" === Rust configure
" ===
let g:rustfmt_autosave = 1


" ===
" === Java configure (eclim )
" ===
" nailgun
let g:EclimNailgunKeepAlive = 0
" automatic validation of java source files
let g:EclimFileTypeValidate = 0
" Determines what action to take when a only a single result is found, 'edit' -> open the result in the current window.
let g:EclimJavaSearchSingleResult = 'edit'
" use vim’s omni code completion. Ctrl-X Ctrl-O
let g:EclimCompletionMethod = 'omnifunc'
" Element searching allows you to place the cursor over just about any element in a source file 
"   method call, class name, field) and perform a search for that element
nmap <silent> <LEADER>jd :JavaSearchContext<CR>
" viewing a java class or interface you can view the type hierarchy
nmap <silent> <LEADER>jh :JavaHierarchy<CR>
" Refactor Undo/Redo
nmap <silent> <LEADER>ju :RefactorUndo<CR>
nmap <silent> <LEADER>jr :RefactorUndo<CR>


" ===
" === NERDTree
" ===
map tt :NERDTreeToggle<CR>
let NERDTreeMapOpenExpl = ""
let NERDTreeMapUpdir = "N"
let NERDTreeMapUpdirKeepOpen = "n"
let NERDTreeMapOpenSplit = ""
let NERDTreeMapOpenVSplit = "I"
let NERDTreeMapActivateNode = "i"
let NERDTreeMapOpenInTab = "o"
let NERDTreeMapOpenInTabSilent = "O"
let NERDTreeMapPreview = ""
let NERDTreeMapCloseDir = ""
let NERDTreeMapChangeRoot = ""
let NERDTreeMapMenu = ","
let NERDTreeMapToggleHidden = "zh"

" ==
" == NERDTree-git
" ==
let g:NERDTreeIndicatorMapCustom = {
            \ "Modified"	    : "✹",
            \ "Staged"		    : "✚",
            \ "Untracked"       : "✭",
            \ "Renamed"	        : "➜",
            \ "Unmerged"	    : "═",
            \ "Deleted"	        : "✖",
            \ "Dirty"		    : "✗",
            \ "Clean"		    : "✔︎",
            \ "Unknown"	        : "?"
			\ }


" ===
" === coc
" ===
" fix the most annoying bug that coc has
silent! au BufEnter,BufRead,BufNewFile * silent! unmap if
" Installing plugins
let g:coc_global_extensions = ['coc-python', 'coc-java', 'coc-vimlsp', 'coc-snippets', 'coc-emmet', 'coc-html', 'coc-json', 'coc-css', 'coc-tsserver', 'coc-yank', 'coc-lists', 'coc-gitignore']
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}
" use <tab> for trigger completion and navigate to the next complete item
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction
inoremap <silent><expr> <Tab>
			\ pumvisible() ? "\<C-n>" :
			\ <SID>check_back_space() ? "\<Tab>" :
			\ coc#refresh()
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <silent><expr> <c-space> coc#refresh()
" Useful commands
nnoremap <silent> <space>y  :<C-u>CocList -A --normal yank<cr>
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <leader>rn <Plug>(coc-rename)
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)
nnoremap <silent> gk :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction


" ===
" === MarkdownPreview
" ===
let g:mkdp_auto_start = 0
let g:mkdp_auto_close = 1
let g:mkdp_refresh_slow = 0
let g:mkdp_command_for_global = 0
let g:mkdp_open_to_the_world = 0
let g:mkdp_open_ip = ''
let g:mkdp_echo_preview_url = 1
let g:mkdp_browser = 'chromium'
let g:mkdp_browserfunc = ''
let g:mkdp_preview_options = {
			\ 'mkit': {},
			\ 'katex': {},
			\ 'uml': {},
			\ 'maid': {},
			\ 'disable_sync_scroll': 0,
			\ 'sync_scroll_type': 'middle',
			\ 'hide_yaml_meta': 1
			\ }
let g:mkdp_markdown_css = ''
let g:mkdp_highlight_css = ''
let g:mkdp_port = ''
let g:mkdp_page_title = '「${name}」'


" ===
" === Python-syntax
" ===
let g:python_highlight_all = 1


" ===
" === vim-table-mode
" ===
map <LEADER>tm :TableModeToggle<CR>


" ===
" === FZF
" ===
map <LEADER>p :FZF<CR>


" ===
" === vim-signiture
" ===
let g:SignatureMap = {
        \ 'Leader'             :  "m",
        \ 'PlaceNextMark'      :  "m,",
        \ 'ToggleMarkAtLine'   :  "m.",
        \ 'PurgeMarksAtLine'   :  "dm-",
        \ 'DeleteMark'         :  "dm",
        \ 'PurgeMarks'         :  "dm/",
        \ 'PurgeMarkers'       :  "dm?",
        \ 'GotoNextLineAlpha'  :  "m<LEADER>",
        \ 'GotoPrevLineAlpha'  :  "",
        \ 'GotoNextSpotAlpha'  :  "m<LEADER>",
        \ 'GotoPrevSpotAlpha'  :  "",
        \ 'GotoNextLineByPos'  :  "",
        \ 'GotoPrevLineByPos'  :  "",
        \ 'GotoNextSpotByPos'  :  "mn",
        \ 'GotoPrevSpotByPos'  :  "mp",
        \ 'GotoNextMarker'     :  "",
        \ 'GotoPrevMarker'     :  "",
        \ 'GotoNextMarkerAny'  :  "",
        \ 'GotoPrevMarkerAny'  :  "",
        \ 'ListLocalMarks'     :  "m/",
        \ 'ListLocalMarkers'   :  "m?"
        \ }


" ===
" === Undotree
" ===
map \l :UndotreeToggle<CR>
let g:undotree_DiffAutoOpen = 1
let g:undotree_SetFocusWhenToggle = 1
let g:undotree_ShortIndicators = 1

" ==
" == vim-multiple-cursor
" ==
let g:multi_cursor_use_default_mapping=0
let g:multi_cursor_start_word_key      = '<c-k>'
let g:multi_cursor_select_all_word_key = '<a-k>'
let g:multi_cursor_start_key           = 'g<c-k>'
let g:multi_cursor_select_all_key      = 'g<a-k>'
let g:multi_cursor_next_key            = '<c-k>'
let g:multi_cursor_prev_key            = '<c-p>'
let g:multi_cursor_skip_key            = '<C-x>'
let g:multi_cursor_quit_key            = '<Esc>'


" Startify
let g:startify_lists = [
      \ { 'type': 'files',     'header': ['   MRU']            },
      \ { 'type': 'bookmarks', 'header': ['   Bookmarks']      },
      \ { 'type': 'commands',  'header': ['   Commands']       },
      \ ]


" Far.vim
nnoremap <silent> <LEADER>f :F  %<left><left>


" ===
" === emmet
" ===
let g:user_emmet_leader_key='<c-}'


" ===
" === Bullets.vim
" ===
let g:bullets_set_mappings = 0


" ===
" === Vista.vim
" ===
noremap <silent> T :Vista!!<CR>
noremap <silent> <C-t> :Vista finder<CR>
function! NearestMethodOrFunction() abort
	return get(b:, 'vista_nearest_method_or_function', '')
endfunction

set statusline+=%{NearestMethodOrFunction()}
autocmd VimEnter * call vista#RunForNearestMethodOrFunction()

let g:vista_icon_indent = ["╰─▸ ", "├─▸ "]
let g:vista_fzf_preview = ['right:50%']



" ===
" === fzf-gitignore
" ===
noremap <LEADER>gi <Plug>(fzf-gitignore)


" ===
" === GV
" ===
nnoremap gv :GV<CR>


" ===
" === vim-calendar
" ===
noremap \c :Calendar -position=here<CR>
noremap \\ :Calendar -view=clock -position=here<CR>
let g:calendar_google_calendar = 1
let g:calendar_google_task = 1
augroup calendar-mappings
	autocmd!
	" diamond cursor
	autocmd FileType calendar nmap <buffer> u <Plug>(calendar_up)
	autocmd FileType calendar nmap <buffer> n <Plug>(calendar_left)
	autocmd FileType calendar nmap <buffer> e <Plug>(calendar_down)
	autocmd FileType calendar nmap <buffer> i <Plug>(calendar_right)
	autocmd FileType calendar nmap <buffer> <c-u> <Plug>(calendar_move_up)
	autocmd FileType calendar nmap <buffer> <c-n> <Plug>(calendar_move_left)
	autocmd FileType calendar nmap <buffer> <c-e> <Plug>(calendar_move_down)
	autocmd FileType calendar nmap <buffer> <c-i> <Plug>(calendar_move_right)
	autocmd FileType calendar nmap <buffer> k <Plug>(calendar_start_insert)
	autocmd FileType calendar nmap <buffer> K <Plug>(calendar_start_insert_head)
	" unmap <C-n>, <C-p> for other plugins
	autocmd FileType calendar nunmap <buffer> <C-n>
	autocmd FileType calendar nunmap <buffer> <C-p>
augroup END

" ===
" === Anzu
" ===
set statusline=%{anzu#search_status()}


" ===
" === vim-go
" ===
let g:go_textobj_enabled = 0
let g:go_auto_type_info = 1
"let g:go_def_mapping_enabled = 1
let g:go_doc_keywordprg_enabled = 0
noremap <LEADER>q <C-w>j:q<CR>
let g:go_highlight_array_whitespace_error    = 1
let g:go_highlight_build_constraints         = 1
let g:go_highlight_extra_types               = 1
let g:go_highlight_fields                    = 1
let g:go_highlight_function_calls            = 1
let g:go_highlight_function_parameters       = 1
let g:go_highlight_functions                 = 1
let g:go_highlight_generate_tags             = 1
let g:go_highlight_methods                   = 1
let g:go_highlight_operators                 = 1
let g:go_highlight_space_tab_error           = 1
let g:go_highlight_structs                   = 1
let g:go_highlight_trailing_whitespace_error = 0
let g:go_highlight_types                     = 1
let g:go_highlight_variable_assignments      = 0
let g:go_highlight_variable_declarations     = 0

" ===
" === AutoFormat
" ===
nnoremap \f :Autoformat<CR>

" ===
" === Colorizer
" ===
let g:colorizer_syntax = 1

" ===================== End of Plugin Settings =====================
"
"

" ===
" === Necessary Commands to Execute
" ===
exec "nohlsearch"

" Open the _machine_specific.vim file if it has just been created
if has_machine_specific_file == 0
    exec "e ~/.config/nvim/_machine_specific.vim"
endif
