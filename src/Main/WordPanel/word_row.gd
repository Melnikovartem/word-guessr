extends HBoxContainer

var letter_scene = preload("res://WordPanel/one_letter.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in range(globals.NUMBER_OF_LETTERS):
		var letter = letter_scene.instantiate()
		letter.name = "Letter" + str(i)
		add_child(letter)
