![Lua](https://img.shields.io/badge/lua-moment-darkblue?style=flat-square&logo=lua)

NOTICE: My configuration for AwesomeWM only works on the latest git master branch. On Arch based distros, all you would have to do is install `awesome-git` from the AUR. On others, you will have to build it manually.


## Setup
This repository has submodules, so make sure you clone it correctly:
```bash
git clone --recurse-submodules https://github.com/JavaCafe01/dotfiles.git
cd dotfiles
git submodule update --remote --merge
```

My neovim configuration uses `packer.nvim`, which should install itself. After opening `nvim` again, do `:PackerSync`. Also, make sure you have all the lsp's installed.

### Dependencies
The following aren't really dependencies (some are), but they are what you need to clone my setup exactly.

I use [`awestore`](https://github.com/K4rakara/awestore) for my panel animation. Look at the repo for install instructions. In short, you just have to use `luarocks` and do this: `sudo luarocks --lua-version 5.3 install awestore`

I use Arch Linux, so all the packages I list can be directly installed with an AUR helper like `paru` or `yay`. The `-git` packages are ones directly from their git master branch.

#### Packages/Programs

```bash
paru -Sy awesome-git zsh tmux picom-git neovim-nightly-bin rofi playerctl thunar discord imagemagick giph farge-git colorpicker-ym1234-git lm_sensors acpid pulseaudio inotify-tools acpilight bat firefox ncspot wezterm
```
Note: Most of these packages are not needed.

(If I'm missing anything, please submit an issue or pull request)

#### Fonts

```bash
paru -Sy ttf-sarasa-gothic nerd-fonts-fira-code noto-fonts-emoji-blob
```

## Modules
### :star: [bling](https://github.com/Nooo37/bling) :star:
Bling brings extra utilities and widgets to AwesomeWM such as tabs, swallowing, layouts, and flash focus. Please check it out and give it a star!

<img src="https://raw.githubusercontent.com/K4rakara/awestore/trunk/demo.gif" alt="gif" align="right" width="100px"/>

<br/>

### [awestore](https://github.com/K4rakara/awestore)
As said in the readme - 
> This library is built off the concept of stores from Svelte. A store is a simple table that can be subscribed to, notifying intrested parties whenever the stored value changes.
Using this module, I can create a sliding animation for my panel.

<br/>

### [layout-machi](https://github.com/xinhaoyuan/layout-machi)
This module is a powerful manual layout that contains an amazing editor to change and make layouts and window locations. It's for powerusers and gives full control of the layout. Give it a star! To the right is a demo of how layout-machi works (this is not its full potential, I'm a noob with it).

<br/>

<img src="https://github.com/JavaCafe01/dotfiles/blob/master/.config/awesome/images/rice.png" alt="img" align="right" width="350px"/>


## System Info
+ **OS**: Arch
+ **Shell**: zsh
+ **Terminal**: [wezterm](https://github.com/wez/wezterm)
+ **Browser**: firefox
    + [firefox-css](https://github.com/JavaCafe01/firefox-css)
+ **Music**: ncspot
+ **GTK Theme**: [phocus](https://github.com/JavaCafe01/phocus)
+ **File Manager**: thunar
+ **App Menu**: rofi
+ **Font**: Sarasa Mono K / Sarasa Fixed K
+ **Wallpapers**: my current wallpaper is under images in the awesome folder, but for all of the ones I have used you can find them [here](https://github.com/JavaCafe01/wallpapers)

## Common Questions

### Multi-Monitor Support?
I have recently started using an extra monitor, and have optimized my config to deal with multiple screens. If there are any issues, please post an issue!

### Where did I steal `ears` from?
It was taken from [elenapan](https://github.com/elenapan/dotfiles).

### How to get anti-aliased rounded corners?
To start off, I do not round any corners with picom or any other fork. I round with AwesomeWM. If you round a widget and lay that ontop of another widget, the corners or anti-aliased (AA). Using this fact, all my panels and notifications are rounded widgets which contain a bottom transparent layer. For the clients, you do the same thing but with titlebars. 

But how did I get shadows? Usually, when you add shadows, it shadows the transparent widget as well, like this: 

<img src="https://github.com/JavaCafe01/dotfiles/blob/master/.config/awesome/images/round_transparent.png" alt="img">

In picom, if you edit the wintypes option by adding `full-shadow = true` for every window type you need, you will fix that problem:

```
wintypes:
{
# ...
    normal = {full-shadow = true;};
# ...
};
```

Here is the result:

<img src="https://github.com/JavaCafe01/dotfiles/blob/master/.config/awesome/images/round_shadow.png" alt="img">

Currently I don't have shadows, but I can easily just enable it in picom and still retain my AA corners.
