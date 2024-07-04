var id setget , _id_getter
var payload setget , _payload_getter
var language setget , _language_getter
var tld setget , _tld_getter


var _js_platform = null

func _id_getter():
	return _js_platform.id

func _payload_getter():
	return _js_platform.payload

func _language_getter():
	return _js_platform.language

func _tld_getter():
	return _js_platform.tld
	
func _init(js_platform):
	_js_platform = js_platform


func send_message(message):
	_js_platform.sendMessage(message)
