extends Node2D

@export var speed: int = 30
@export var friction: int = 15
@export var label: Label

var shiftDirection: Vector2 = Vector2.ZERO
var rng = RandomNumberGenerator.new()

func _ready():
	shiftDirection = Vector2(rng.randi_range(-1, 1), rng.randi_range(-1, 1))

func _process(delta):
	global_position += speed * shiftDirection * delta
	speed = max(speed - friction * delta, 0)
