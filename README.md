<p align="center">
  <img width="15%" src="https://github.com/javacafe01.png" />
</p>

<p align="center">
  <b>There is no place like ~</b>
</p>

<p align="center">
  <b>👻 Gokul's Dot Files 👻</b>
</p>

<p align="center">
<img src="https://imgur.com/KIPOkYW.jpg" alt="img" width="900px">
</p>

## System Info

+ **OS**: Arch
+ **Shell**: zsh
+ **Terminal**: kitty
+ **Editor**: neovim
+ **File Manager**: thunar
+ **Launcher**: rofi
+ **Browser**: firefox / qutebrowser
+ **Color Scheme**: Nord
+ **GTK Theme**: [wpgtk](https://github.com/deviantfero/wpgtk) generated

### Why two window managers?

Bspwm used to be my daily driver, but occasionaly it glitches on me. I then hopped window managers to dwm and qtile. Dwm was simple and usable, but it was hyped way too much and I didn't like the suckless philosophy. Qtile was neat and stable, except it was in python. Spectrwm was inspired by dwm and xmonad and it is written in C, which peaked my curiosity and lead to where I am today. Its snappy and hasn't failed me yet.

## Setup

I maintain my dotfiles using [dotbare](https://github.com/kazhala/dotbare). It's basically a wrapper program for the git bare repository method of handling dotfiles.

### Migrate to my dots

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

### Firefox

I use a nord firefox theme, credits to dpcdpc11, from deviantart which can be found [here](https://www.deviantart.com/dpcdpc11/art/Nord-for-Firefox-837860916).

My startpage files can be found [here](https://github.com/JavaCafe01/startpage).
