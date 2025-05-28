#!/usr/bin/env bash

cd $HOME/workspace
git clone https://gite.lirmm.fr/pid/pid-workspace.git
cd pid-workspace
./pid configure
echo "source $HOME/workspace/pid-workspace/share/pid.sh" >> $HOME/.zshrc
