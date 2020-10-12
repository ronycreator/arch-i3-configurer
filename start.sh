if [ "$EUID" -ne 0 ]
  then echo "please run the script as root. with:         sudo bash start.sh"
  exit
fi
yikes="not installed, proceeding to install..."
echo "Checking that all required packages are installed..."
rofi -v 2> /dev/null 1> /dev/null || (echo "rofi $yikes" && sudo pacman -S --noconfirm rofi 1> /dev/null)
awk -V 2> /dev/null 1> /dev/null || (echo "awk $yikes" && sudo pacman -S --noconfirm mawk 1> /dev/null)
feh -v 2> /dev/null 1> /dev/null || (echo "feh $yikes" && sudo pacman -S --noconfirm feh 1> /dev/null)
sensors -v 2> /dev/null 1> /dev/null || (echo "sensors $yikes" && sudo pacman -S --noconfirm lm-sensors 1> /dev/null)
mpstat -V 2> /dev/null 1> /dev/null || (echo "mpstat $yikes" && sudo pacman -S --noconfirm sysstat 1> /dev/null)
scrot -v 2> /dev/null 1> /dev/null || (echo "scrot $yikes" && sudo pacman -S --noconfirm scrot 1> /dev/null)
dmenu -v 2> /dev/null 1> /dev/null || (echo "dmenu $yikes" && sudo pacman -S --noconfirm dmenu 1> /dev/null)
i3blocks -V 2> /dev/null 1> /dev/null || (echo "i3blocks $yikes" && sudo pacman -S --noconfirm i3blocks 1> /dev/null)
pulseaudio --version 2> /dev/null 1> /dev/null || (echo "pulseaudio $yikes" && sudo pacman -S --noconfirm pulseaudio 1> /dev/null)

echo "Checking if yer ha'st Xorg..."
Xorg -version 2> /dev/null 1> /dev/null || (echo "Xorg $yikes" && sudo pacman -S --noconfirm xorg xorg-xinit xorg-twm xorg-xclock xterm 1> /dev/null)

echo "checking i3 or i3-gaps is installed..."
i3 -v 2> /dev/null 1> /dev/null || (echo "i3-gaps $yikes" && sudo pacman -S --noconfirm i3-gaps ttf-dejavu 1> /dev/null) 

user=$(who -m | awk '{print $1}')
echo "proceeding to create directories, copy and overwrite dotfiles"
ls /usr/share/i3blocks/ 1> /dev/null || sudo mkdir /usr/share/i3blocks
ls /home/$user/.config/i3 1> /dev/null || mkdir /home/$user/.config/i3
ls /home/$user/.config/rofi 1> /dev/null || mkdir /home/$user/.config/rofi
sudo cp -r $PWD/dotfiles/blocks/* /usr/share/i3blocks
sudo cp -r $PWD/dotfiles/i3blocks.conf /etc
cp -r $PWD/dotfiles/config /home/$user/.config/i3
cp -r $PWD/misc/HK.jpg /home/$user/.config/i3
cp -r $PWD/dotfiles/config.rasi /home/$user/.config/rofi

echo "done, proceeding to delete script and related garbage."
rm -rf $PWD
