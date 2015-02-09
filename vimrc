" Use Vim settings, rather then Vi settings. This setting must be as early as
" possible, as it has side effects.
set nocompatible
" Leader
let mapleader = " "
set backspace=2   " Backspace deletes like most programs in insert mode
set nobackup
set nowritebackup
set noswapfile    " http://robots.thoughtbot.com/post/18739402579/global-gitignore#comment-458413287
set history=50
set ruler         " show the cursor position all the time
set showcmd       " display incomplete commands
set incsearch     " do incremental searching
set laststatus=2  " Always display the status line
set autowrite     " Automatically :write before running commands
" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if (&t_Co > 2 || has("gui_running")) && !exists("syntax_on")
  syntax on
endif
if filereadable(expand("~/.vimrc.bundles"))
  source ~/.vimrc.bundles
endif
filetype plugin indent on
augroup vimrcEx
  autocmd!
  " When editing a file, always jump to the last known cursor position.
  " Don't do it for commit messages, when the position is invalid, or when
  " inside an event handler (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif
  " Cucumber navigation commands
  autocmd User Rails Rnavcommand step features/step_definitions -glob=**/* -suffix=_steps.rb
  autocmd User Rails Rnavcommand config config -glob=**/* -suffix=.rb -default=routes
  " Set syntax highlighting for specific file types
  autocmd BufRead,BufNewFile Appraisals set filetype=ruby
  autocmd BufRead,BufNewFile *.md set filetype=markdown
  " Enable spellchecking for Markdown
  autocmd FileType markdown setlocal spell
  " Automatically wrap at 80 characters for Markdown
  autocmd BufRead,BufNewFile *.md setlocal textwidth=80
  " Automatically wrap at 72 characters and spell check git commit messages
  autocmd FileType gitcommit setlocal textwidth=72
  autocmd FileType gitcommit setlocal spell
  " Allow stylesheets to autocomplete hyphenated words
  autocmd FileType css,scss,sass setlocal iskeyword+=-
augroup END
" Softtabs, 2 spaces
set tabstop=2
set shiftwidth=2
set shiftround
set expandtab
" Display extra whitespace
set list listchars=tab:»·,trail:·,nbsp:·
" Use The Silver Searcher https://github.com/ggreer/the_silver_searcher
if executable('ag')
  " Use Ag over Grep
  set grepprg=ag\ --nogroup\ --nocolor
  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif
" Color scheme
colorscheme github
highlight NonText guibg=#060606
highlight Folded  guibg=#0A0A0A guifg=#9090D0
" Make it obvious where 80 characters is
set textwidth=80
set colorcolumn=+1
" Numbers
set number
set numberwidth=5
" Tab completion
" will insert tab at beginning of line,
" will use completion if not at beginning
set wildmode=list:longest,list:full
function! InsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<tab>"
    else
        return "\<c-p>"
    endif
endfunction
inoremap <Tab> <c-r>=InsertTabWrapper()<cr>
inoremap <S-Tab> <c-n>
" Exclude Javascript files in :Rtags via rails.vim due to warnings when parsing
let g:Tlist_Ctags_Cmd="ctags --exclude='*.js'"
" Index ctags from any project, including those outside Rails
map <Leader>ct :!ctags -R .<CR>
" Switch between the last two files
nnoremap <leader><leader> <c-^>
" Get off my lawn
nnoremap <Left> :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use l"<CR>
nnoremap <Up> :echoe "Use k"<CR>
nnoremap <Down> :echoe "Use j"<CR>

" vim-rspec mappings
nnoremap <Leader>rt :call RunCurrentSpecFile()<CR>
nnoremap <Leader>rs :call RunNearestSpec()<CR>
nnoremap <Leader>rl :call RunLastSpec()<CR>
nnoremap <Leader>ra :call RunAllSpecs()<CR>

" Run commands that require an interactive shell
" nnoremap <Leader>r :RunInInteractiveShell<space>

" Treat <li> and <p> tags like the block tags they are
let g:html_indent_tags = 'li\|p'
" Open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright
" Quicker window movement
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" configure syntastic syntax checking to check on open as well as save
let g:syntastic_check_on_open=1
let g:syntastic_html_tidy_ignore_errors=[" proprietary attribute \"ng-"]
" Set spellfile to location that is guaranteed to exist, can be symlinked to
" Dropbox or kept in Git and managed outside of thoughtbot/dotfiles using rcm.
set spellfile=$HOME/.vim-spell-en.utf-8.add
" Always use vertical diffs
set diffopt+=vertical

set ttymouse=xterm2
set mouse=a

let mapleader = " "
noremap ; :

imap jk <ESC>

noremap ; :
noremap : ;

set backspace=2

noremap <Leader>n :NERDTreeFind<CR>
noremap <Leader>m :NERDTreeToggle<CR>

set nowrap

" To remember how to force save if you have an E212 error message
ca w!!  w !sudo tee "%"

inoremap <silent> <C-q> <ESC>:q<CR><ESC>
nnoremap <silent> <C-q> :q<CR>
inoremap <silent> <C-q><C-q><C-q> <ESC>:q!<CR><ESC>
nnoremap <silent> <C-q><C-q><C-q> :q!<CR>

noremap  <silent> <C-s> :update<CR><ESC>
vnoremap <silent> <C-s> <C-C>:update<CR><ESC>
inoremap <silent> <C-s> <C-O>:update<CR><ESC>

noremap <silent><leader>a :CtrlP<CR>

function! ToggleBackground()
  let &background = ( &background == "dark"? "light" : "dark" )
endfunction

syntax enable
set background=dark
colorscheme solarized

noremap <f2> :call ToggleBackground()<CR>
nnoremap <F6> :buffers<CR>:buffer<Space>

" map <F4> <Plug>(xmpfilter-mark)
" map <F5> <Plug>(xmpfilter-run)
"
" imap <F4> <Plug>(xmpfilter-mark)
" imap <F5> <Plug>(xmpfilter-run)

" set clipboard=unnamed
noremap <leader>y :.w !pbcopy<CR><CR>
" vnoremap <leader>y :w !pbcopy<CR><CR>
vnoremap <silent><leader>y y:call system("pbcopy", getreg("\""))<CR>
noremap <leader>p :set paste<cr>:r !pbpaste<cr>:set nopaste<cr>
" vmap <leader>c :w !pbcopy<CR><CR>

let g:gist_clip_command = 'pbcopy'



" The Silver Searcher
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif


" bind K to grep word under cursor
nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>


" bind \ (backward slash) to grep shortcut
" command -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!

nnoremap \ :Ag<SPACE>

" For Nerd commenter
filetype plugin on


set noeol

" Default mapping
let g:multi_cursor_next_key='<C-n>'
let g:multi_cursor_prev_key='<C-p>'
let g:multi_cursor_skip_key='<C-x>'
let g:multi_cursor_quit_key='<Esc>'

" let g:rspec_command = "Dispatch rspec {spec}"
" let g:rspec_runner = "os_x_iterm"
let g:rspec_command = "! foreman run rspec --drb {spec}"

" gx to open links
let g:netrw_browsex_viewer="google-chrome"

" Rails Vim Shortcuts
noremap <leader>gc :Rcontroller<CR>
noremap <leader>gv :Rview<CR>
noremap <leader>gm :Rmodel<CR>
noremap <leader>gr :e config/routes.rb<CR>
noremap <leader>gs :Rschema<CR>

noremap <silent> <leader>o :bp<CR> " \p previous buffer
noremap <silent> <leader>i :bn<CR> " \n next buffer
noremap <silent> <leader>d :bd<CR> " \d delete buffer
noremap <silent> <leader>b :ls<CR>

" incremental up or down numbers
nnoremap <A-a> <C-a>
nnoremap <A-x> <C-x>

noremap <leader>vv :execute "edit " . "~/.vimrc"<CR>
noremap <leader>vt :execute "edit " . "~/.tmux.conf"<CR>
noremap <leader>vb :execute "edit " . "~/.vimrc.bundles"<CR>
noremap <leader>vr :execute "source " . "~/.vimrc"<CR>
noremap <leader>vs :execute "source " . "~/.vimrc"<CR>

" This is to highlight the line in Insert Mode
" autocmd InsertEnter,InsertLeave * set cul!

" Change cursor depending on the Mode
let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"

" Prepare a :substitute command using the current word or the selected text:
nnoremap <F6> yiw:%s/\<<C-r>"\>/<C-r>"/gc<Left><Left><Left>
vnoremap <F6> y:%s/\<<C-r>"\>/<C-r>"/gc<Left><Left><Left>

" Emacs - style
inoremap <C-e> <C-o>$
inoremap <C-a> <C-o>_

nnoremap <leader>b :buffers<CR>:buffer<Space>

" Markdown

noremap <leader>md :!open -a 'Marked 2' %<cr><cr>

" automatically rebalance windows on vim resize
autocmd VimResized * :wincmd =

" zoom a vim pane, <C-w>= to re-balance
nnoremap <leader>- :wincmd _<cr>:wincmd \|<cr>
nnoremap <leader>= :wincmd =<cr>

" Binding.pry
nmap <leader>bp orequire 'pry'; binding.pry<esc>^


nnoremap å <C-a>
nnoremap ≈ <C-x>

set timeoutlen=500


" Enable built-in matchit plugin
runtime macros/matchit.vim

set nofoldenable " Say no to code folding...

" set relativenumber

let g:fuzzy_ignore = "*.png;*.PNG;*.JPG;*.jpg;*.GIF;*.gif;vendor/**;coverage/**;tmp/**;rdoc/**"

" Release Ctrl P for searching 
let g:ctrlp_map = '<c-:>'
