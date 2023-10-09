extends CharacterBody2D

@export var moveSpeed: float
@export var timer: Timer
@export var animatedSprite2d: AnimatedSprite2D
@export var bow: AnimatedSprite2D

var upgrades = load("res://Scripts/Upgrades.gd").new()

var canShoot = true

func _physics_process(delta):
	Move()
	Shoot()

func Move():
	var directionX = Input.get_axis("MoveLeft", "MoveRight")
	var directionY = Input.get_axis("MoveUp", "MoveDown")
	var direction = Vector2(directionX, directionY)
	
	if direction != Vector2.ZERO:
		velocity = direction * moveSpeed
		animatedSprite2d.play("Walk")
		
		if direction.x > 0:
			animatedSprite2d.flip_h = false
		else:
			animatedSprite2d.flip_h = true
	else:
		velocity = Vector2.ZERO
		animatedSprite2d.play("Idle")
	
	move_and_slide()

func Shoot():
	if Input.is_action_pressed("Shoot") && canShoot:
		canShoot = false
		
		timer.wait_time = 1 - Globals.UpgradeAttackSpeedCounter * 0.1
		
		if timer.wait_time < 0.1:
			timer.wait_time = 0.1
		
		timer.start()
		
		upgrades.InstantiateArrows(global_position, bow.global_position, get_node("/root/Game"), get_global_mouse_position())
		bow.play("Shoot")

func _on_timer_timeout():
	canShoot = true

func _on_bow_animation_finished():
	bow.play("Idle")
