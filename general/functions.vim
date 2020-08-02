"  ________                ___ ___               .__
"  \______ \   _______  __/   |   \   ___________|  |   ____   ______
"   |    |  \_/ __ \  \/ /    ~    \_/ __ \_  __ \  | _/ __ \ /  ___/
"   |    `   \  ___/\   /\    Y    /\  ___/|  | \/  |_\  ___/ \___ \
"  /_______  /\___  >\_/  \___|_  /  \___  >__|  |____/\___  >____  >
"          \/     \/            \/       \/                \/     \/
" | Author: HerlesINC | Github: DevHerles | Email: herles.incalla@gmail.com |

" Turn spellcheck on {{{

augroup auto_spellcheck
  autocmd BufNewFile,BufRead *.md setlocal spell
augroup END

" }}}

" FOLD/UNFOLD ALL {{{

let s:unfold_all = 0
function! FoldUnfodlAll()
  if (s:unfold_all == 1)
    execute "normal! zM"
    let s:unfold_all = 0
  else
    execute "normal! zR"
    let s:unfold_all = 1
  endif
endfunction

" }}}

"  MyNext() and MyPrev(): Movement between tabs OR buffers {{{

function! MyNext()
    if exists( '*tabpagenr' ) && tabpagenr('$') != 1
        " Tab support && tabs open
        normal gt
    else
        " No tab support, or no tabs open
        execute ":bnext"
    endif
endfunction
function! MyPrev()
    if exists( '*tabpagenr' ) && tabpagenr('$') != '1'
        " Tab support && tabs open
        normal gT
    else
        " No tab support, or no tabs open
        execute ":bprev"
    endif
endfunction

" }}}

" DELETE TRAILING {{{

func! DeleteTrailingWS()
  exe "normal mz"
  %s/\s\+$//ge " /\s\+$/ regex for one or more whitespace characters followed by the end of a line
  exe "normal `z"
endfunc

autocmd BufWrite *.* :call DeleteTrailingWS()

" }}}
