# letter.gd
extends Panel

func set_letter(letter):
	$Label.text = letter

func set_state(state):
	match state:
		"correct":
			self_modulate = Color.GREEN
		"wrong_position":
			self_modulate = Color.YELLOW
		"incorrect":
			self_modulate = Color.DARK_GRAY
