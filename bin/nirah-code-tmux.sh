#!/bin/bash

SESSIONNAME="nirah-code"
tmux has-session -t $SESSIONNAME &> /dev/null

if [ $? != 0 ] 
 then
    tmux new-session -s $SESSIONNAME -n script -d

    tmux rename-window -t $SESSIONNAME:0 zero

    tmux new-window -t $SESSIONNAME -n git
    tmux send-keys -t $SESSIONNAME "cd ~/Codes/nirahapp/core" C-m 
    tmux split-window -h -t $SESSIONNAME
    tmux send-keys -t $SESSIONNAME "cd ~/Codes/nirahapp/nomad-experiments" C-m 
    tmux split-window -v -t $SESSIONNAME
    tmux send-keys -t $SESSIONNAME "cd ~/Codes/nirahapp/website" C-m 
    tmux select-pane -L
    tmux split-window -v -t $SESSIONNAME
    tmux send-keys -t $SESSIONNAME "cd ~/Codes/nirahapp/dashboard" C-m 

    tmux new-window -t $SESSIONNAME -n core
    tmux send-keys -t $SESSIONNAME "cd ~/Codes/nirahapp/core" C-m 
    tmux split-window -h -t $SESSIONNAME
    tmux send-keys -t $SESSIONNAME "cd ~/Codes/nirahapp/core" C-m 
    tmux split-window -v -t $SESSIONNAME
    tmux send-keys -t $SESSIONNAME "cd ~/Codes/nirahapp/core" C-m 
    tmux select-pane -L
    tmux split-window -v -t $SESSIONNAME
    tmux send-keys -t $SESSIONNAME "cd ~/Codes/nirahapp/core" C-m 

    tmux new-window -t $SESSIONNAME -n dashboard
    tmux send-keys -t $SESSIONNAME "cd ~/Codes/nirahapp/dashboard" C-m 
    tmux split-window -h -t $SESSIONNAME
    tmux send-keys -t $SESSIONNAME "cd ~/Codes/nirahapp/dashboard" C-m 
    tmux split-window -v -t $SESSIONNAME
    tmux send-keys -t $SESSIONNAME "cd ~/Codes/nirahapp/dashboard" C-m 
    tmux select-pane -L
    tmux split-window -v -t $SESSIONNAME
    tmux send-keys -t $SESSIONNAME "cd ~/Codes/nirahapp/dashboard" C-m 

    tmux new-window -t $SESSIONNAME -n infra
    tmux send-keys -t $SESSIONNAME "cd ~/Codes/nirahapp/nomad-experiments" C-m 
    tmux split-window -h -t $SESSIONNAME
    tmux send-keys -t $SESSIONNAME "cd ~/Codes/nirahapp/nomad-experiments" C-m 
    tmux split-window -v -t $SESSIONNAME
    tmux send-keys -t $SESSIONNAME "cd ~/Codes/nirahapp/nomad-experiments" C-m 
    tmux select-pane -L
    tmux split-window -v -t $SESSIONNAME
    tmux send-keys -t $SESSIONNAME "cd ~/Codes/nirahapp/nomad-experiments" C-m 

    tmux new-window -t $SESSIONNAME -n website
    tmux send-keys -t $SESSIONNAME "cd ~/Codes/nirahapp/website" C-m 
    tmux split-window -h -t $SESSIONNAME
    tmux send-keys -t $SESSIONNAME "cd ~/Codes/nirahapp/website" C-m 
    tmux split-window -v -t $SESSIONNAME
    tmux send-keys -t $SESSIONNAME "cd ~/Codes/nirahapp/website" C-m 
    tmux select-pane -L
    tmux split-window -v -t $SESSIONNAME
    tmux send-keys -t $SESSIONNAME "cd ~/Codes/nirahapp/website" C-m 
fi

tmux attach -t $SESSIONNAME

