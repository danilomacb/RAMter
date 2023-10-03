extends Node

signal OnLevelUp

@export var expIncrementor: int

var expCollected: int
var lv: int
var nexLvExp: int = 1

func AddExp():
	expCollected += expIncrementor
	if expCollected >= nexLvExp:
		LevelUp()

func LevelUp():
	emit_signal("OnLevelUp")
	expCollected = 0
	nexLvExp *= 2
	lv += 1
	print("lv: " + str(lv))
	get_node("/root/Game/CanvasLayer/Control/UpgradePanel").visible = true
	get_tree().paused = true
