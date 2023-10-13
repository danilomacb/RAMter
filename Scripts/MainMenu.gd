extends Control

@export var settingBackgroundPanel: Panel

var gameScene = preload("res://Scenes/Game.tscn").instantiate()

func _on_settings_button_pressed():
	settingBackgroundPanel.visible = true

func _on_play_button_pressed():
	get_tree().root.add_child(gameScene)
	get_node("/root/MainMenu").queue_free()

func _on_exit_button_pressed():
	get_tree().quit()
