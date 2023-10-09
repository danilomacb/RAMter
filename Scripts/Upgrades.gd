extends Node2D

enum UpgradeType {AttackSpeed, Multishot, ReverseShot, Penetrator, Reflector}

var playerArrow = load("res://Prefabs/PlayerArrow.tscn")

var base_angle_diff = PI/12

func InstantiateArrows(playerPos, bowPos, game, mousePos):
	for i in range(Globals.UpgradeMultiShotCounter + 1):
		SetArrowDirAndRotation(i, playerPos, bowPos, game, mousePos)
		
	for i in range(Globals.UpgradeReverseShotCounter):
		SetArrowDirAndRotation(i, playerPos, bowPos, game, playerPos + (playerPos - mousePos))

func SetArrowDirAndRotation(i, playerPos, bowPos, game, mousePos):
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
		UpgradeType.ReverseShot:
			Globals.UpgradeReverseShotCounter += 1
		UpgradeType.Penetrator:
			Globals.UpgradePenetratorCounter += 1
		UpgradeType.AttackSpeed:
			Globals.UpgradeAttackSpeedCounter += 1
		UpgradeType.Reflector:
			Globals.UpgradeReflectorCounter += 1
