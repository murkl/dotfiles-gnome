#!/bin/bash
ECOS_CORE="$HOME/.ecos/.system/repo/ecos"
VERSION="3"

# ////////////////////////////////////////////
# INIT
# ////////////////////////////////////////////

init() {

    # INSTALL PACKAGES
    update

    # CONFIG: SET THEMING
    gsettings set org.gnome.Terminal.Legacy.Settings theme-variant 'dark'
    gsettings set org.gnome.desktop.interface icon-theme 'ECOS'
    gsettings set org.gnome.desktop.interface gtk-theme 'ECOS-light-solid'
    gsettings set org.gnome.shell.extensions.user-theme name 'ECOS-light'
    gsettings set org.gnome.desktop.interface cursor-theme 'Qogir'

    # CONFIG: WALLPAPER
    gsettings set org.gnome.desktop.background picture-uri 'file://'$HOME'/.local/share/wallpaper'

    # CONFIG: GNOME TERMINAL
    local terminal_profile=$(gsettings get org.gnome.Terminal.ProfilesList default | tr -d "'")
    gsettings set org.gnome.Terminal.Legacy.Settings theme-variant 'dark'
    gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$terminal_profile/ visible-name 'ECOS'
    gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$terminal_profile/ scrollbar-policy 'never'
    gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$terminal_profile/ scroll-on-output false
    gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$terminal_profile/ palette "['rgb(23,20,33)', 'rgb(192,28,40)', 'rgb(38,162,105)', 'rgb(162,115,76)', 'rgb(18,72,139)', 'rgb(163,71,186)', 'rgb(42,161,179)', 'rgb(208,207,204)', 'rgb(94,92,100)', 'rgb(246,97,81)', 'rgb(51,209,122)', 'rgb(233,173,12)', 'rgb(42,123,222)', 'rgb(192,97,203)', 'rgb(51,199,222)', 'rgb(255,255,255)']"
    gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$terminal_profile/ default-size-columns 168
    gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$terminal_profile/ default-size-rows 32
    gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$terminal_profile/ scroll-on-keystroke true

    # NAUTILUS
    gsettings set org.gtk.Settings.FileChooser sort-directories-first true
    gsettings set org.gnome.nautilus.icon-view default-zoom-level 'standard'
    gsettings set org.gnome.nautilus.window-state initial-size "(1400, 700)"
    gsettings set org.gnome.nautilus.window-state sidebar-width 280

    # DEFAULT APP LIST
    gsettings set org.gnome.shell favorite-apps "['org.gnome.Terminal.desktop', 'org.gnome.Nautilus.desktop', 'firefox.desktop', 'org.keepassxc.KeePassXC.desktop', 'org.gnome.Geary.desktop', 'org.gnome.Calendar.desktop', 'xpad.desktop', 'persist.desktop', 'libreoffice-startcenter.desktop', 'codium.desktop', 'ecos-seperator-games.desktop', 'net.lutris.Lutris.desktop', 'ecos-seperator-system.desktop', 'time-machine.desktop', 'horst.desktop', 'ecos.desktop', 'gnome-control-center.desktop']"

}

# ///////////////////////////////////////////
# UPDATE
# ///////////////////////////////////////////

update() {

    exec_paru() {
        paru --noconfirm --needed --sudoloop -S $1
    }

    exec_paru_conflict() {
        yes | LC_ALL=en_US.UTF-8 paru --sudoloop --needed --skipreview --useask -S $1
    }

    # ////////////////////////////////////////////
    # UPDATE PACKAGES
    # ////////////////////////////////////////////
    paru -Syu --noconfirm archlinux-keyring
    paru -Syyu

    # ////////////////////////////////////////////
    # INSTALL PACKAGES
    # ////////////////////////////////////////////

    # Gnome Minimal -  https://archlinux.org/groups/x86_64/gnome/
    # Mutter Rounded Corners (open settings: mutter_settings)
    # exec_paru "mutter-rounded" # Install first to prevent conflict with original mutter
    exec_paru "gdm gnome-shell gnome-control-center gnome-terminal nautilus xdg-user-dirs"
    exec_paru_conflict "mutter-rounded"

    # Nautilus Addons
    exec_paru "python-nautilus sushi nautilus-sendto nautilus-image-converter"

    # Gnome Shell Extensions
    exec_paru "chrome-gnome-shell-git"
    exec_paru "gnome-shell-extensions"

    # X11 Mouse Gestures
    # exec_paru "touche touchegg gnome-shell-extension-x11gestures"

    # ZSH Addons
    exec_paru "zsh-autosuggestions zsh-syntax-highlighting"

    # System Tools
    exec_paru "linux-headers"
    exec_paru "xorg-xrandr"
    exec_paru "xorg-xkill"
    exec_paru "iw wireless_tools"
    exec_paru "gnome-keyring seahorse"
    exec_paru "baobab"
    exec_paru "reflector"
    exec_paru "evince eog gthumb gedit totem"
    exec_paru "neofetch htop gotop-bin"
    exec_paru "pacman-contrib man-db"
    exec_paru "hunspell hunspell-en_us hunspell-de"
    exec_paru "samba"
    exec_paru "sshpass"
    exec_paru "gvfs gvfs-mtp gvfs-smb gvfs-nfs gvfs-afc gvfs-goa gvfs-gphoto2 gvfs-google"
    exec_paru "gnome-user-share nfs-utils inetutils"
    exec_paru "wmctrl xdotool"
    exec_paru "zenity ffmpeg youtube-dl rsync curl wget jq"
    exec_paru "pavucontrol"
    exec_paru "cups"
    exec_paru "xdg-user-dirs-gtk"

    # GNOME Apps
    exec_paru "gnome-calculator"
    exec_paru "gnome-screenshot"
    exec_paru "gnome-backgrounds"
    exec_paru "gnome-tweak-tool"
    exec_paru "gnome-logs"
    exec_paru "gnome-calendar evolution"
    exec_paru "gnome-weather"
    exec_paru "gnome-boxes"
    exec_paru "gnome-connections"
    exec_paru "gnome-disk-utility"
    exec_paru "gnome-usage"
    exec_paru "simple-scan"

    # GNOME TRACKER
    exec_paru "tracker"
    exec_paru "tracker3-miners"
    exec_paru "tracker-miners"

    # Codecs
    exec_paru "rygel"
    exec_paru "gnome-video-effects"
    exec_paru "grilo-plugins gst-libav"

    # Libraries
    exec_paru "sdl_image lib32-sdl_image"

    # Fonts
    exec_paru "ttf-dejavu"
    exec_paru "ttf-liberation"
    exec_paru "noto-fonts-emoji"
    exec_paru "lib32-fontconfig"

    # Icons
    exec_paru "qogir-icon-theme-git"

    # Archive Manager
    exec_paru "file-roller zip unzip unrar"

    # Apps
    exec_paru "firefox firefox-i18n-de firefox-i18n-en-us"
    exec_paru "rhythmbox-plugin-alternative-toolbar-git"
    exec_paru "geary"
    exec_paru "keepassxc"
    exec_paru "cava"
    exec_paru "xpad"

    # LibreOffice
    exec_paru "libreoffice-still libreoffice-still-de"

    # Terminal Editor
    exec_paru "vim nano"

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
    sudo systemctl disable getty@tty1
    sudo rm -rf "/etc/systemd/system/getty@tty1.service.d/"
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

    # if [ -f "/etc/tlp.conf" ]; then
    #     sudo sed -i "s/^#CPU_BOOST_ON_AC=1/CPU_BOOST_ON_AC=0/g" "/etc/tlp.conf"
    #     sudo sed -i "s/^#CPU_BOOST_ON_BAT=0/CPU_BOOST_ON_BAT=0/g" "/etc/tlp.conf"
    # fi

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

    $ECOS_CORE --tweak install plymouth
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
    # GSETTINGS / DCONF
    # ///////////////////////////////////////////

    # SET GNOME MUTTER SETTINGS
    gsettings set org.gnome.mutter center-new-windows true
    gsettings set org.gnome.mutter round-corners-radius 16
    gsettings set org.gnome.mutter clip-edge-padding '{"global":[1,1,2,1],"apps":{}}'

    # DISABLE MOUSE ACCELATION
    gsettings set org.gnome.desktop.peripherals.mouse speed 0.0
    gsettings set org.gnome.desktop.peripherals.mouse accel-profile 'flat'

    # SET GNOME SETTINGS
    gsettings set org.gnome.desktop.wm.preferences button-layout 'close,minimize,maximize:appmenu'

    # GNOME KEYBINDINGS
    gsettings set org.gnome.desktop.wm.keybindings close "['<Super>q']"
    gsettings set org.gnome.desktop.wm.keybindings minimize "['<Super>h']"
    gsettings set org.gnome.desktop.wm.keybindings show-desktop "['<Super>d']"
    gsettings set org.gnome.desktop.wm.keybindings switch-input-source "[]"
    gsettings set org.gnome.desktop.wm.keybindings switch-input-source-backward "[]"
    gsettings set org.gnome.desktop.wm.keybindings toggle-fullscreen "['<Super>F11']"

    # CUSTOM KEYBINDINGS - https://askubuntu.com/questions/597395/how-to-set-custom-keyboard-shortcuts-from-terminal
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

    #     mkdir -p "$HOME/.config/gtk-3.0"
    #     echo 'VteTerminal,
    # TerminalScreen,
    # vte-terminal {
    #     padding: 24px 32px 32px 32px;
    #     -VteTerminal-inner-border: 12px 12px 12px 12px;
    # }' >"$HOME/.config/gtk-3.0/gtk.css"

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
