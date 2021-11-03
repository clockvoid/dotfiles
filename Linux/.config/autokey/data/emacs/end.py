# Enter script code
winClass = window.get_active_class()
if winClass != "Alacritty.Alacritty":
    keyboard.send_key("<end>")
else:
    keyboard.send_keys("<ctrl>+e")