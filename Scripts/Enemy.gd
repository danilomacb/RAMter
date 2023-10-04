extends CharacterBody2D

@export var moveSpeed: float
@export var animatedSprite2D: AnimatedSprite2D

func _physics_process(delta):
	var playerPos = get_node("/root/Game/Player").global_position
	global_position = global_position.move_toward(playerPos, delta * moveSpeed)
	
	if playerPos.x > global_position.x:
		animatedSprite2D.flip_h = false
	else:
		animatedSprite2D.flip_h = true

func _on_area_2d_body_entered(body):
	if body.is_in_group("Player"):
		body.get_node("Hp").TakeDamage(1)
