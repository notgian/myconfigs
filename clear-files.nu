#!/usr/bin/env nu

if ("nvim" | path exists) {
    rm -r ./nvim
}

if ("tmux" | path exists) {
    rm -r ./tmux
}

if ("nushell" | path exists) {
    rm -r ./nushell
}



