#!/bin/bash

function roswss_rm_package() {
    local rosinstall
    rosinstall=$1
    shift

    if [[ "$rosinstall" = "--help" || -z "$rosinstall" ]]; then
        _roswss_rm_package_help
        return 0
    fi

    # TODO: Check if local package!
    if roscd $rosinstall ; then
        wstool rm $PWD
        cd ..
        rm -rf $rosinstall
        return 0
    fi

    return 1
}

function _roswss_rm_package_help() {
    echo "Type name of rospackage to rm_package."
}

function _roswss_rm_package_complete() {
    local cur

    if ! type _get_comp_words_by_ref >/dev/null 2>&1; then
        return 0
    fi

    COMPREPLY=()
    _get_comp_words_by_ref cur

    if [[ "$cur" == -* ]]; then
        COMPREPLY=( $( compgen -W "--help" -- "$cur" ) )
    else
        COMP_WORDS=( roscd $cur )
        COMP_CWORD=1
        _roscomplete
    fi

    return 0
}
complete -F _roswss_rm_package_complete roswss_rm_package
