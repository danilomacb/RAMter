extends CharacterBody2D

@export var _moveSpeed: float

func _physics_process(delta):
	HorizontalMove()
	VerticalMove()
	move_and_slide()

func HorizontalMove():
	var directionX = Input.get_axis("MoveLeft", "MoveRight")
	if directionX:
		velocity.x = directionX * _moveSpeed
	else:
		velocity.x = move_toward(velocity.x, 0, _moveSpeed)

func VerticalMove():
	var directionY = Input.get_axis("MoveUp", "MoveDown")
	if directionY:
		velocity.y = directionY * _moveSpeed
	else:
		velocity.y = move_toward(velocity.y, 0, _moveSpeed)
