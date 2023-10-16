class_name Hp extends Node

enum HpType {Player, Enemy}

@export var hpType: HpType
@export var maxHp: float
@export var invulnerabilityTime: float
@export var expToDrop: Globals.ExpType
@export var playerTakeDamageSfx: AudioStreamPlayer2D
@export var timer: Timer

@onready var curHp = maxHp
@onready var game = get_node("/root/Game")
@onready var gameOverPanel = get_node("/root/Game/CanvasLayer/Control/GameOverPanel")
@onready var hpBar: TextureProgressBar = get_node("/root/Game/CanvasLayer/Control/HpBar")
@onready var gameMusic: AudioStreamPlayer2D = get_node("/root/Game/Player/GameMusic")
@onready var gameOverMusic: AudioStreamPlayer2D = get_node("/root/Game/Player/GameOverMusic")
@onready var killsLabel: Label = get_node("/root/Game/CanvasLayer/Control/KillsLabel")
@onready var parent = get_parent()

var damageIndicator: PackedScene = load("res://Prefabs/DamageIndicator.tscn")
var exp: PackedScene = load("res://Prefabs/Exp.tscn")
var playerArrow: PackedScene = load("res://Prefabs/PlayerArrow.tscn")

var rng = RandomNumberGenerator.new()

var blinkTime: float = 0.05

func _ready():
	get_tree().paused = false

func TakeDamage(damage):
	curHp -= damage
	
	Blink()
	
	var instantiatedDamageIndicator = damageIndicator.instantiate()
	instantiatedDamageIndicator.label.text = str(damage)
	instantiatedDamageIndicator.global_position = parent.global_position
	
	if hpType == HpType.Player:
		hpBar.value = (curHp / maxHp) * 100
		instantiatedDamageIndicator.label.modulate = Color("9b1a0a")
		
		playerTakeDamageSfx.play()
	
	if hpType == HpType.Enemy:
		timer.start()
		parent.canMove = false
	
	get_node("/root/Game").add_child(instantiatedDamageIndicator)
	
	if curHp <= 0:
		Death()

func Blink():
	var sprite = parent.get_node("Sprite")
	var tween = create_tween()
	
	for i in 5:
		tween.tween_property(sprite, "modulate", Color.TRANSPARENT, blinkTime)
		tween.tween_property(sprite, "modulate", Color.WHITE, blinkTime)

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
		gameMusic.stop()
		gameOverMusic.play()
	
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
				
				instantiatedArrow.direction = Vector2(directionX, directionY).normalized()
				instantiatedArrow.global_position = get_parent().global_position
				instantiatedArrow.rotation = atan2(instantiatedArrow.direction.y, instantiatedArrow.direction.x)
				
				game.add_child(instantiatedArrow)
		
		var instantiatedExp = exp.instantiate()
		instantiatedExp.expType = expToDrop
		instantiatedExp.global_position = get_parent().global_position
		game.add_child(instantiatedExp)
		
		killsLabel.killsCounter += 1
		killsLabel.text = str(killsLabel.killsCounter)
		
		get_parent().queue_free()

func Heal(healAmount):
	if curHp + healAmount < maxHp:
		curHp += healAmount
	else:
		curHp = maxHp
	
	hpBar.value = (curHp / maxHp) * 100

func _on_timer_timeout():
	parent.canMove = true
