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

" CONCEAL/UNCONCEAL {{{

let s:conceal = 0
function! ConcealUnconceal()
  echo "hehehehhe"
  if (s:conceal == 1)
    execute ":set conceallevel=2"
    let s:conceal = 0
  else
    execute ":set conceallevel=0"
    let s:conceal = 1
  endif
endfunction

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

" JAVA CRUD FILES {{{

function! GenerateJavaCRUDfiles(Model)
  let s:curr_path = expand('<sfile>:p:h')
  let s:path = "/microservice/src/main/java/com/aranda/microservice/"
  let s:repository_path = "repository/".a:Model."Repository.java"
  let s:full_path = s:curr_path . s:path . s:repository_path
  echo s:full_path
  execute ":3,9w " . s:full_path

  let s:service_path = "service/".a:Model."Service.java"
  let s:full_path = s:curr_path . s:path . s:service_path
  echo s:full_path
  execute ":13,57w " . s:full_path

  let s:controller_path = "controller/".a:Model."Controller.java"
  let s:full_path = s:curr_path . s:path . s:controller_path
  echo s:full_path
  execute ":61,142w " . s:full_path

  let s:pagination_path = "model/pagination/".a:Model."Page.java"
  let s:full_path = s:curr_path . s:path . s:pagination_path
  echo s:full_path
  execute ":146,148w " . s:full_path
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
