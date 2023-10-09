extends Node2D

enum UpgradeType {Multishot, ReverseShot}

var playerArrow = load("res://Prefabs/PlayerArrow.tscn")

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
			Globals.UpgradeMultiShotCounter += 1
			print("multishot: " + str(Globals.UpgradeMultiShotCounter))
		UpgradeType.ReverseShot:
			Globals.UpgradeReverseShotCounter += 1
			print("reverse: " + str(Globals.UpgradeReverseShotCounter))
