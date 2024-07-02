extends Node2D

var word_list = ["GODOT", "ENGINE"]
var secret_word = ""
var max_attempts = 5
var current_attempt = 0
var word_length = 0

var letter_scene = preload("res://letter.tscn")

var guess_input: LineEdit
var guess_button: Button
var new_game_button: Button

var attempts_label: Label
var grid_label: Label

var grid: BoxContainer

func _ready():
	randomize()
	link_variables()
	new_game()
	
	setup_background()
	
func link_variables():
	guess_button = $Input_Group/GuessButton
	new_game_button = $Input_Group/NewGameButton
	guess_input = $Input_Group/GuessInput

	attempts_label = $Info_Group/AttemptsLabel
	grid_label = $Info_Group/MessageLabel

	grid = $Info_Group/Grid
	

func setup_background():
	var background = ColorRect.new()
	background.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	background.color = Color(0.15, 0.15, 0.2)  # Dark blue-gray
	add_child(background)
	move_child(background, 0)

func new_game():
	secret_word = word_list[randi() % word_list.size()]
	word_length = secret_word.length()
	current_attempt = 0
	guess_input.max_length = word_length
	guess_input.text = ""
	attempts_label.text = "Attempts: 0 / " + str(max_attempts)
	clear_grid()

func clear_grid():
	for child in grid.get_children():
		child.queue_free()

func _on_guess_button_pressed():
	if current_attempt >= max_attempts:
		return

	var guess = guess_input.text.to_upper()
	if guess.length() != word_length:
		grid_label.text = "Word must be " + str(word_length) + " letters long!"
		return

	display_guess(guess)
	current_attempt += 1
	attempts_label.text = "Attempts: " + str(current_attempt) + " / " + str(max_attempts)

	if guess == secret_word:
		grid_label.text = "Congratulations! You guessed the word!"
		guess_button.disabled = true
	elif current_attempt >= max_attempts:
		grid_label.text = "Game over! The word was: " + secret_word
		guess_button.disabled = true

	guess_input.text = ""

func display_guess(guess):
	var row = HBoxContainer.new()
	grid.add_child(row)

	for i in range(word_length):
		var letter_instance = letter_scene.instantiate()
		row.add_child(letter_instance)
		letter_instance.set_letter(guess[i])

		if guess[i] == secret_word[i]:
			letter_instance.set_state("correct")
		elif secret_word.find(guess[i]) != -1:
			letter_instance.set_state("wrong_position")
		else:
			letter_instance.set_state("incorrect")

func _on_new_game_button_pressed():
	guess_button.disabled = false
	new_game()
