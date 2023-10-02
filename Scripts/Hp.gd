extends Node

enum HpType {Player, Enemy}

@export var hpType: HpType
@export var maxHp: float
@export var invulnerabilityTime: float

@onready var timer = $Timer
@onready var curHp = maxHp

var canTakeDamage = true

func _ready():
	timer.wait_time = invulnerabilityTime

func TakeDamage(damage):
	if !canTakeDamage:
		return
	
	canTakeDamage = false
	timer.start()
	
	curHp -= damage
	
	if hpType == HpType.Player && curHp <= 0:
		get_tree().reload_current_scene()
	
	if hpType == HpType.Enemy && curHp <= 0:
		get_parent().queue_free()

func _on_timer_timeout():
	canTakeDamage = true
