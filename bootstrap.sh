#!/bin/zsh

# Xcode Version
sudo xcode-select -s /Applications/Xcode.app/Contents/Developer

# Ruby Version
source "$HOME/.rvm/scripts/rvm"
rvm gemset use --create 2.0.0@EBK_DEMO

# Install gems
gem install bundler
bundle