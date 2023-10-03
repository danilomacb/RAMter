extends CharacterBody2D

@export var moveSpeed: float

@onready var timer = $Timer

var playerArrow = load("res://Prefabs/PlayerArrow.tscn")

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
		
		var toMouse = get_global_mouse_position()
		
		var instantiatedArrow = playerArrow.instantiate()
		instantiatedArrow.global_position = global_position
		var transformRotated = instantiatedArrow.transform.looking_at(toMouse)
		instantiatedArrow.transform = transformRotated
		
		toMouse -= global_position
		toMouse = toMouse.normalized()
		
		instantiatedArrow.direction = toMouse
		
		get_tree().root.add_child(instantiatedArrow)

func _on_timer_timeout():
	canShoot = true
