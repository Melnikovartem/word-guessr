class_name WordPanel
extends CanvasLayer

@onready var word_rows: Array[HBoxContainer] = [
	%WordRow1 as HBoxContainer,
	%WordRow2 as HBoxContainer,
	%WordRow2 as HBoxContainer,
	%WordRow2 as HBoxContainer,
	%WordRow2 as HBoxContainer,
]

func update_letter_panel(letter: String, attempt_number: int, letter_number: int) -> void:
	var label := word_rows[attempt_number - 1].get_node("Letter" + str(letter_number) + "/Letter") as Label
	assert(label)
	label.text = letter

func update_color_panel(check_letter: int, attempt_number: int, letter_number: int) -> void:
	var panel := word_rows[attempt_number - 1].get_node("Letter" + str(letter_number)) as ColorRect
	assert(panel)
	match check_letter:
		globals.LetterState.NOT_IN_WORD:
			panel.color = Color.INDIAN_RED
		globals.LetterState.WRONG_PLACE:
			panel.color = Color.YELLOW
		globals.LetterState.CORRECT:
			panel.color = Color.YELLOW_GREEN
