#!/bin/bash

# Helper functions.
function notice { echo -e "\033[1;32m=> $1\033[0m"; }
function error { echo -e "\033[1;31m=> Error: $1\033[0m"; }

# Install dependencies.
yes | sudo apt-get install git-core ruby rubygems rake
yes | sudo gem install bundler dotfiles-installer
export PATH=$PATH:/var/lib/gems/1.8/bin
bundle update

# Copy original .bashrc to .bashrc.local.
if [ -f ~/.bashrc ] && [ ! -f ~/.bashrc.local ]; then
    cp ~/.bashrc ~/.bashrc.local
fi

# Are we updating or installing?
if [ -d ~/.dotfiles ]; then
  notice "Updating..."
  cd ~/.dotfiles
  git pull origin master
  git submodule init
  git submodule update

  notice "Installing..."
  bundle exec rake install
else
  notice "Downloading..."
  git clone --recursive git@github.com:robingustafsson/dotfiles.git ~/.dotfiles

  notice "Installing..."
  cd ~/.dotfiles
  bundle exec rake install
fi

# Finished.
cd $current_pwd
notice "Done"

# Source dotfiles.
if [ -f ~/.bashrc ] ; then
    source ~/.bashrc
fi
