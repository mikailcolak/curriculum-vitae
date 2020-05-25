#!/bin/bash
chromePath() {
    local rv=$1
    if hash google-chrome 2>/dev/null; then
        eval $rv=google-chrome
    else
        eval $rv='/c/Program\ Files\ \(x86\)/Google/Chrome/Application/chrome.exe'
    fi
}

compile() {
    SRC=$1
    DST=$2
    UNAME=$(uname)
    
    cwd=$(pwd)
    if [[ "$UNAME" == CYGWIN* || "$UNAME" == MINGW* ]] ; then
        cwd=$(pwd -W)
    fi

    chromePath chrome

    pandoc\
        -s\
        --template template.html\
        -s $SRC\
        -o $DST.html
    
    "${chrome}"\
        --incognito\
        --headless\
        --disable-gpu\
        --disable-extensions\
        --run-all-compositor-stages-before-draw\
        --print-to-pdf="${cwd}/${DST}.pdf" "file://${cwd}/${DST}.html"
}

compile 'cv-mikail-colak.md' 'cv-mikail-colak'
echo $(stat cv-mikail-colak.md | grep Size)
