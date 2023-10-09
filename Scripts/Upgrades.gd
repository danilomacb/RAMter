extends Node2D

enum UpgradeType {Multishot, ReverseShot}

var playerArrow = load("res://Prefabs/PlayerArrow.tscn")

var radius := 10.0

func InstantiateArrows(playerPos, bowPos, game, mousePos):
	var instantiatedArrow = playerArrow.instantiate()

	radius = playerPos.distance_to(mousePos)
	
	var angle = atan2(mousePos.y - playerPos.y, mousePos.x - playerPos.x)
	instantiatedArrow.direction = Vector2(cos(angle), sin(angle))
	instantiatedArrow.rotation = angle
	instantiatedArrow.global_position = bowPos
	
	game.add_child(instantiatedArrow)

func AddUpgrade(upgradeType):
	match (upgradeType):
		UpgradeType.Multishot:
			Globals.UpgradeMultiShotCounter += 1
			print("multishot: " + str(Globals.UpgradeMultiShotCounter))
		UpgradeType.ReverseShot:
			Globals.UpgradeReverseShotCounter += 1
			print("reverse: " + str(Globals.UpgradeReverseShotCounter))
