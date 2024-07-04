var is_supported setget , _is_supported_getter
var is_native_popup_supported setget , _is_native_popup_supported_getter
var is_multiple_boards_supported setget , _is_multiple_boards_supported_getter
var is_set_score_supported setget , _is_set_score_supported_getter
var is_get_score_supported setget , _is_get_score_supported_getter
var is_get_entries_supported setget , _is_get_entries_supported_getter


func _is_supported_getter():
	return false

func _is_native_popup_supported_getter():
	return false

func _is_multiple_boards_supported_getter():
	return false

func _is_set_score_supported_getter():
	return false

func _is_get_score_supported_getter():
	return false

func _is_get_entries_supported_getter():
	return false


func set_score(options = null, callback = null):
	if callback != null:
		callback.call_func(false)

func get_score(options = null, callback = null):
	if callback != null:
		callback.call_func(false, 0)

func get_entries(options = null, callback = null):
	if callback != null:
		callback.call_func(false, [])

func show_native_popup(options = null, callback = null):
	if callback != null:
		callback.call_func(false)
