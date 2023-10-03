extends CharacterBody2D

@export var moveSpeed: float

@onready var timer = $Timer

var upgrades = load("res://Scripts/Upgrades.gd").new()

var canShoot = true

func _physics_process(delta):
	HorizontalMove()
	VerticalMove()
	Shoot()
	move_and_slide()

func HorizontalMove():
	var directionX = Input.get_axis("MoveLeft", "MoveRight")
	if directionX:
		velocity.x = directionX * moveSpeed
	else:
		velocity.x = move_toward(velocity.x, 0, moveSpeed)

func VerticalMove():
	var directionY = Input.get_axis("MoveUp", "MoveDown")
	if directionY:
		velocity.y = directionY * moveSpeed
	else:
		velocity.y = move_toward(velocity.y, 0, moveSpeed)
		
func Shoot():
	if Input.is_action_pressed("Shoot") && canShoot:
		canShoot = false
		timer.start()
		
		upgrades.InstantiateArrows(global_position, get_node("/root/Game"), get_global_mouse_position())

func _on_timer_timeout():
	canShoot = true
