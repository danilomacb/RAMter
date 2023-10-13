extends Panel

@export var settingBackgroundPanel: Panel

func _on_close_button_pressed():
	settingBackgroundPanel.visible = false

func _on_auto_shoot_check_button_toggled(button_pressed):
	Globals.AutoShoot = button_pressed
