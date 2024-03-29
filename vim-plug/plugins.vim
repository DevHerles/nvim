"  ________                ___ ___               .__
"  \______ \   _______  __/   |   \   ___________|  |   ____   ______
"   |    |  \_/ __ \  \/ /    ~    \_/ __ \_  __ \  | _/ __ \ /  ___/
"   |    `   \  ___/\   /\    Y    /\  ___/|  | \/  |_\  ___/ \___ \
"  /_______  /\___  >\_/  \___|_  /  \___  >__|  |____/\___  >____  >
"          \/     \/            \/       \/                \/     \/
" | Author: HerlesINC | Github: DevHerles | Email: herles.incalla@gmail.com |

" auto-install vim-plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  "autocmd VimEnter * PlugInstall
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin('~/.config/nvim/autoload/plugged') " ----------- Start vim plug

Plug 'skbolton/embark'
Plug 'google/yapf'
Plug 'google/vim-maktaba'
Plug 'google/vim-codefmt'
Plug 'voldikss/vim-floaterm'

" LIMELIGTH {{{

Plug 'junegunn/limelight.vim'

" }}}

" GOYO {{{

Plug 'junegunn/goyo.vim'

" }}}

" MARKDOWN {{{

Plug 'tpope/vim-markdown' " ------------------------ Vim Markdown runtime files
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}

" }}}

" PSQL {{{

Plug 'lifepillar/pgsql.vim'

" }}}

Plug 'tpope/vim-sleuth' " ----------------------------- Auto set indent setting

" CLOSE-BUFFER {{{

Plug 'moll/vim-bbye' " ------ Allows you to delete current buffer (close files)
Plug 'vim-scripts/BufOnly.vim' " --------------- Allows to delete other buffers

" }}}

" WHICK-KEY {{{

Plug 'liuchengxu/vim-which-key', { 'on': ['WhichKey', 'WhichKey!'] }

" }}}

" VIM-MUNDO {{{

Plug 'simnalamburt/vim-mundo'

" }}}

" DART, FLUTTER {{{

Plug 'dart-lang/dart-vim-plugin'
Plug 'natebosch/vim-lsc'
Plug 'natebosch/vim-lsc-dart'
Plug 'thosakwe/vim-flutter'

" }}}

" VIM EXPAND REGION {{{

" ------------------ Press + to expand the visual selection and _ to shrink it.
Plug 'terryma/vim-expand-region'

" }}}

" COLORS, THEMES {{{

Plug 'DevHerles/aranda', { 'rtp': 'vim' }
Plug 'ghifarit53/tokyonight-vim'
Plug 'sheerun/vim-polyglot'
Plug 'joshdick/onedark.vim'
Plug 'arcticicestudio/nord-vim'
Plug 'cocopon/iceberg.vim'
Plug 'rakr/vim-one'
Plug 'drewtempelmeyer/palenight.vim'
Plug 'norcalli/nvim-colorizer.lua'
Plug 'ryanoasis/vim-devicons'

" }}}

" TOOLBAR {{{

Plug 'vim-airline/vim-airline' " -------------------------- Status bar, Tabline
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive' " -------- Just use to show git status in Vim-Airline

" }}}

" FINDER {{{

Plug 'junegunn/fzf', { 'do': { -> fzf#install() }}
Plug 'junegunn/fzf.vim' " ------------------------------------------ fzf in vim
Plug 'airblade/vim-rooter'
Plug 'jesseleite/vim-agriculture'

" }}}

" RANGER {{{

Plug 'kevinhwang91/rnvimr', {'do': 'make sync'} " ---------- Ranger integration

" }}}

" NAVIGATE {{{

Plug 'easymotion/vim-easymotion' " --------- Jump around the screen like a boss

" }}}

" FASTER CODE {{{

Plug 'tmsvg/pear-tree' " ----------------------------------- Auto pair brackets
Plug 'tpope/vim-surround' " ------------------------------------- Auto surround
Plug 'tpope/vim-repeat' " ---------------------------- dot repeat with pluggins
Plug 'tpope/vim-commentary' " ------------------------------- Comment stuff out
Plug 'Yggdroot/indentLine' " -------------------------- Indent code with v-line
Plug 'mg979/vim-visual-multi' " ------------------------------- Multiple Cursor

" }}}

" UTILS {{{

Plug 'NLKNguyen/copy-cut-paste.vim' " -------------- Copy, Paste with Clipboard
Plug 'segeljakt/vim-silicon' " ---_----------------------- Could be enteresting
Plug 'RRethy/vim-illuminate' " - Auto highlight other uses of word under cursor
" }}}

" COC {{{

Plug 'neoclide/coc.nvim', {'branch': 'release'}

" }}}

" TMUX {{{

Plug 'christoomey/vim-tmux-navigator'

" }}}

" ACK {{{

Plug 'mileszs/ack.vim' " ---------- Don't forget: sudo apt-get install ack-grep

" }}}

" WHITESPACE {{{

Plug 'ntpeters/vim-better-whitespace' "Highlight trailing whitespace characters

" }}}

" SIGNIFY {{{

if has('nvim') || has('patch-8.0.902')
  Plug 'mhinz/vim-signify' " - indicate added, modified and removed lines (VCS)
else
  Plug 'mhinz/vim-signify', { 'branch': 'legacy' }
endif

" }}}

call plug#end() " -------------------------------------- End of Vim-Plug define

" ---------------------------- Automatically install missing plugins on startup
autocmd VimEnter *
  \  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \|   PlugInstall --sync | q
  \| endif
