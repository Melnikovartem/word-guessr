signal banner_state_changed
signal interstitial_state_changed
signal rewarded_state_changed

var minimum_delay_between_interstitial setget , _minimum_delay_between_interstitial_getter
var is_banner_supported setget , _is_banner_supported_getter
var banner_state setget , _banner_state_getter
var interstitial_state setget , _interstitial_state_getter
var rewarded_state setget , _rewarded_state_getter


func _minimum_delay_between_interstitial_getter():
	return _js_advertisement.minimumDelayBetweenInterstitial

func _is_banner_supported_getter():
	return _js_advertisement.isBannerSupported
	
func _banner_state_getter():
	return _js_advertisement.bannerState

func _interstitial_state_getter():
	return _js_advertisement.interstitialState

func _rewarded_state_getter():
	return _js_advertisement.rewardedState

var _js_advertisement = null
var _js_on_banner_state_changed = JavaScript.create_callback(self, "_on_banner_state_changed")
var _js_on_interstitial_state_changed = JavaScript.create_callback(self, "_on_interstitial_state_changed")
var _js_on_rewarded_state_changed = JavaScript.create_callback(self, "_on_rewarded_state_changed")
var _utils = load("res://addons/instant_games_bridge/utils.gd").new()


func set_minimum_delay_between_interstitial(value):
	_js_advertisement.setMinimumDelayBetweenInterstitial(value)

func show_banner(options = null):
	var js_options = null
	if options:
		js_options = _utils.convert_to_js(options)

	_js_advertisement.showBanner(js_options)

func hide_banner():
	_js_advertisement.hideBanner()

func show_interstitial():
	_js_advertisement.showInterstitial()

func show_rewarded():
	_js_advertisement.showRewarded()


func _init(js_advertisement):
	_js_advertisement = js_advertisement
	_js_advertisement.on('banner_state_changed', _js_on_banner_state_changed)
	_js_advertisement.on('interstitial_state_changed', _js_on_interstitial_state_changed)
	_js_advertisement.on('rewarded_state_changed', _js_on_rewarded_state_changed)

func _on_banner_state_changed(args):
	emit_signal("banner_state_changed", args[0])

func _on_interstitial_state_changed(args):
	emit_signal("interstitial_state_changed", args[0])

func _on_rewarded_state_changed(args):
	emit_signal("rewarded_state_changed", args[0])
