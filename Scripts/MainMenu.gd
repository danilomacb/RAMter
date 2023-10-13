extends Control

@export var settingBackgroundPanel: Panel

var gameScene: PackedScene = preload("res://Scenes/Game.tscn")

func _on_settings_button_pressed():
	settingBackgroundPanel.visible = true

func _on_play_button_pressed():
	get_tree().change_scene_to_packed(gameScene)

func _on_exit_button_pressed():
	get_tree().quit()
