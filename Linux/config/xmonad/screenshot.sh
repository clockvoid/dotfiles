#!/bin/sh

screenshot_path="${HOME}/Pictures/screenshot"

shot_focused_window () {
  maim -u -i $(xdotool getwindowfocus) | magick - \( +clone -background black -shadow 60x30+0+10 \) +swap -background none -layers merge +repage $screenshot_path/Screenshot_at_$(date +%Y-%m-%d-%H-%M-%S).png
}

shot_focused_window_to_clipboard () {
  maim -u -i $(xdotool getwindowfocus) | magick - \( +clone -background black -shadow 60x30+0+10 \) +swap -background none -layers merge +repage /tmp/screenshot_tmp.png
  xclip -selection clipboard -t image/png < /tmp/screenshot_tmp.png
  rm /tmp/screenshot_tmp.png
}

case $1 in
  "clipboard")
    maim -u | xclip -selection clipboard -t image/png
    ;;
  "selectedareaclipboard")
    maim -s -u | xclip -selection clipboard -t image/png
    ;;
  "focusedwindowclipboard")
    shot_focused_window_to_clipboard
    ;;
  "selectedarea")
    maim -s -u $screenshot_path/Screenshot_at_$(date +%Y-%m-%d-%H-%M-%S).png
    ;;
  "focusedwindow")
    shot_focused_window
    ;;
  *)
    maim -u $screenshot_path/Screenshot_at_$(date +%Y-%m-%d-%H-%M-%S).png
    ;;
esac
