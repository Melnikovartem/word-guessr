var is_supported setget , _is_supported_getter


func _is_supported_getter():
	return false


func purchase(options = null, callback = null):
	if callback != null:
		callback.call_func(false)

func consume_purchase(options = null, callback = null):
	if callback != null:
		callback.call_func(false)

func get_catalog(callback = null):
	if callback != null:
		callback.call_func(false, [])

func get_purchases(callback = null):
	if callback != null:
		callback.call_func(false, [])
