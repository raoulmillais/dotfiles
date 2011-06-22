" Set 256 color mode
set t_Co=256

" Enable syntax highlighting
syntax on
colorscheme zenburn

" Enable sudo save
cmap w!! %!sudo tee > /dev/null %
