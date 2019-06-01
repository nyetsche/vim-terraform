" terraform.vim - basic vim/terraform integration
" Maintainer: HashiVim <https://github.com/hashivim>

set formatoptions-=t

if exists('g:loaded_terraform') || v:version < 700 || &compatible || !executable('terraform')
  finish
endif
let g:loaded_terraform = 1

if !exists('g:terraform_fmt_on_save') || !filereadable(expand('%:p'))
  let g:terraform_fmt_on_save = 0
endif

function! s:commands(A, L, P)
  return join([
  \ 'apply',
  \ 'console',
  \ 'destroy',
  \ 'env',
  \ 'fmt',
  \ 'get',
  \ 'graph',
  \ 'import',
  \ 'init',
  \ 'output',
  \ 'plan',
  \ 'providers',
  \ 'push',
  \ 'refresh',
  \ 'show',
  \ 'taint',
  \ 'untaint',
  \ 'validate',
  \ 'version',
  \ 'workspace',
  \ '0.12checklist',
  \ 'debug',
  \ 'force-unlock',
  \ 'state'
  \ ], '\n')
endfunction

augroup terraform
  autocmd!
  autocmd BufEnter *
        \ command! -nargs=+ -complete=custom,s:commands Terraform execute '!terraform '.<q-args>. ' -no-color'
  autocmd BufEnter * command! -nargs=0 TerraformFmt call terraform#fmt()
  if get(g:, 'terraform_fmt_on_save', 1)
    autocmd BufWritePre *.tf call terraform#fmt()
    autocmd BufWritePre *.tfvars call terraform#fmt()
  endif
augroup END
