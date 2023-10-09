extends Node2D

enum UpgradeType {Multishot, ReverseShot}

var playerArrow = load("res://Prefabs/PlayerArrow.tscn")

func InstantiateArrows(playerPos, bowPos, game, mousePos):
	var base_angle_diff = PI/12
	
	for i in range(Globals.UpgradeMultiShotCounter + 1):
		var instantiatedArrow = playerArrow.instantiate()

		var angle = atan2(mousePos.y - playerPos.y, mousePos.x - playerPos.x)
		var angleDif = base_angle_diff * (i - Globals.UpgradeMultiShotCounter / 2)

		instantiatedArrow.direction = Vector2(cos(angle + angleDif), sin(angle + angleDif))
		instantiatedArrow.rotation = angle + angleDif
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
