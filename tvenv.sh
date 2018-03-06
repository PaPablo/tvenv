#!/bin/bash
#if [ "$#" -lt 4 ]; then
    #echo "Usage: tvenv <[-p | -w]> [ [ -s | --session ] sessionname ] [ [ -e | --venv ] virtualenv ]" 
   #exit
#fi

# Virtualenv name
VENV=

# Disposition [panes|windows]
DISP=

# Tmux session name
SESSIONNAME=

# Close current tvenv session
if [ "$1" = "-q" ]; then
    shift
    if [ $# -le 1 ]; then
        echo "Need a specified session name to close"
        exit
    else
        SESSIONAME=$2
        if [ "$1" = "-s" ]; then
            read -p "Desea cerrar la sesión? $SESSIONAME? (y/n) " r
            if [ "$r" = "y" ];then 
                tmux kill-session -t "$SESSIONNAME"
            fi
            exit
        else
            echo "Where is my session!?"
            exit
        fi
        
    fi
fi
            

# Parse command line arguments
while test $# -gt 0
do
    case $1 in
        "-e"|"--env")
            # virtualenv name
            if [ -z "$VENV" ];
            then
                VENV=$2
            fi
        ;;
        "-w"|"-p")
            # Disposition, windows or panes
            if [ -z "$DISP"];
            then
                DISP=$1
            fi
        ;;
        "-s"|"--session")
            # Session name
            if [ -z "$SESSIONNAME" ];
            then
                SESSIONNAME=$2
            fi
        ;;
        "-t"|"--tool")
            #tool to use
            if [ -z "$TOOL" ]; then
                TOOL=$2
            fi
        ;;
    esac
    shift
done

# If I got the venv name, then declare the commands to setup the environment
if [ -n "$VENV" ];
then
    if test $DISP = "-p";
    then
        VENVCMD="tmux send-keys -t 0.0 'workon $VENV' C-m && tmux send-keys -t 0.1 'workon $VENV' C-m && tmux send-keys -t 0.1 'clear' C-m"
    else
        VENVCMD="tmux send-keys -t 0.0 'workon $VENV' C-m && tmux send-keys -t 1.0 'workon $VENV' C-m"
    fi
fi

# Command for pane disposition 
PANES="tmux splitw && tmux resizep -t 0.0 -y 40"

# Command for window disposition
WINDOW="tmux neww"

# Command for editor
if [ -z "$TOOL" ]; then
    if [ -z "$TVENVEDITOR" ]; then
        TOOL=$EDITOR
    else
        TOOL=$TVENVEDITOR
    fi
fi

NVIM="tmux send-keys -t 0.0 '$TOOL' C-m "

# Default session name if none was given
if [ -z "$SESSIONNAME" ];
then
    SESSIONNAME=develop
fi

tmux new-session -d -s $SESSIONNAME

# Setup panes or windows
if test $DISP = "-p";
then
    eval $PANES
else
    if test $DISP = "-w";
    then
        eval $WINDOW
    fi
fi

# venv commands
if [ -n "$VENV" ];
then
    eval $VENVCMD
fi

# Open Nvim in my setup
eval $NVIM

tmux select-window -t 0.0
tmux attach -t $SESSIONNAME
