#!/bin/bash
watch() {
    declare -a FILES=(
        "cv-mikail-colak.md"
        "template.html"
    )
    declare -a LAST=()
    
    LEN=${#FILES[@]}

    for (( i=0; i<${LEN}; i++ )); do
        LAST[$i]=`stat "${FILES[$i]}"`
    done

    
    while true; do
        sleep 1
        for (( i=0; i<${LEN}; i++ )); do
            NEW=`stat "${FILES[$i]}"`
            if [ "$NEW" != "${LAST[$i]}" ]; then
                ./scripts/compile.sh
                LAST[$i]=$NEW
            fi
        done
    done

}

watch