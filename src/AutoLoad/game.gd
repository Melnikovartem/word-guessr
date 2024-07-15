var word_to_guess := ""


var attempts: Array[String] = []
var current_letters: Array[String] = []
var score := 0

func reset_game():
	word_to_guess = word_list.get_new_word()
	attempts = []
	current_letters = []
	
	keyboard.flush_keyboard()
	word_panel.flush_panel()
	
	message.text = "WORDS BITE"
	
	keyboard.visible = true
	new_game_ui.visible = false
	
	_save_word()
	_save_attempts()
	_save_current_letters()
		
func end_game(win: bool = false):
	if win:
		score += globals.NUMBER_OF_ATTEMPTS - attempts.size() + 1
		_save_score()
	else:
		Bridge.advertisement.show_rewarded()
	keyboard.visible = false
	new_game_ui.visible = true
	new_game_ui.get_child(0).text = "Your overall score\n%d" % score
	
	
func _set_board():
	for i in range(attempts.size()):
		for j in range(attempts[i].length()):
			word_panel.update_letter_panel(attempts[i][j].to_upper(), i, j)
		update_board_word(attempts[i], i)
	for i in range(current_letters.size()):
		word_panel.update_letter_panel(current_letters[i], attempts.size(), i)
		
func _preload_attempts(data: String) -> Error:
	var json = JSON.new()
	var error = json.parse(data)
	if error != OK:
		return FAILED
	if json.data.size() >= globals.NUMBER_OF_ATTEMPTS:
		return FAILED
	for word in json.data:
		if typeof(word) != TYPE_STRING:
			return FAILED
		if word.length() != globals.NUMBER_OF_LETTERS:
			return FAILED
	attempts.assign(json.data)
	return OK

func _preload_current_letters(data: String) -> Error:
	var json = JSON.new()
	var error = json.parse(data)
	if error != OK:
		return FAILED
	if json.data.size() > globals.NUMBER_OF_LETTERS:
		return FAILED
	for letter in json.data:
		if typeof(letter) != TYPE_STRING:
			return FAILED
	current_letters.assign(json.data)
	return OK

func _on_storage_get_completed(success, data):
	if not success:
		return
	if data[3] != null:
		score = int(data[3])
	if data[0] == null or data[0].is_empty():
		return
	var failed_load_attempts = data[1] == null or _preload_attempts(data[1]) != OK
	var failed_load_current_letters = data[2] == null or _preload_current_letters(data[2]) != OK
	if not failed_load_attempts and not failed_load_current_letters:
		word_to_guess = data[0]
		_set_board()
	else:
		reset_game()

func _load_state():
	Bridge.storage.get(["word", "attempts", "current_letters", "score"], _on_storage_get_completed)
	
func _reset_state():
	Bridge.storage.delete(["word", "attempts", "current_letters"])
	
func _save_word():
	print(word_to_guess)
	Bridge.storage.set("word", word_to_guess)

func _save_current_letters():
	Bridge.storage.set("current_letters", current_letters)

func _save_attempts():
	Bridge.storage.set("attempts", attempts)

func _save_score():
	Bridge.storage.set("score", score)
	
func _ready():
	Bridge.advertisement.set_minimum_delay_between_interstitial(30)
	randomize()
	_reset_state()
	_load_state()
	
	if word_to_guess == null or word_to_guess.is_empty():
		reset_game()
	
func get_score(attempts_taken):
	return globals.NUMBER_OF_ATTEMPTS - attempts_taken

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
