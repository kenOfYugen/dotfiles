<p align="center">
  <img width="15%" src="https://github.com/javacafe01.png" />
</p>

<p align="center">
  <b>There is no place like ~</b>
</p>

<p align="center">
  <b>👻 Gokul's Dot Files 👻</b>
</p>

## Preview

> ### Normal

<p align="center">
<img src="https://imgur.com/8fq7O2M.jpg" alt="img" width="900px">
</p>

> ### Launcher

<p align="center">
<img src="https://imgur.com/JmwkI1F.jpg" alt="img" width="900px">
</p>

> ### Lock Screen

<p align="center">
<img src="https://imgur.com/O8guGbD.jpg" alt="img" width="900px">
</p>

> ### Sample Workflow

<p align="center">
<img src="https://imgur.com/I3Z9oLM.jpg" alt="img" width="900px">
</p>

> ### Autohide Polybar

<p align="center">
<img src="https://imgur.com/PoAK9Z9.gif" alt="img" width="900px">
</p>

To achieve this, I basically start polybar whenever the cursor is in range and kill it when out of range. I found a python script to this [here](https://www.reddit.com/r/unixporn/comments/7sm2ch/oc_updated_polybarautohide/), but converted the script from python to shell, which worked well until it started to break so I reverted back to the python script.
## System Info

+ **OS**: Arch
+ **Shell**: zsh
+ **Terminal**: kitty
+ **Editor**: neovim
+ **File Manager**: thunar
+ **Launcher**: rofi
+ **Browser**: qutebrowser
+ **Color Scheme**: [gruvbox material](https://github.com/sainnhe/gruvbox-material)
+ **GTK Theme**: [wpgtk](https://github.com/deviantfero/wpgtk) generated

### Discord

I use [Enhanced Discord](https://github.com/joe27g/EnhancedDiscord) to change the theme. Special thanks to [ElKowar's boxful of gruv](https://github.com/elkowar/a-box-of-gruv) for the amazing gruvbox theme.

> ### Screenshot

<p align="center">
<img src="https://imgur.com/F9oPGbG.jpg" alt="img" width="600px">
</p>

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

### Browser

My startpage files can be found [here](https://github.com/JavaCafe01/startpage).
