extends Node

@export var maxHp: float

var curHp

func _ready():
	curHp = maxHp

func TakeDamage(damage):
	curHp -= damage
	
	if curHp <= 0:
		get_parent().queue_free()
