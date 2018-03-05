# Tvenv
## Setup a small dev environment with [tmux](https://github.com/tmux/tmux/wiki), [Neovim](https://neovim.io/) and [virtualenvwrapper](https://virtualenvwrapper.readthedocs.io/)

note: you need these three things to make it work

### Intructions

1. Clone the repo

1. cd into the folder containing the script

1. Add the scrip to `PATH` (any way you like)

### RUN

The following flags can be used:

* -w : gets two windows 
* -p : gets one small pane below the main window

* [-s | --session] sessioname : gives the tmux session the name sessioname
* [-e | --env] venv : sets the virtual environment of name venv into the setup

#### Example

`tvenv -w -s cool --env develop`
