extends TextureRect


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

var a = preload("res://Assets/Backgrounds/Dawn_Background.png")
var b = preload("res://Assets/ButtonTextures/Options_button.png")

func change_BG():
	texture = a
	%Help_Button.get_child(0).texture = b


