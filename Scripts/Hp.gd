class_name Hp extends Node

enum HpType {Player, Enemy}

@export var hpType: HpType
@export var maxHp: float
@export var invulnerabilityTime: float
@export var expToDrop: Globals.ExpType

@onready var curHp = maxHp
@onready var game = get_node("/root/Game")
@onready var gameOverPanel = get_node("/root/Game/CanvasLayer/Control/GameOverPanel")
@onready var hpBar: TextureProgressBar = get_node("/root/Game/CanvasLayer/Control/HpBar")

var damageIndicator: PackedScene = load("res://Prefabs/DamageIndicator.tscn")
var exp: PackedScene = load("res://Prefabs/Exp.tscn")
var playerArrow: PackedScene = load("res://Prefabs/PlayerArrow.tscn")

var rng = RandomNumberGenerator.new()

func _ready():
	get_tree().paused = false

func TakeDamage(damage):
	curHp -= damage
		
	var instantiatedDamageIndicator = damageIndicator.instantiate()
	instantiatedDamageIndicator.label.text = str(damage)
	instantiatedDamageIndicator.global_position = get_parent().global_position
	get_tree().root.add_child(instantiatedDamageIndicator)
	
	if hpType == HpType.Player:
		hpBar.value = (curHp / maxHp) * 100
	
	if curHp <= 0:
		Death()

func Death():
	if hpType == HpType.Player:
		Globals.UpgradeAttackSpeedCounter = 0
		Globals.UpgradeMultiShotCounter = 0
		Globals.UpgradeReverseShotCounter = 0
		Globals.UpgradePenetratorCounter = 0
		Globals.UpgradeReflectorCounter = 0
		Globals.UpgradeDeathArrowCounter = 0
		get_tree().paused = true
		gameOverPanel.visible = true
	
	if hpType == HpType.Enemy:
		if Globals.UpgradeDeathArrowCounter > 0:
			for i in Globals.UpgradeDeathArrowCounter:
				var instantiatedArrow = playerArrow.instantiate()
				
				var directionX: float = 0.0
				var directionY: float = 0.0
				
				while directionX == 0.0:
					directionX = rng.randf_range(-1, 1)
				
				while directionY == 0.0:
					directionY = rng.randf_range(-1, 1)
				
				instantiatedArrow.direction = Vector2(directionX, directionY)
				instantiatedArrow.global_position = get_parent().global_position
				instantiatedArrow.rotation = atan2(instantiatedArrow.direction.y, instantiatedArrow.direction.x)
				
				game.add_child(instantiatedArrow)
		
		var instantiatedExp = exp.instantiate()
		instantiatedExp.expType = expToDrop
		instantiatedExp.global_position = get_parent().global_position
		game.add_child(instantiatedExp)
		get_parent().queue_free()
