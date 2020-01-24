#!/usr/bin/env zsh

cd "$(dirname "${BASH_SOURCE}")";

git pull origin master;

function doIt() {
    rsync --exclude ".git/" \
        --exclude ".DS_Store" \
        --exclude ".osx" \
        --exclude ".idea/" \
        --exclude "bootstrap.sh" \
        --exclude "README.md" \
        --exclude "LICENSE" \
        --exclude ".gitignore" \
        -avh --no-perms . ~;
    chmod 700 ~/.ssh
    chmod 700 ~/.gnupg
    chmod 600 ~/.ssh/authorized_keys
    source ~/.zshrc;
}

if [[ "$1" == "--force" || "$1" == "-f" ]]; then
    doIt;
else
    printf '%s ' 'This may overwrite existing files in your home directory. Are you sure? (y/n)' 
    read ans
    echo "";
    if [[ ans =~ ^[Yy]$ ]]; then
        doIt;
    fi;
fi;
unset doIt;
