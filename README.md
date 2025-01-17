dotfiles
========

Install homebrew:

    $ /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

Install [mise](https://mise.jdx.dev/getting-started.html)

Run the following command in whichever directory you usually keep your source code:

    $ git clone https://github.com/rthoward/dotfiles
    $ cd dotfiles
    $ brew bundle
    $ make install

MacOS Setup:

    $ defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false
    $ defaults write NSGlobalDomain KeyRepeat -int 2
    $ defaults write NSGlobalDomain InitialKeyRepeat -int 25
