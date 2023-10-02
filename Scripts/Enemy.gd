extends CharacterBody2D

@export var moveSpeed: float

@onready var hp = $Hp

func _physics_process(delta):
	var playerPos = get_node("/root/Game/Player").global_position
	global_position = global_position.move_toward(playerPos, delta * moveSpeed)

func _on_area_2d_body_entered(body):
	if body.is_in_group("Arrows"):
		hp.TakeDamage(1)
