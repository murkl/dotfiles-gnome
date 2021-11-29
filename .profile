#!/bin/sh

# ECOS
source "$HOME/.ecos/profile"

# PATH
export PATH="$PATH:$HOME/.local/bin"

# XDG
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"

# ZSH
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"

# CLEAN HOME
mkdir -p "$XDG_CONFIG_HOME/wget"
export WGETRC="$XDG_CONFIG_HOME/wget/wgetrc"
export GNUPGHOME="$XDG_DATA_HOME/gnupg"
mkdir -p "$XDG_DATA_HOME/wineprefix"
export WINEPREFIX="$XDG_DATA_HOME/wineprefix/default"
export PASSWORD_STORE_DIR="$XDG_DATA_HOME/password-store"
export LESSHISTFILE="-"

# MAVEN
export M2_HOME="$XDG_DATA_HOME/maven"

# NPM
export NPM_CONFIG_PREFIX="$XDG_DATA_HOME/node_modules"
mkdir -p "$XDG_CONFIG_HOME/npm"
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/config"
export NPM_CONFIG_CACHE="$XDG_CACHE_HOME/npm"
export NPM_CONFIG_TMP="$XDG_RUNTIME_DIR/npm"

# JAVA
export JDK_HOME="/usr/lib/jvm/java-11-openjdk/"
export JAVA_HOME="$JDK_HOME"
#export _JAVA_AWT_WM_NONREPARENTING=1
