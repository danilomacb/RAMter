extends Node

@export var expIncrementor: int

var expCollected: int

func AddExp():
	expCollected += expIncrementor
	print(expCollected)
