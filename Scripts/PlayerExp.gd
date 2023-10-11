extends Node

signal OnLevelUp

@onready var expBar: TextureProgressBar = get_node("/root/Game/CanvasLayer/Control/ExpBar")

var expCollected: int
var lv: int
var nexLvExp: int = 1

func AddExp(expIncrementor: int):
	expCollected += expIncrementor
	
	expBar.value = (float(expCollected) / float(nexLvExp)) * 100
	
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
	Globals.ShowingLvUpPanel = true
