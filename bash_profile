# .bash_profile

export PATH="$HOME/.bin:/usr/local/sbin:$PATH"
# If .bash_profile exists, bash doesn't read .profile
if [[ -f ~/.profile ]]; then
  . ~/.profile
fi

# If the shell is interactive and .bashrc exists, get the aliases and functions
if [[ $- == *i* && -f ~/.bashrc ]]; then
    . ~/.bashrc
fi

eval "$(rbenv init -)"

# rust racer
export RUST_SRC_PATH=/usr/local/src/rust/src
export PATH="$HOME/.cargo/bin:$PATH"

# virtualenv
source "/usr/local/bin/virtualenvwrapper.sh"
# export WORKON_HOME="/opt/virtual_env/"
