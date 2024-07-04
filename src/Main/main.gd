extends Node


var word_to_guess := ""


var attempts: Array[String] = []
var current_letters: Array[String] = []
var score := 0

@onready var message := %WordPanel/Message as Label
@onready var keyboard := %Keyboard as Keyboard
@onready var word_panel := %WordPanel as WordPanel


func _on_storage_get_completed(success, data):
	if not success:
		return
		
	if data[3] != null:
		score = data[3]
	
	if data[0] == null or data[0].is_empty():
		return
	word_to_guess = data[0]
		
	if data[1] != null:
		attempts = data[1]
		
	if data[2] != null:
		current_letters = data[2]
		
func _reset_state():
	Bridge.storage.delete(["word", "attempts", "current_letters"])
	
func _load_state():
	Bridge.storage.get(["word", "attempts", "current_letters", "score"], _on_storage_get_completed)
	
# could be one function _save_state but not efficient (?)
func _save_word():
	print(word_to_guess)
	Bridge.storage.set("word", word_to_guess)

func _save_current_letters():
	Bridge.storage.set("current_letters", current_letters)
	
func _save_attempts():
	Bridge.storage.set("attempts", attempts)
	
func _save_score():
	Bridge.storage.set("attempts", score)
	
	
func _ready():
	Bridge.advertisement.set_minimum_delay_between_interstitial(30)
	randomize()
	_reset_state()
	_load_state()
	
	if word_to_guess == null or word_to_guess.is_empty():
		word_to_guess = word_list.get_new_word()
		_save_word()
	
func get_score(attempts_taken):
	return globals.NUMBER_OF_ATTEMPTS - attempts_taken

func _input(event: InputEvent):
	var key_event := event as InputEventKey
	if not key_event or not key_event.pressed:
		return
		
	if key_event.unicode != 0:
		var letter := char(key_event.unicode).to_upper()
		if current_letters.size() < globals.NUMBER_OF_LETTERS:
			current_letters.append(letter)
			word_panel.update_letter_panel(letter, attempts.size(), current_letters.size())
	elif key_event.keycode == KEY_BACKSPACE:
		word_panel.update_letter_panel("",  attempts.size(), current_letters.size())
		current_letters.pop_back()
	elif key_event.keycode == KEY_ENTER:
		if current_letters.size() < globals.NUMBER_OF_LETTERS:
			message.text = "Type %d letters" % globals.NUMBER_OF_LETTERS
			return
		var word_attempt = "".join(current_letters).to_lower()
		var success := update_board_word(word_attempt, attempts.size())
		
		if success == 0:
			message.text = "Not in dictionary"
			return
			
		if success == 1:
			message.text = "You Win!"
			set_process_input(false)
			return
		
		attempts.push_back(word_attempt)
		if attempts.size() > globals.NUMBER_OF_ATTEMPTS:
			message.text = "The word was: " + word_to_guess
			Bridge.advertisement.show_rewarded()
			set_process_input(false)
			return
		current_letters = []
		message.text = ""
		print(current_letters, attempts)

func update_board_word(word_attempt: String, current_attempt: int) -> int:
	var attempt_result := check_word(word_attempt, word_to_guess)
	
	if attempt_result[0] == globals.LetterState.NOT_CHECKED:
		return 0
	
	for i in range(globals.NUMBER_OF_LETTERS):
		word_panel.update_color_panel(attempt_result[i], current_attempt, i + 1)
		keyboard.change_letter_key_color(current_letters[i], attempt_result[i])
		
	if word_attempt == word_to_guess:
		return 1
	return -1
	

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


