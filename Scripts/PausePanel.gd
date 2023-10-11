extends Panel

var gamePaused: bool = false

func _process(delta):
	Pause()

func Pause():
	if Input.is_action_just_pressed("Pause"):
		if !gamePaused:
			gamePaused = true
			visible = true
			get_tree().paused = true
		else:
			gamePaused = false
			visible = false
			
			if !Globals.ShowingLvUpPanel:
				get_tree().paused = false
