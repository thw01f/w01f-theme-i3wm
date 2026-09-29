# w01f i3wm Theme & ROG Zephyrus G14 Optimization

This repository contains my personal i3wm dotfiles, custom scripts, and system configurations tailored to create a GNOME-like, modern aesthetic. It includes specific hardware optimizations for the ASUS ROG Zephyrus G14 (2023) running Kali Linux/Debian, including 165Hz refresh rate fixes, trackpad configurations, and deep-bass audio restoration.

## 📦 Prerequisites

Before applying these configurations, make sure you have the required packages installed on your system:bash

```bash
sudo apt update
sudo apt install i3 polybar rofi flameshot network-manager-gnome blueman easyeffects pasystray xss-lock lxappearance

```

*(Note: For the clipboard manager, you will also need to install `rofi-greenclip`)*

## 🚀 Installation Guide

Clone this repository to your home directory:
```bash
git clone git@github.com:thw01f/w01f-theme-i3wm.git ~/w01f-theme-i3wm
cd ~/w01f-theme-i3wm

```

### 1. User Configurations (Dotfiles)

These files control the look and behavior of your desktop environment. Copy them into your local user's `.config` directory:

* **i3 Window Manager:**
```bash
cp -r i3 ~/.config/

```


* **Polybar (Status Bar & System Tray):**
```bash
cp -r polybar ~/.config/

```


* **Custom Scripts (Menus, Bluetooth, Wi-Fi, Lock Screen):**
```bash
cp -r scripts ~/.config/
chmod +x ~/.config/scripts/*

```



### 2. System-Wide Configurations (Root Required)

These files fix hardware behavior like the physical power button and trackpad gestures. **Proceed with caution as these overwrite system files.**

* **Power Button Behavior (Sleep instead of Shutdown):**
Copy the `logind.conf` file to change how the system handles the power button:
```bash
sudo cp system-configs/systemd/logind.conf /etc/systemd/
sudo systemctl restart systemd-logind.service

```


* **Trackpad & Display Fixes (Natural Scrolling):**
Copy the X11 configurations:
```bash
sudo cp -r system-configs/X11/* /etc/X11/xorg.conf.d/

```



*(Note: The 165Hz display refresh rate fix is handled directly inside the `~/.config/i3/config` file using `xrandr`)*

### Bug Fixed

GA402XU Linux Audio Fix
https://github.com/thw01f/GA402XU-Linux-Audio-Fix

<s>### 3. Audio Optimization (ROG Zephyrus G14)

To restore the missing bass on the G14's Cirrus Logic amplifiers:

1. Ensure you have the `easyeffects` package installed.
2. Load the G14 EasyEffects profile (ensure your downloaded `.json` profile is placed in `~/.config/easyeffects/output/`).
3. Open terminal, run `alsamixer`, press `F6` to select the Generic audio card, and turn the **AMP** volume up to 100% (0dB).
4. Save the volume state permanently so i3 can load it on boot:
```bash
alsactl --file ~/.config/asound.state store

```
</s>


### 4. Applying the "Hackerer" GTK Theme

To make your applications (like Nautilus and Firefox) match this setup:

1. Move the `Hackerer` theme folder to your hidden themes directory:
```bash
mkdir -p ~/.themes
cp -r Hackerer ~/.themes/

```


2. Open `lxappearance` from the terminal.
3. Select the "Hackerer" theme from the list and click **Apply**.


### 5. Terminal & Fonts (Kitty)

To get the custom aesthetic, red block cursor, and perfectly integrated Kali colors for your terminal:

1. **Install the Font:**
Extract the provided `Hack.zip` into your local fonts directory and update the font cache:bash
Move the `kitty` folder into your user's `.config` directory:
```bash
mkdir -p ~/.local/share/fonts
unzip Hack.zip -d ~/.local/share/fonts/
fc-cache -fv
```



2. **Copy Kitty Configuration:**
Move the `kitty` folder into your user's `.config` directory:
```bash
cp -r kitty ~/.config/

```



### 6. Display Scaling (Xresources)

If you are using a high-resolution display (like the Zephyrus G14's 1440p or 1600p screen), default i3wm and X11 apps will look incredibly tiny.

1. Copy the `.Xresources` file to your home directory to apply a global 200% scale:
```bash
cp .Xresources ~/

```


2. Apply the scaling immediately:
```bash
xrdb -merge ~/.Xresources

```


### 7. Notifications (Dunst)

This setup uses a custom red and black hacker theme for desktop notifications, with fonts properly scaled to balance out the 200% Xresources zoom.bash

```bash
mkdir -p ~/.config/dunst
cp dunst/dunstrc ~/.config/dunst/
```

### 8. KDE Connect & Clipboard

To enable Android phone integration on i3wm and bypass the missing D-Bus service error, you must copy the provided service file before launching the indicator.

```bash
# Fix KDE Connect D-Bus error
mkdir -p ~/.local/share/dbus-1/services
cp dbus-services/org.kde.kdeconnect.service ~/.local/share/dbus-1/services/
```
# The applets will launch automatically via the provided i3 config on reboot,
# or you can start them manually:
```bash
copyq &
kdeconnect-indicator &
```
### 9. Clipboard

Rofi + CopyQ clipboard manager:  
https://github.com/thw01f/i3-copyq-rofi-clipboard

## 🔄 Finalizing

Once all files are in their correct locations, restart i3wm to apply the changes and launch Polybar:
**Shortcut:** `Super + Shift + R`

