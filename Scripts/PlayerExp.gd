extends Node

signal OnLevelUp

@export var expIncrementor: int

@onready var expBar: TextureProgressBar = get_node("/root/Game/CanvasLayer/Control/ExpBar")

var expCollected: int
var lv: int
var nexLvExp: int = 1

func AddExp():
	expCollected += expIncrementor
	
	expBar.value = (float(expCollected) / float(nexLvExp)) * 100
	print(expBar.value)
	
	if expCollected >= nexLvExp:
		LevelUp()
		expBar.value = 0

func LevelUp():
	emit_signal("OnLevelUp")
	expCollected = 0
	nexLvExp *= 2
	lv += 1
	get_node("/root/Game/CanvasLayer/Control/UpgradePanel").visible = true
	get_tree().paused = true
