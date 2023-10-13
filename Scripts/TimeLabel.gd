extends Label

var time: float = 0

func _process(delta):
	time += delta
	
	text = str(int(time))
