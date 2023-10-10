extends CharacterBody2D

@export var moveSpeed: float
@export var flip: bool
@export var animatedSprite2D: AnimatedSprite2D
@export var timer: Timer
@export var damage: int

var collidingWithPlayer: bool = false
var playerBody: CharacterBody2D

func _physics_process(delta):
	var playerPos = get_node("/root/Game/Player").global_position
	global_position = global_position.move_toward(playerPos, delta * moveSpeed)
	
	if flip && playerPos.x >= global_position.x:
		animatedSprite2D.flip_h = false
	if flip && playerPos.x < global_position.x:
		animatedSprite2D.flip_h = true

func DamagePlayer():
	timer.start()
	playerBody.hp.TakeDamage(damage)

func _on_area_2d_body_entered(body):
	if body.is_in_group("Player"):
		collidingWithPlayer = true
		playerBody = body
		DamagePlayer()

func _on_area_2d_body_exited(body):
	if body.is_in_group("Player"):
		collidingWithPlayer = false

func _on_timer_timeout():
	if collidingWithPlayer:
		DamagePlayer()
