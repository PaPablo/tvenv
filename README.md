# Tvenv
## Setup a small dev environment using [tmux](https://github.com/tmux/tmux/wiki)

note: you need these three things to make it work

### Installation

1. Clone

1. Add the script to `PATH` (any way you like)

1. (optional) Set the TVENVEDITOR environment variable 
```bash
export TVENVEDITOR='command to open you editor of choice'
```

### RUN

The following flags are available:

* -w : gets two windows 
* -p : gets one small pane below the main window
* [-s | --session] sessionname : gives the tmux session the name sessionname
* [-e | --env] venv : sets the virtual environment of name venv into the setup
    * this flag needs [virtualenvwrapper](https://virtualenvwrapper.readthedocs.io/) to work :)
* [-t | --tool] editor : opens the editor of your choice. Use the full command surrounded by quotes (this can be avoided setting the tvenv editor environment variable)

And once `tvenv` is running
* -q -s sessioname: close the session with name sessionname

#### Example

`tvenv -w -s cool --env develop --tool 'vim -c NERDTree'`
