#!/usr/bin/env bash

function fetch () {
    local repo="$1"
    local branch="$2"
    if [[ $branch == "" ]]; then
        branch="master"
    fi
    local tmp="tmp"
    test -d "$tmp" || mkdir "$tmp"
    echo ""
    echo "Fetching '${repo}' ..."
    local sha=$(curl -s "https://api.github.com/repos/${repo}/branches/${branch}" | \
                grep \"sha\" | cut -d'"' -f4 | head -n1)
    echo "Extracting '${repo}'@${sha:0:7} ..."
    curl -# -L "https://api.github.com/repos/${repo}/tarball/${branch}" | \
        tar xz --strip=1 -C "${tmp}/"
    find "${tmp}" -type f | xargs chmod 644
    rsync -av "${tmp}/" --include='autoload/***' --include='colors/***' --exclude='*' .
    rm -rf "$tmp"
    git add "colors/*" "autoload/*" > /dev/null
    git commit -m "Update '${repo}'@${sha:0:7}" > /dev/null
}

fetch 'ajmwagar/vim-deus'
fetch 'AlessandroYorba/Despacio'
fetch 'altercation/vim-colors-solarized'
fetch 'jacoborus/tender.vim'
fetch 'jnurmine/Zenburn'
fetch 'junegunn/seoul256.vim'
fetch 'Lokaltog/vim-distinguished' develop
fetch 'mhartington/oceanic-next'
fetch 'morhetz/gruvbox'
fetch 'rakr/vim-two-firewatch'
fetch 'vim-scripts/rdark-terminal2.vim'
fetch 'vim-scripts/twilight256.vim'
fetch 'yorickpeterse/happy_hacking.vim'
fetch 'yuttie/hydrangea-vim'
fetch 'zacanger/angr.vim'
