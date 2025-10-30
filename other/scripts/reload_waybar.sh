# Quick script to restart waybar
find_waybar=${ ps aux | grep "waybar" ; }

if [[ ! -z $find_waybar ]]; then
    pkill waybar
fi

waybar &
