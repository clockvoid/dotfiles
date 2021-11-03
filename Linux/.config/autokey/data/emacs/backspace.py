# Enter script code
winClass = window.get_active_class()
if winClass != "Alacritty.Alacritty":
    keyboard.send_key("<backspace>")
else:
    keyboard.send_keys("<ctrl>+h")