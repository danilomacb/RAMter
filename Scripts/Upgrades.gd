extends Node2D

enum UpgradeType {Multishot, ReverseShot}

var playerArrow = load("res://Prefabs/PlayerArrow.tscn")

var multiShotCounter: int = 0
var reverseShotCounter: int = 0

func InstantiateArrows(playerPos, game, mousePos):
	var toMouse = mousePos
		
	var instantiatedArrow = playerArrow.instantiate()
	instantiatedArrow.global_position = playerPos
	var transformRotated = instantiatedArrow.transform.looking_at(toMouse)
	instantiatedArrow.transform = transformRotated
	
	toMouse -= playerPos
	toMouse = toMouse.normalized()
	
	instantiatedArrow.direction = toMouse
	
	game.add_child(instantiatedArrow)

func AddUpgrade(upgradeType):
	match (upgradeType):
		UpgradeType.Multishot:
			multiShotCounter += 1
			print("multishot: " + str(multiShotCounter))
		UpgradeType.ReverseShot:
			reverseShotCounter += 1
			print("reverse: " + str(reverseShotCounter))
