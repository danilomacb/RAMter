extends Button

var upgrades = load("res://Scripts/Upgrades.gd").new()

var rng = RandomNumberGenerator.new()

var currentUpgradeIndex: int = 0

func _ready():
	var player = get_node("/root/Game/Player/PlayerExp")
	player.OnLevelUp.connect(RandomizeUpgradeCard)

func RandomizeUpgradeCard():
	currentUpgradeIndex = rng.randi_range(0, upgrades.UpgradeType.size() - 1)
	text = upgrades.UpgradeType.find_key(currentUpgradeIndex)
	
func _on_pressed():
	upgrades.AddUpgrade(currentUpgradeIndex)
	get_parent().visible = false
	get_tree().paused = false
