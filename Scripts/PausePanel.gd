extends Panel

@export var settingBackgroundPanel: Panel

func _process(delta):
	if Input.is_action_just_pressed("Pause"):
		Pause()

func Pause():
	if !Globals.GamePaused:
		Globals.GamePaused = true
		visible = true
		get_tree().paused = true
	else:
		Globals.GamePaused = false
		visible = false
		
		if !Globals.ShowingLvUpPanel:
			get_tree().paused = false

func _on_settings_button_pressed():
	settingBackgroundPanel.visible = true

func _on_continue_button_pressed():
	Pause()

func _on_main_menu_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/MainMenu.tscn")

func _on_exit_button_pressed():
	get_tree().quit()
