extends Node

signal OnLevelUp

@onready var expBar: TextureProgressBar = get_node("/root/Game/CanvasLayer/Control/ExpBar")
@onready var lvLabel: Label = get_node("/root/Game/CanvasLayer/Control/PlayerPanelBg/LvPanel/LvLabel")

@export var lvUpSfx: AudioStreamPlayer2D

var expCollected: int
var lv: int
var nexLvExp: int = 1

func AddExp(expIncrementor: int):
	expCollected += expIncrementor
	
	expBar.value = (float(expCollected) / float(nexLvExp)) * 100
	
	if expCollected >= nexLvExp:
		expBar.value = 0
		LevelUp()

func LevelUp():
	lvUpSfx.play()
	
	emit_signal("OnLevelUp")
	expCollected = 0
	nexLvExp *= 2
	lv += 1
	get_node("/root/Game/CanvasLayer/Control/UpgradePanel").visible = true
	get_tree().paused = true
	Globals.ShowingLvUpPanel = true
	lvLabel.text = str(lv)
