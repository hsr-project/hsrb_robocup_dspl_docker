#!/bin/sh

# check .gitconfig is txt file.
FILE="$HOME/.gitconfig"
if [ -d $FILE ]; then
    echo ".gitconfig is directory"
    mv $FILE $FILE.bak
    touch $FILE
elif [ -f $FILE ]; then
    echo ".gitconfig is exsists and its text file"
else
    touch $FILE
fi

# setup DISPLAY environment for gpu
if [ "$1" = "gpu" ]; then
    if [ $DISPLAY = :1 ]; then
	echo "Your DISPLAY environment is :1"
	export DISPLAY_ENV=:0
	export DISPLAY_PATH=X1
    fi
    echo "Use GPU render"
    DISPLAY=$DISPLAY xhost si:localuser:root
    docker-compose -f docker-compose.nvidia.yml up
elif [ $# = 0 ]; then
    docker-compose up
else
    echo "Plese set correct argument"
    exit 1
fi
