extends Node

enum HpType {Player, Enemy}

@export var hpType: HpType
@export var maxHp: float
@export var invulnerabilityTime: float

@onready var timer = $Timer
@onready var curHp = maxHp

var damageIndicator := load("res://Prefabs/DamageIndicator.tscn")
var exp := load("res://Prefabs/Exp.tscn")

var canTakeDamage = true

func _ready():
	timer.wait_time = invulnerabilityTime

func TakeDamage(damage):
	if !canTakeDamage:
		return
	
	canTakeDamage = false
	timer.start()
	
	curHp -= damage
		
	var instantiatedDamageIndicator = damageIndicator.instantiate()
	instantiatedDamageIndicator.global_position = get_parent().global_position
	get_tree().root.add_child(instantiatedDamageIndicator)
	
	if curHp <= 0:
		Death()

func Death():
	if hpType == HpType.Player:
		get_tree().reload_current_scene()
	
	if hpType == HpType.Enemy:
		var instantiatedExp = exp.instantiate()
		instantiatedExp.global_position = get_parent().global_position
		get_tree().root.add_child(instantiatedExp)
		get_parent().queue_free()

func _on_timer_timeout():
	canTakeDamage = true
