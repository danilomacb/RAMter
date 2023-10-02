extends Node

enum HpType {Player, Enemy}

@export var hpType: HpType
@export var maxHp: float
@export var invulnerabilityTime: float

@onready var timer = $Timer
@onready var curHp = maxHp

var damageIndicator = load("res://Prefabs/DamageIndicator.tscn")

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
		
	var instantiatedDamageIndicator = damageIndicator.instantiate()
	instantiatedDamageIndicator.global_position = get_parent().global_position
	get_tree().root.add_child(instantiatedDamageIndicator)

func _on_timer_timeout():
	canTakeDamage = true
