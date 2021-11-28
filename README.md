# README

## Installation

Clone the repository, copy the `.config` and `.emacs.d` directories, and other files as needed!


## Desktop Environment

I typically use Cinnamon as my DE, with optional `bspwm` for my laptop.


## `[ $(hostname) == $HOSTNAME ]`

For reference, "argo" is a Linux workstation and "wei" is my Thinkpad T495.

## Dependencies

### Full dependency list

* Emacs 24+
* `tmux`
* `neofetch` + `figlet` + `lolcat`
* `bspwm`
* `sxhkd`
* `polybar`
* `playerctl`
* [Murzchvnok/polybar-collections](https://github.com/Murzchnvok/polybar-collection)

### Bash + tmux

The essential files `.bash_profile` and `.tmux.conf` only rely on `bash` and `tmux`.

### Emacs 24+

Emacs is assumed to be version 24+. Melpa configuration is provided in `init.el` and `.emacs.d/config_lisp_files/common-config.el`. Melpa dependencies are listed in `.emacs.d/package-activated-list.txt`.

### Laptop `bswpm` 'rice'

Other configurations (`bspwm`, `sxhkd`, `polybar`, etc.) are designed for a laptop where power efficiency is key.

Possibly others...


## Fonts

Fontawesome should be installed because awesome is in the name.

### Polybar customizations

You need to download and install these fonts from NerdFonts:

JetBrainsMono
Iosevka
UbuntuMono

Also you'll need to install MaterialIcons.ttf (typically `/usr/share/fonts/`

