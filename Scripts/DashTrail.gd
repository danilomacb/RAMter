extends Line2D
class_name DashTrail

@export var maxLenght: int

var queue: Array

func _process(delta):
	var pos: Vector2 = _get_position()
	
	queue.push_front(pos)

	if queue.size() > maxLenght:
		queue.pop_back()

	clear_points()
	
	for i in queue:
		add_point(i)

func _get_position():
	return get_parent().position
