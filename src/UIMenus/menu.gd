extends Node2D


func close_menu():
	get_tree().change_scene_to_file("res://Main/main.tscn")

func open_help():
	get_tree().change_scene_to_file("res://UIMenus/help.tscn")
