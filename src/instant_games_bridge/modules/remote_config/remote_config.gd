var is_supported setget , _is_supported_getter


func _is_supported_getter():
	return false

var _js_remote_config = null
var _is_getting = false
var _get_callback = null
var _js_get_then = JavaScript.create_callback(self, "_on_js_get_then")
var _js_get_catch = JavaScript.create_callback(self, "_on_js_get_catch")
var _utils = load("res://addons/instant_games_bridge/utils.gd").new()


func get(options = null, callback = null):
	if _is_getting:
		return
	
	if callback == null:
		return
	
	_is_getting = true
	_get_callback = callback
	
	var js_options = null
	if options:
		js_options = _utils.convert_to_js(options)
	
	_js_remote_config.get(js_options) \
		.then(_js_get_then) \
		.catch(_js_get_catch)


func _init(js_remote_config):
	_js_remote_config = js_remote_config

func _on_js_get_then(args):
	_is_getting = false
	if _get_callback == null:
		return
	
	var data = args[0]
	var data_type = typeof(data)
	match data_type:
		TYPE_OBJECT:
			var values = {}
			var keys = JavaScript.get_interface("Object").keys(data)
			for i in range(keys.length):
				values[keys[i]] = data[keys[i]]
			_get_callback.call_func(true, values)
		_:
			_get_callback.call_func(true, data)

func _on_js_get_catch(args):
	_is_getting = false
	if _get_callback != null:
		_get_callback.call_func(false, null)
