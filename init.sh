 #!/bin/bash

OH_MY_ZSH_DIR=$HOME/.oh-my-zsh

if [ ! -d $HOME/.dotfiles ]; then
    echo "Dotfiles do not exist. Creating Dotfiles."
    cd $HOME
    git clone git@github.com:seanblankenship/dotfiles.git $HOME/.dotfiles
else
    echo "Dotfiles exist. Pulling in changes."
    cd $HOME/.dotfiles
    git pull
fi

cd $HOME/.dotfiles
git pull
git submodule update --init --recursive

if [ -d $OH_MY_ZSH_DIR ]; then
    cd $OH_MY_ZSH_DIR
    git pull
    cd $HOME
else
    echo "Checking out oh-my-zsh."
    git clone git://github.com/robbyrussell/oh-my-zsh.git $HOME/.oh-my-zsh
fi

cd $HOME

echo "Creating symlinks."

# symlink .vim
if [ -L $HOME/.vim ]; then
    echo ".vim symlink exists. Removing."
    rm $HOME/.vim
fi
ln -s .dotfiles/vim $HOME/.vim
echo "Creating symlink to $HOME/.vim"

# symlink vimrc
if [ -L $HOME/.vimrc ]; then
    echo ".vimrc symlink exists. Removing."
    rm $HOME/.vimrc
fi
ln -s .dotfiles/vimrc $HOME/.vimrc
echo "Creating symlink to $HOME/.vimrc"

# symlink zshrc
if [ -L $HOME/.zshrc ]; then
    echo ".zshrc symlink exists. Removing."
    rm $HOME/.zshrc
fi
ln -s .dotfiles/zshrc $HOME/.zshrc
echo "Creating symlink to $HOME/.zshrc"

echo "Finished."
