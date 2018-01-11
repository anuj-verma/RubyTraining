* mkdir -p ~/.vim/autoload ~/.vim/bundle
* curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
* git clone git://github.com/vim-ruby/vim-ruby.git ~/.vim/bundle/vim-ruby

* In your .vimrc file, add the below lines:

```
execute pathogen#infect()
set ts = 2
set sw = 2
set expandtab
syntax on
set nocompatible
filetype on
filetype indent on
filetype plugin on
```
