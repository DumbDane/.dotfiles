# Dotfiles
This directory contains configurations and dotfiles for my nixos systems


## NixOS
Unsure how to download but nixOS of some kind for sure required aside from other requir.

### Requirements
    git
    nixOS of some kind (only if you want stuff from nix/)



## dotfiles
General dotfiles for things like .zshrc

### Requirements
    git
    stow
    
```
enviroment.pkgs = [
  ...
  git
  stow
  fzf
  zoxide
];
```

Additional requirements for neovim lsp configuration
```
enviroment.pkgs = [
    ...
    python3 
    nodejs
    cargo
];

```

### Installation
First, check out the dotfiles repo in $HOME directory

```
  git clone git@github.com:DumbDane/.dotfiles.git && \
  cd dotfiles
```

Then use GNU Stow to create symlinks

```
  stow .
```

More info on stow:
https://www.youtube.com/watch?v=y6XCebnB9gs
