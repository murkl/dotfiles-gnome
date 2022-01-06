#!/bin/bash

VERSION="3"

# ////////////////////////////////////////////
# INIT
# ////////////////////////////////////////////

init() {

    # Install Packages
    update

    # Set Init Configuration

    # SET THEMING
    gsettings set org.gnome.Terminal.Legacy.Settings theme-variant 'dark'
    gsettings set org.gnome.desktop.interface icon-theme 'ecos'
    gsettings set org.gnome.desktop.interface gtk-theme 'WhiteSur-light-solid'
    gsettings set org.gnome.shell.extensions.user-theme name 'WhiteSur-light'
    gsettings set org.gnome.desktop.interface cursor-theme 'Qogir'

    # WALLPAPER
    gsettings set org.gnome.desktop.background picture-uri 'file://'$HOME'/.local/share/wallpaper'

    # GNOME TERMINAL
    local terminal_profile=$(gsettings get org.gnome.Terminal.ProfilesList default | tr -d "'")
    gsettings set org.gnome.Terminal.Legacy.Settings theme-variant 'dark'
    gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$terminal_profile/ visible-name 'ECOS'
    gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$terminal_profile/ scrollbar-policy 'never'
    gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$terminal_profile/ scrollbar-policy 'never'
    gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$terminal_profile/ scroll-on-output true
    gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$terminal_profile/ palette "['rgb(23,20,33)', 'rgb(192,28,40)', 'rgb(38,162,105)', 'rgb(162,115,76)', 'rgb(18,72,139)', 'rgb(163,71,186)', 'rgb(42,161,179)', 'rgb(208,207,204)', 'rgb(94,92,100)', 'rgb(246,97,81)', 'rgb(51,209,122)', 'rgb(233,173,12)', 'rgb(42,123,222)', 'rgb(192,97,203)', 'rgb(51,199,222)', 'rgb(255,255,255)']"
    gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$terminal_profile/ default-size-columns 200
    gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$terminal_profile/ default-size-rows 45
}

# ///////////////////////////////////////////
# UPDATE
# ///////////////////////////////////////////

update() {

    exec_paru() {
        paru --noconfirm --needed --sudoloop -S $1
    }

    # ////////////////////////////////////////////
    # UPDATE PACKAGES
    # ////////////////////////////////////////////

    paru -Syyu

    # ////////////////////////////////////////////
    # INSTALL PACKAGES
    # ////////////////////////////////////////////

    # Gnome Minimal -  https://archlinux.org/groups/x86_64/gnome/
    exec_paru "gdm gnome-shell gnome-control-center gnome-terminal nautilus xdg-user-dirs"

    # Nautilus Addons
    exec_paru "python-nautilus sushi nautilus-sendto nautilus-image-converter"

    # Gnome Shell Extensions
    exec_paru "chrome-gnome-shell-git"
    exec_paru "gnome-shell-extensions"
    # exec_paru "gnome-shell-extension-x11gestures"

    # ZSH Addons
    exec_paru "zsh-autosuggestions zsh-syntax-highlighting"

    # System Tools
    exec_paru "xorg-xrandr"
    exec_paru "gnome-keyring seahorse"
    exec_paru "baobab"
    exec_paru "reflector"
    exec_paru "evince eog gthumb gedit totem"
    exec_paru "neofetch htop"
    exec_paru "pacman-contrib man-db"
    exec_paru "hunspell hunspell-en_us hunspell-de"
    exec_paru "samba"
    exec_paru "sshpass"
    exec_paru "gvfs gvfs-mtp gvfs-smb gvfs-nfs"
    exec_paru "gnome-user-share nfs-utils inetutils"
    exec_paru "wireless_tools wmctrl xdotool"
    exec_paru "zenity ffmpeg youtube-dl rsync curl"
    exec_paru "pavucontrol"
    exec_paru "cups"

    # GNOME Apps
    exec_paru "gnome-calculator"
    exec_paru "gnome-screenshot"
    exec_paru "gnome-backgrounds"
    exec_paru "gnome-tweak-tool"
    exec_paru "gnome-logs"
    exec_paru "gnome-calendar"
    exec_paru "gnome-weather"
    exec_paru "gnome-boxes"
    exec_paru "gnome-connections"
    exec_paru "gnome-disk-utility"
    exec_paru "gnome-usage"

    # Codecs
    exec_paru "gst-libav"

    # Fonts
    exec_paru "ttf-dejavu"
    exec_paru "ttf-liberation"
    exec_paru "noto-fonts-emoji"
    exec_paru "lib32-fontconfig"

    # Icons
    exec_paru "qogir-icon-theme-git"

    # Archive Manager
    exec_paru "file-roller zip unzip unrar"

    # Mouse Gestures
    #exec_paru "touche touchegg"

    # Apps
    exec_paru "firefox firefox-i18n-de firefox-i18n-en-us"
    exec_paru "rhythmbox-plugin-alternative-toolbar-git"
    exec_paru "geary"
    exec_paru "keepassxc"
    exec_paru "cava"
    exec_paru "xpad"

    # LibreOffice
    exec_paru "libreoffice-still libreoffice-still-de"

    # Vim
    exec_paru "vim"

    # VSCodium
    exec_paru "vscodium-bin vscodium-bin-marketplace"

    # Wine & Dependencies
    exec_paru "wine-staging winetricks lutris lutris-wine-meta"

    # ////////////////////////////////////////////
    # CONFIGURATION: GDM
    # ////////////////////////////////////////////

    # GNOME DISPLAY MANAGER
    local gdm_config_file="/etc/gdm/custom.conf"

    # GNOME: Enable X11 instead of Wayland (CHANGE: GNOME AUTO LOGIN BELOW !!!)
    #sudo sed -i "s/^#WaylandEnable=false/WaylandEnable=false/g" "$gdm_config_file"

    # GNOME AUTO LOGIN
    if ! grep -qrnw "$gdm_config_file" -e "AutomaticLoginEnable=True"; then
        sudo sed -i "s/^#WaylandEnable=false/#WaylandEnable=false\n\nAutomaticLoginEnable=True\nAutomaticLogin=$USER/g" "$gdm_config_file"
    fi

    # ///////////////////////////////////////////
    # CONFIGURATION: GnuPG
    # ///////////////////////////////////////////

    mkdir -p "$HOME/.local/share/gnupg"
    echo 'pinentry-program /usr/bin/pinentry-gnome3' >"$HOME/.local/share/gnupg/gpg-agent.conf"
    # Set correct gnupg permission
    chmod -R go-rwx "$HOME/.local/share/gnupg"
    echo -e "DONE"

    # ///////////////////////////////////////////
    # CONFIGURATION: SAMBA
    # ///////////////////////////////////////////

    if [ ! -f "/etc/samba/smb.conf" ]; then
        {
            echo "[global]"
            echo "   workgroup = WORKGROUP"
            echo "   log file = /var/log/samba/%m"
        } >"/tmp/smb.conf"
        sudo mv "/tmp/smb.conf" "/etc/samba/smb.conf"
    fi

    # ///////////////////////////////////////////
    # CONFIGURATION: TLP
    # ///////////////////////////////////////////

    if [ -f "/etc/tlp.conf" ]; then
        sudo sed -i "s/^#CPU_BOOST_ON_AC=1/CPU_BOOST_ON_AC=0/g" "/etc/tlp.conf"
        sudo sed -i "s/^#CPU_BOOST_ON_BAT=0/CPU_BOOST_ON_BAT=0/g" "/etc/tlp.conf"
    fi

    # ///////////////////////////////////////////
    # SERVICES
    # ///////////////////////////////////////////

    sudo systemctl enable gdm.service
    sudo systemctl enable smb.service
    sudo systemctl enable nmb.service
    sudo systemctl enable avahi-daemon
    sudo systemctl enable bluetooth.service
    sudo systemctl enable cups.service
    #sudo systemctl enable touchegg.service

    # ///////////////////////////////////////////
    # ECOS TWEAKS
    # ///////////////////////////////////////////

    $ECOS_CORE --tweak install theme-whitesur
    $ECOS_CORE --tweak install gnome-extension-arch_update_indicator
    $ECOS_CORE --tweak install gnome-extension-dash_to_dock
    $ECOS_CORE --tweak install gnome-extension-just_perfection
    $ECOS_CORE --tweak install gnome-extension-tray_icons_reloaded
    $ECOS_CORE --tweak install gnome-extension-blur_my_shell
    $ECOS_CORE --tweak install app-horst
    $ECOS_CORE --tweak install app-time_machine
    $ECOS_CORE --tweak install app-persist
    $ECOS_CORE --tweak install app-ecowave

    # ///////////////////////////////////////////
    # GSETTINGS
    # ///////////////////////////////////////////

    # SET GNOME SETTINGS
    gsettings set org.gnome.desktop.wm.preferences button-layout 'close,minimize,maximize:appmenu'
    gsettings set org.gnome.mutter center-new-windows true

    # GNOME KEYBINDINGS
    gsettings set org.gnome.desktop.wm.keybindings close "['<Super>q']"
    gsettings set org.gnome.desktop.wm.keybindings minimize "['<Super>h']"
    gsettings set org.gnome.desktop.wm.keybindings show-desktop "['<Super>d']"
    gsettings set org.gnome.desktop.wm.keybindings switch-input-source "[]"
    gsettings set org.gnome.desktop.wm.keybindings switch-input-source-backward "[]"
    gsettings set org.gnome.desktop.wm.keybindings toggle-fullscreen "['<Super>F11']"

    # Custom Bindings
    # https://askubuntu.com/questions/597395/how-to-set-custom-keyboard-shortcuts-from-terminal
    gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings "['/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/', '/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/', '/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2/', '/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom3/']"

    gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ name 'Terminal'
    gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ command 'toggle --app gnome-terminal Gnome-terminal'
    gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ binding '<Super>Return'

    gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/ name 'Firefox'
    gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/ command 'toggle --app firefox Firefox'
    gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/ binding '<Super>b'

    gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2/ name 'Nautilus'
    gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2/ command 'toggle --app nautilus Org.gnome.Nautilus'
    gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2/ binding '<Super>e'

    gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom3/ name 'KeePass'
    gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom3/ command 'toggle --app keepassxc KeePassXC'
    gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom3/ binding '<Super>k'

    # ///////////////////////////////////////////
    # GNOME EXTENSIONS
    # ///////////////////////////////////////////

    # GNOME EXTENSIONS
    gsettings set org.gnome.shell disable-user-extensions false
    gnome-extensions enable "user-theme@gnome-shell-extensions.gcampax.github.com"
    gnome-extensions enable "auto-move-windows@gnome-shell-extensions.gcampax.github.com"
    gnome-extensions enable "windowsNavigator@gnome-shell-extensions.gcampax.github.com"
    # gnome-extensions enable "x11gestures@joseexposito.github.io"
    # gnome-extensions enable "drive-menu@gnome-shell-extensions.gcampax.github.com"s

    # ///////////////////////////////////////////
    # DIRECTORY ICONS
    # ///////////////////////////////////////////

    mkdir -p "$HOME/Projekte"
    gio set -t 'string' "$HOME/Projekte" 'metadata::custom-icon-name' 'folder-favorites'

    # ///////////////////////////////////////////
    # TERMINAL PADDING
    # ///////////////////////////////////////////

    mkdir -p "$HOME/.config/gtk-3.0"
    echo 'VteTerminal,
TerminalScreen,
vte-terminal {
    padding: 24px 32px 32px 32px;
    -VteTerminal-inner-border: 12px 12px 12px 12px;
}' >"$HOME/.config/gtk-3.0/gtk.css"

    # ///////////////////////////////////////////
    # CLEAR PACMAN
    # ///////////////////////////////////////////

    sudo pacman --noconfirm -Rs $(pacman -Qtdq)
}

# ///////////////////////////////////////////
# REMOVE
# ///////////////////////////////////////////

remove() {
    sudo systemctl disable gdm.service
}

# ////////////////////////////////////////////
# START
# ////////////////////////////////////////////

if [ "$1" = "--version" ]; then
    echo -e "$VERSION"
    exit $?
fi

if [ "$1" = "--init" ]; then
    init "$2"
    exit $?
fi

if [ "$1" = "--update" ]; then
    update "$2"
    exit $?
fi

if [ "$1" = "--remove" ]; then
    remove "$2"
    exit $?
fi

# ////////////////////////////////////////////
# HELP
# ////////////////////////////////////////////

echo "USE WITH PARAMETERS"
echo "--version"
echo "--init"
echo "--update"
echo "--remove"
