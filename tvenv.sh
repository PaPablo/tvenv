#!/bin/bash
if [ "$#" -lt 1 ]; then
    echo "Usage: tvenv <[-p | -w]> [ [ -s | --session ] sessionname ] [ [ -e | --venv ] virtualenv ]" 
   exit
fi

# Virtualenv name
VENV=

# Disposition [panes|windows]
DISP=

# Tmux session name
SESSIONNAME=

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

# Command for nvim
NVIM="tmux send-keys -t 0.0 'nvim -c NERDTree' C-m "

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