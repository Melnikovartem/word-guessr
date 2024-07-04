signal visibility_state_changed
var visibility_state setget , _visibility_state_getter

func _visibility_state_getter():
	return Bridge.VisibilityState.VISIBLE
