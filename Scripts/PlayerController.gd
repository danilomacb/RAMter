extends CharacterBody2D

@export var moveSpeed: float
@export var dashSpeed: float
@export var shootTimer: Timer
@export var dashTimer: Timer
@export var dashCooldownTimer: Timer
@export var animatedSprite2d: AnimatedSprite2D
@export var bow: AnimatedSprite2D
@export var hp: Hp
@export var dashTrail: DashTrail

@onready var pausePanel: Panel = get_node("/root/Game/CanvasLayer/Control/PausePanel")

var upgrades = load("res://Scripts/Upgrades.gd").new()

var lastDirection: Vector2 = Vector2.ZERO
var canShoot: bool = true
var isDashing: bool = false
var canDash: bool = true

func _physics_process(delta):
	Move()
	Shoot()
	Dash()
	
	move_and_collide(velocity * delta)

func Move():
	var directionX = Input.get_axis("MoveLeft", "MoveRight")
	var directionY = Input.get_axis("MoveUp", "MoveDown")
	var direction = Vector2(directionX, directionY)
	
	if direction != Vector2.ZERO:
		lastDirection = direction
	
	if isDashing:
		return
	
	if direction != Vector2.ZERO:
		velocity = direction.normalized() * moveSpeed
		animatedSprite2d.play("Walk")
		
		if direction.x > 0:
			animatedSprite2d.flip_h = false
		else:
			animatedSprite2d.flip_h = true
	else:
		velocity = Vector2.ZERO
		animatedSprite2d.play("Idle")

func Shoot():
	if canShoot:
		canShoot = false
		
		shootTimer.wait_time = 1 - Globals.UpgradeAttackSpeedCounter * 0.1
		
		if shootTimer.wait_time < 0.1:
			shootTimer.wait_time = 0.1
		
		shootTimer.start()
		
		upgrades.InstantiateArrows(global_position, bow.global_position, get_node("/root/Game"), get_global_mouse_position())
		bow.play("Shoot")

func Dash():
	if Input.is_action_just_pressed("Dash") && canDash:
		isDashing = true
		canDash = false
		dashTimer.start()
		dashCooldownTimer.start()
	
	if isDashing:
		velocity = lastDirection.normalized() * dashSpeed
		dashTrail.visible = true

func _on_bow_animation_finished():
	bow.play("Idle")

func _on_shoot_timer_timeout():
	canShoot = true

func _on_dash_timer_timeout():
	isDashing = false
	velocity = Vector2.ZERO
	dashTrail.visible = false

func _on_dash_cooldown_timer_timeout():
	canDash = true
