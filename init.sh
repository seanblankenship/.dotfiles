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

# symlink gitignore
if [ -L $HOME/.gitignore ]; then
    echo ".gitignore symlink exists. Removing."
    rm $HOME/.gitignore
fi
ln -s .dotfiles/gitignore $HOME/.gitignore
echo "Creating symlink to $HOME/.gitignore"

# symlink gitconfig
if [ -L $HOME/.gitconfig ]; then
    echo ".gitconfig symlink exists. Removing."
    rm $HOME/.gitconfig
fi
ln -s .dotfiles/gitconfig $HOME/.gitconfig
echo "Creating symlink to $HOME/.gitconfig"

# symlink gitmodules
if [ -L $HOMES/.gitmodules ]; then
    echo ".gitmodules symlink exists. Removing."
    rm $HOMES/.gitmodules
fi
ln -s .dotfiles/gitmodules $HOME/.gitmodules
echo "Creating symlink to $HOME/.gitmodules"

echo "Finished."
