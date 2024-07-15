extends TextureRect

var a = preload("res://Assets/Backgrounds/Dawn_Background.png")
var b = preload("res://Assets/ButtonTextures/Options_button.png")

func change_BG():
	texture = a
	%Help_Button.get_child(0).texture = b
