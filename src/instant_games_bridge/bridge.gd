extends Node


const DeviceType = {
	DESKTOP = "desktop",
	MOBILE = "mobile",
	TABLET = "tablet",
	TV = "tv"
}

const VisibilityState = {
	VISIBLE = "visible",
	HIDDEN = "hidden"
}

const PlatformMessage = {
	GAME_READY = "game_ready",
	IN_GAME_LOADING_STARTED = "in_game_loading_started",
	IN_GAME_LOADING_STOPPED = "in_game_loading_stopped",
	GAMEPLAY_STARTED = "gameplay_started",
	GAMEPLAY_STOPPED = "gameplay_stopped",
	PLAYER_GOT_ACHIEVEMENT = "player_got_achievement"
}

const StorageType = {
	LOCAL_STORAGE = "local_storage",
	PLATFORM_INTERNAL = "platform_internal"
}

const BannerState = {
	LOADING = "loading",
	SHOWN = "shown",
	HIDDEN = "hidden",
	FAILED = "failed"
}

const InterstitialState = {
	LOADING = "loading",
	OPENED = "opened",
	CLOSED = "closed",
	FAILED = "failed"
}

const RewardedState = {
	LOADING = "loading",
	OPENED = "opened",
	REWARDED = "rewarded",
	CLOSED = "closed",
	FAILED = "failed"
}


var platform setget , _platform_getter
var device setget , _device_getter
var player setget , _player_getter
var game setget , _game_getter
var storage setget , _storage_getter
var advertisement setget , _advertisement_getter
var social setget , _social_getter
var leaderboard setget , _leaderboard_getter
var payments setget , _payments_getter
var remote_config setget , _remote_config_getter


func _platform_getter():
	return _platform

func _device_getter():
	return _device

func _player_getter():
	return _player

func _game_getter():
	return _game

func _storage_getter():
	return _storage

func _advertisement_getter():
	return _advertisement

func _social_getter():
	return _social

func _leaderboard_getter():
	return _leaderboard

func _payments_getter():
	return _payments

func _remote_config_getter():
	return _remote_config

var _platform = null
var _device = null
var _player = null
var _game = null
var _storage = null
var _advertisement = null
var _social = null
var _leaderboard = null
var _payments = null
var _remote_config = null


func _ready():
	if OS.has_feature("JavaScript"):
		var js_bridge = JavaScript.get_interface("bridge")
		_platform = load("res://addons/instant_games_bridge/modules/platform/platform.gd").new(js_bridge.platform)
		_device = load("res://addons/instant_games_bridge/modules/device/device.gd").new(js_bridge.device)
		_player = load("res://addons/instant_games_bridge/modules/player/player.gd").new(js_bridge.player)
		_game = load("res://addons/instant_games_bridge/modules/game/game.gd").new(js_bridge.game)
		_storage = load("res://addons/instant_games_bridge/modules/storage/storage.gd").new(js_bridge.storage)
		_advertisement = load("res://addons/instant_games_bridge/modules/advertisement/advertisement.gd").new(js_bridge.advertisement)
		_social = load("res://addons/instant_games_bridge/modules/social/social.gd").new(js_bridge.social)
		_leaderboard = load("res://addons/instant_games_bridge/modules/leaderboard/leaderboard.gd").new(js_bridge.leaderboard)
		_payments = load("res://addons/instant_games_bridge/modules/payments/payments.gd").new(js_bridge.payments)
		_remote_config = load("res://addons/instant_games_bridge/modules/remote_config/remote_config.gd").new(js_bridge.remoteConfig)
	else:
		_platform = load("res://addons/instant_games_bridge/modules/platform/platform_editor_mock.gd").new()
		_device = load("res://addons/instant_games_bridge/modules/device/device_editor_mock.gd").new()
		_player = load("res://addons/instant_games_bridge/modules/player/player_editor_mock.gd").new()
		_game = load("res://addons/instant_games_bridge/modules/game/game_editor_mock.gd").new()
		_storage = load("res://addons/instant_games_bridge/modules/storage/storage_editor_mock.gd").new()
		_advertisement = load("res://addons/instant_games_bridge/modules/advertisement/advertisement_editor_mock.gd").new()
		_social = load("res://addons/instant_games_bridge/modules/social/social_editor_mock.gd").new()
		_leaderboard = load("res://addons/instant_games_bridge/modules/leaderboard/leaderboard_editor_mock.gd").new()
		_payments = load("res://addons/instant_games_bridge/modules/payments/payments_editor_mock.gd").new()
		_remote_config = load("res://addons/instant_games_bridge/modules/remote_config/remote_config_editor_mock.gd").new()
