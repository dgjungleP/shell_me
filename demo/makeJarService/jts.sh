#!/usr/bin/env bash

baseTail="jar"
baseDir=$(pwd)
if [[ $# -ge 1 ]];then

    filename=$1

    tail=$(echo ${filename}|awk  -F "." '{print $(NF)}' )
    name=$(echo ${filename}|awk  -F "." '{print $(NF-1)}' )
    if test ${tail} = ${baseTail}; then

        filePath=${baseDir}/${filename}

        if test -e ${filePath}; then

            touch ${baseDir}/${name}.conf

            if test -e /etc/init.d/${name} ; then
                echo "Created!"
                exit
            fi
            $(ln -s ${filePath} /etc/init.d/${name} && chmod +x ${filePath})

            if [[ $? -eq 0 ]] ; then

                echo "success!"
                exit
            fi
        fi
    fi
    echo " failed !"
fi

