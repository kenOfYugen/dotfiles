<p align="center">
  <img width="40%" src="https://imgur.com/ZGE5XCL.png" />
</p>

<p align="center">
  <b>  </b>
</p>

## Preview

<p align="center">
<img src="https://imgur.com/GvWqC9t.png" alt="img" width="900px">
</p>

This rice was heavily ~~stolen from~~ inspired by [elenapan](https://github.com/elenapan/dotfiles/tree/master/config/awesome) and [Eredarion](https://github.com/Eredarion/dotfiles/tree/master/.config/awesome).

## System Info

+ **OS**: Arch
+ **Shell**: zsh
+ **Terminal**: [st](https://github.com/JavaCafe01/suckless)
+ **Editor**: nvim
+ **File Manager**: thunar
+ **Launcher**: [dmenu](https://github.com/JavaCafe01/suckless)
+ **Browser**: firefox
+ **Color Scheme**: custom
+ **GTK Theme**: [phocus](https://github.com/phocus/gtk)
+ **Wallpaper**: [here](https://github.com/JavaCafe01/dotfiles/blob/master/.config/awesome/images/bg.png)

### Fonts

+ IBM Plex Mono
+ JetBrains Mono
+ Nerd Font Icons

### Discord

Here is my discord [theme](https://gist.github.com/JavaCafe01/ff090411cd9e2e5409d9d13216ef034b). Use whatever you want to inject it.

> ### Screenshot

<p align="center">
<img src="https://imgur.com/k6wpjHB.png" alt="img" width="600px">
</p>

## Setup

I use `awesome-git`, not the regular packaged version. Figure the rest on your own!

### Browser

I use Firefox Review with some minor edits. My fork of it can be found [here](https://github.com/JavaCafe01/firefox-review).

My startpage files can be found [here](https://github.com/JavaCafe01/startpage).

### Migrate to my dots

I maintain my dotfiles using [dotbare](https://github.com/kazhala/dotbare). It's basically a wrapper program (with fzf) for the git bare repository method of handling dotfiles.

If you want to use my dots, follow these simple steps: 
1. Install [dotbare](https://github.com/kazhala/dotbare)
2. Setup environment variables, for example in your `.zshrc` 
    ```bash
    export DOTBARE_DIR="$HOME/.cfg"
    export DOTBARE_TREE="$HOME"
    ```
3. Use this remote's url with dotbare
    ```bash
    dotbare finit -u https://github.com/JavaCafe01/dotfiles.git
    ```
Everything is further explained on the readme in dotbare's [repo](https://github.com/kazhala/dotbare).

## Old Dots

If you are looking for my old bspwm setup, go [here](https://github.com/JavaCafe01/dotfiles/tree/79da31811d5fcf32e999e5bdc536c55efdc4dfed).
