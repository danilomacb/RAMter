extends Node

enum HpType {Player, Enemy}

@export var hpType: HpType
@export var maxHp: float

var curHp

func _ready():
	curHp = maxHp

func TakeDamage(damage):
	curHp -= damage
	
	if hpType == HpType.Player && curHp <= 0:
		get_tree().reload_current_scene()
	
	if hpType == HpType.Enemy && curHp <= 0:
		get_parent().queue_free()
