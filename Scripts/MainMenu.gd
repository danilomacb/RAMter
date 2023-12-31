extends Control

@export var settingBackgroundPanel: Panel
@export var commandsPanel: Panel

func _on_settings_button_pressed():
	settingBackgroundPanel.visible = true

func _on_play_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/Game.tscn")

func _on_exit_button_pressed():
	get_tree().quit()

func _on_commands_pressed():
	commandsPanel.visible = true
