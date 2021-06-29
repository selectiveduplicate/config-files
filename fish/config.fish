# workaround so that rofi can read from $XDG_DATA_DIRS to find
# flatpak apps (and others that depend on this variable).
# see this for more info: https://github.com/fish-shell/fish-shell/issues/7485#issuecomment-728984689

set -l xdg_data_home $XDG_DATA_HOME ~/.local/share
set -gx --path XDG_DATA_DIRS $xdg_data_home[1]/flatpak/exports/share:/var/lib/flatpak/exports/share:/usr/local/share:/usr/share

# disable intro message
set -g fish_greeting

for flatpakdir in ~/.local/share/flatpak/exports/bin /var/lib/flatpak/exports/bin
    if test -d $flatpakdir
        contains $flatpakdir $PATH; or set -a PATH $flatpakdir
    end
end
