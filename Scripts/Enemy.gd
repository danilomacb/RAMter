extends CharacterBody2D

enum EnemyType {BasicEnemy, PassengerEnemy}

@export var moveSpeed: float
@export var flip: bool
@export var animatedSprite2D: AnimatedSprite2D
@export var damage: int
@export var timer: Timer
@export var enemyType: EnemyType

var collidingWithPlayer: bool = false
var playerBody: CharacterBody2D
var playerPos: Vector2
var direction: Vector2

func _ready():
	playerPos = get_node("/root/Game/Player").global_position
	direction = (playerPos - global_position).normalized()

func _physics_process(delta):
	Move(delta)
	Pass(delta)

func Move(delta):
	if enemyType == EnemyType.PassengerEnemy:
		return
	
	playerPos = get_node("/root/Game/Player").global_position
	direction = (playerPos - global_position).normalized()
	velocity = direction * moveSpeed
	move_and_collide(velocity * delta)
	
	Flip(playerPos)

func Pass(delta):
	if enemyType == EnemyType.BasicEnemy:
		return
	
	velocity = direction * moveSpeed
	move_and_collide(velocity * delta)
	
	Flip(playerPos)

func Flip(playerPos):
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
