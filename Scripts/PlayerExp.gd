extends Node

@export var expIncrementor: int

var expCollected: int
var lv: int
var nexLvExp: int = 1

func AddExp():
	expCollected += expIncrementor
	if expCollected >= nexLvExp:
		LevelUp()

func LevelUp():
	expCollected = 0
	nexLvExp *= 2
	lv += 1
	print(lv)
