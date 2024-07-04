extends Node


var word_to_guess := ""
var word_attempt := ""

var current_attempt := 1
var current_letter := 1

@onready var message := %WordPanel/Message as Label
@onready var keyboard := %Keyboard as Keyboard
@onready var word_panel := %WordPanel as WordPanel


func _ready():
	randomize()
	word_to_guess = word_list.get_new_word()

func _input(event: InputEvent):
	var key_event := event as InputEventKey
	if key_event and key_event.pressed:
		if key_event.unicode != 0:
			var letter := char(key_event.unicode).to_upper()
			if current_letter <= globals.NUMBER_OF_LETTERS:
				word_attempt += letter
				word_panel.update_letter_panel(letter, current_attempt, current_letter)
				current_letter += 1
		elif key_event.keycode == KEY_BACKSPACE:
			if current_letter > 1:
				current_letter -= 1
			word_attempt = word_attempt.left(current_letter - 1)
			word_panel.update_letter_panel("", current_attempt, current_letter)
		elif key_event.keycode == KEY_ENTER:
			if word_attempt.length() < globals.NUMBER_OF_LETTERS:
				message.text = "Type %d letters" % globals.NUMBER_OF_LETTERS
				return
			word_attempt = word_attempt.to_lower()
			var attempt_result := check_word(word_attempt, word_to_guess)
			if attempt_result[0] == globals.LetterState.NOT_CHECKED:
				message.text = "Not in dictionary"
				print(word_to_guess)
				return
			for i in range(globals.NUMBER_OF_LETTERS):
				word_panel.update_color_panel(attempt_result[i], current_attempt, i + 1)
				keyboard.change_letter_key_color(word_attempt[i], attempt_result[i])
			if word_attempt == word_to_guess:
				message.text = "You Win!"
				set_process_input(false)
				return
			current_attempt += 1
			if current_attempt > globals.NUMBER_OF_ROWS + 1:
				message.text = "The word was: " + word_to_guess
				set_process_input(false)
				return
			current_letter = 1
			word_attempt = ""
			message.text = ""


func check_word(word: String, correct_word: String) -> Array[globals.LetterState]:
	var result: Array[globals.LetterState] = [
		globals.LetterState.NOT_CHECKED,
		globals.LetterState.NOT_CHECKED,
		globals.LetterState.NOT_CHECKED,
		globals.LetterState.NOT_CHECKED,
		globals.LetterState.NOT_CHECKED,
	]
	var correct_letter_count := {}

	if not (word in word_list.DICTIONARY) and not (word in word_list.WORDS):
		return result

	for letter in correct_word:
		correct_letter_count[letter] = correct_letter_count.get(letter, 0) + 1

	for i in range(globals.NUMBER_OF_LETTERS):
		if word[i] == correct_word[i]:
			result[i] = globals.LetterState.CORRECT
			correct_letter_count[word[i]] -= 1

	for i in range(globals.NUMBER_OF_LETTERS):
		if result[i] == globals.LetterState.CORRECT:
			continue
		elif word[i] in correct_word and correct_letter_count.get(word[i], 0) > 0:
			result[i] = globals.LetterState.WRONG_PLACE
			correct_letter_count[word[i]] -= 1
		else:
			result[i] = globals.LetterState.NOT_IN_WORD

	return result


