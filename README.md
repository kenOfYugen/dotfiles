NOTICE: My configuration for AwesomeWM only works on the latest git master branch. On Arch based distros, all you would have to do is install `awesome-git` from the AUR. On others, you will have to build it manually.


## Previews

<p align="center">
<img src="https://github.com/JavaCafe01/awesome-config/blob/master/images/rice.png" alt="img" align="center" width="800px">
</p>



## Setup
This repository has submodules, so make sure you clone it correctly:
```bash
git clone --recurse-submodules https://github.com/JavaCafe01/awesome-config.git ~/.config/awesome
```

## Modules
### :star: [bling](https://github.com/Nooo37/bling) :star:
Bling brings extra utilities to AwesomeWM such as tabs, swallowing, layouts, and flash focus. Please check it out and give it a star!

### [layout-machi](https://github.com/xinhaoyuan/layout-machi)
This module is a powerful manual layout that contains an amazing editor to change and make layouts and window locations. Its for powerusers and gives full control of the layout. Give it a star!

## System Info
+ **OS**: Endeavour
+ **Terminal**: alacritty
+ **Browser**: Firefox
    + [firefox-css](https://github.com/JavaCafe01/firefox-css)
+ **Music**: Ncspot
+ **GTK Theme**: [Phocus](https://github.com/JavaCafe01/phocus)
+ **File Manager**: Thunar
+ **Color Scheme**: [javacafe](https://github.com/JavaCafe01/javacafe.vim)
+ **Dotfiles**: [my neovim, terminal, and other stuff](https://github.com/JavaCafe01/dotfiles)

## Common Questions

### Where did I steal `ears` from?
It was taken from [elenapan](https://github.com/elenapan/dotfiles).

### How to get anti-aliased rounded corners?
To start off, I do not round any corners with picom or any other fork. I round with AwesomeWM. If you round a widget and lay that ontop of another widget, the corners or anti-aliased (AA). Using this fact, all my panels and notifications are rounded widgets which contain a bottom transparent layer. For the clients, you do the same thing but with titlebars. 

But how did I get shadows? Usually, when you add shadows, it shadows the transparent widget as well, like this: 

<img src="https://github.com/JavaCafe01/awesome-config/blob/master/images/round_transparent.png" alt="img">

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

<img src="https://github.com/JavaCafe01/awesome-config/blob/master/images/round_shadow.png" alt="img">

Currently I don't have shadows, but I can easily just enable it in picom and still retain my AA corners.
