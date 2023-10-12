extends Panel

@export var volumePanel: Panel

var gamePaused: bool = false

func _process(delta):
	if Input.is_action_just_pressed("Pause"):
		Pause()

func Pause():
	if !gamePaused:
		gamePaused = true
		visible = true
		get_tree().paused = true
	else:
		gamePaused = false
		visible = false
		
		if !Globals.ShowingLvUpPanel:
			get_tree().paused = false

func _on_settings_button_pressed():
	volumePanel.visible = true

func _on_close_button_pressed():
	volumePanel.visible = false

func _on_continue_button_pressed():
	Pause()

func _on_main_menu_button_pressed():
	pass # Replace with function body.

func _on_exit_button_pressed():
	get_tree().quit()

func _on_auto_shoot_check_button_toggled(button_pressed):
	Globals.AutoShoot = button_pressed
