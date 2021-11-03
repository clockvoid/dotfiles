# Enter script code
winClass = window.get_active_class()
if winClass != "Alacritty.Alacritty":
    keyboard.send_key("<up>")
else:
    keyboard.send_keys("<ctrl>+p")