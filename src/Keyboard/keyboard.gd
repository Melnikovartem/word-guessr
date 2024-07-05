class_name Keyboard
extends VBoxContainer


func _ready() -> void:
	for node in get_tree().get_nodes_in_group("letter_keys"):
		var key := node as Button
		assert(key)
		var letter_unicode := _char_to_ascii_int(key.text.to_lower())
		key.pressed.connect(_send_input_event_with_unicode.bind(letter_unicode))


func flush_keyboard():
	for node in get_tree().get_nodes_in_group("letter_keys"):
		var key := node as Button
		assert(key)
		key.self_modulate = Color.WHITE
			
func change_letter_key_color(letter: String, check_letter: globals.LetterState) -> void:
	for node in get_tree().get_nodes_in_group("letter_keys"):
		var key := node as Button
		assert(key)
		if letter == key.text.to_lower():
			match check_letter:
				globals.LetterState.NOT_CHECKED:
					key.self_modulate = Color.WHITE
				globals.LetterState.NOT_IN_WORD:
					if key.self_modulate != Color.YELLOW and key.self_modulate != Color.YELLOW_GREEN:
						key.self_modulate = Color.INDIAN_RED
				globals.LetterState.WRONG_PLACE:
					if key.self_modulate != Color.YELLOW_GREEN:
						key.self_modulate = Color.YELLOW
				globals.LetterState.CORRECT:
					key.self_modulate = Color.YELLOW_GREEN
			return
			

func _char_to_ascii_int(letter: String) -> int:
	var buffer := StreamPeerBuffer.new()
	buffer.data_array = letter.to_ascii_buffer()
	return buffer.get_8()


func _send_input_event_with_unicode(unicode: int) -> void:
	var event := InputEventKey.new()
	event.pressed = true
	event.unicode = unicode
	Input.parse_input_event(event)


func _send_input_event_with_keycode(keycode: Key) -> void:
	var event := InputEventKey.new()
	event.pressed = true
	event.keycode = keycode
	Input.parse_input_event(event)


func _on_BackSpace_pressed() -> void:
	_send_input_event_with_keycode(KEY_BACKSPACE)


func _on_Enter_pressed() -> void:
	_send_input_event_with_keycode(KEY_ENTER)
