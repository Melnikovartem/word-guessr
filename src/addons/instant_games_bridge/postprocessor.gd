extends EditorExportPlugin

const INDEX_FILE_NAME = "index.html"
const JS_SDK_FILE_NAME = "instant-games-bridge.js"
const JS_SDK_PATH = "res://addons/instant_games_bridge/template/" + JS_SDK_FILE_NAME

func _export_begin(features, is_debug, path, flags):
	if features.has("web"):
		var file_from = FileAccess.open(JS_SDK_PATH, FileAccess.READ)
		var file_to = FileAccess.open(path.get_base_dir() + "/" + JS_SDK_FILE_NAME, FileAccess.WRITE)
		file_to.store_string(file_from.get_as_text())
		file_from = null
		file_to = null
