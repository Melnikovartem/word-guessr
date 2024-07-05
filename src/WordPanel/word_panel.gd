class_name WordPanel
extends CanvasLayer

var word_row_scene = preload("res://WordPanel/word_row.tscn")

var word_rows: Array[HBoxContainer] = []

func _ready():
	for i in range(globals.NUMBER_OF_ATTEMPTS):
		var word_row = word_row_scene.instantiate()
		word_rows.append(word_row)
		%WordRows.add_child(word_row)

func flush_panel():
	for i in range(globals.NUMBER_OF_ATTEMPTS):
		for j in range(globals.NUMBER_OF_LETTERS):
			update_letter_panel("", i, j)
			update_color_panel(globals.LetterState.NOT_CHECKED, i, j)
			
func update_letter_panel(letter: String, attempt_number: int, letter_number: int) -> void:
	var label := word_rows[attempt_number].get_node("Letter" + str(letter_number) + "/Letter") as Label
	assert(label)
	label.text = letter

func update_color_panel(check_letter: globals.LetterState, attempt_number: int, letter_number: int) -> void:
	var panel := word_rows[attempt_number].get_node("Letter" + str(letter_number)) as ColorRect
	assert(panel)
	match check_letter:
		globals.LetterState.NOT_IN_WORD:
			panel.color = Color.INDIAN_RED
		globals.LetterState.WRONG_PLACE:
			panel.color = Color.YELLOW
		globals.LetterState.CORRECT:
			panel.color = Color.YELLOW_GREEN
		globals.LetterState.NOT_CHECKED:
			panel.color = Color.WHITE
