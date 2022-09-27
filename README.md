dotfiles
========
# dotfiles

Install homebrew:

    $ /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

Install asdf

    $ git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.10.2
    
Run the following command in whichever directory you usually keep your source code:

    $ git clone https://github.com/rzane/dotfiles
    $ cd dotfiles
    $ brew bundle
    $ make install

