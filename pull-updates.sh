#!/usr/bin/env bash

function fetch () {
    local repo="$1"
    local tmp=".cache"
    test -d "$tmp" || mkdir -p "$tmp"
    echo ""
    echo "Fetching '${repo}' ..."
    local wc="${tmp}/${repo/\//_}"
    # clone remote repo if doesn't exist in local cache directory
    test -d "$wc" || git clone "https://github.com/${repo}.git" "$wc"
    # pull any updates from the remote repo
    git -C "$wc" pull
    # get commit id for HEAD
    local sha=$(git -C "$wc" rev-parse HEAD)
    # copy relevant files to the root repo
    rsync -a "${wc}/" --include='autoload/***' --include='colors/***' --exclude='*' .
    # disable all executable bits
    find "autoload" "colors" -type f | xargs chmod 644
    # commit any changes
    git add "colors/*" "autoload/*" > /dev/null
    git commit -m "Sync colorscheme: ${repo} @${sha:0:7}"
}

fetch 'ajmwagar/vim-deus'
fetch 'AlessandroYorba/Despacio'
fetch 'altercation/vim-colors-solarized'
fetch 'benburrill/potato-colors'
fetch 'fatih/molokai'
fetch 'jacoborus/tender.vim'
fetch 'jnurmine/Zenburn'
fetch 'junegunn/seoul256.vim'
fetch 'Lokaltog/vim-distinguished'
fetch 'maksimr/Lucius2'
fetch 'mhartington/oceanic-next'
fetch 'morhetz/gruvbox'
fetch 'phanviet/vim-monokai-pro'
fetch 'rakr/vim-two-firewatch'
fetch 'srcery-colors/srcery-vim'
fetch 'szorfein/fromthehell.vim'
fetch 'vim-scripts/rdark-terminal2.vim'
fetch 'vim-scripts/twilight256.vim'
fetch 'yorickpeterse/happy_hacking.vim'
fetch 'yuttie/hydrangea-vim'
fetch 'zacanger/angr.vim'
