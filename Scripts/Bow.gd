extends AnimatedSprite2D

var radius = 10.0

@onready var player = get_parent() as CharacterBody2D

func _process(delta):
	var mouse_pos = get_global_mouse_position()
	var angle = atan2(mouse_pos.y - player.global_position.y, mouse_pos.x - player.global_position.x)
	global_position = player.global_position + Vector2(cos(angle) * radius, sin(angle) * radius)
	rotation = angle
