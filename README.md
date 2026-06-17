# dotfiles #

## Requirements ##

### Neovim ###
* **Version:** 0.11 or newer — required for the `vim.lsp.config` / `vim.lsp.enable` API
* Ubuntu and other distros often ship outdated Neovim versions via their package managers. Install directly from the [Neovim releases page](https://github.com/neovim/neovim/releases) to ensure you have a supported version.

## Software ##
These dotfiles contain configurations for both X11 and Wayland. For those new to ricing (customizing your desktop environment), a list of software dependent on each display server is provided below.

While all configurations can be installed together, if you prefer to keep your `.config` directory tidy, this list clarifies what is required for either X11 or Wayland. The universal list shows software used by both setups.

### X11 ###
* **i3** - Window Manager
* **picom** - Compositor for window effects like transparency, animations, and fading
* **polybar** - Status bar
* **rofi** - Application launcher and window switcher

### Wayland ###
* **hypr** - Window Manager (includes Hyprland lock screen configuration)
* **waybar** - Status bar
* **wofi** - Application launcher and window switcher

### Universal ###
* **ghostty** - Terminal emulator
* **kitty** - Terminal emulator
* **nvim** - Neovim text editor
* **gtk-3.0** - Theme configuration for GTK applications
* **wallpapers** - Directory for wallpapers (not a software, just a folder)
