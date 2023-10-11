extends Button

@export var cardResources: Array[CardResource]

@onready var titleLabel: Label = $TitleLabel
@onready var textureRect: TextureRect = $TextureRect
@onready var descriptionLabel: Label = $DescriptionLabel

var upgrades = load("res://Scripts/Upgrades.gd").new()

var rng = RandomNumberGenerator.new()

var currentUpgradeIndex: int = 0

func _ready():
	var player = get_node("/root/Game/Player/PlayerExp")
	player.OnLevelUp.connect(RandomizeUpgradeCard)

func RandomizeUpgradeCard():
	currentUpgradeIndex = rng.randi_range(0, cardResources.size() - 1)
	titleLabel.text = cardResources[currentUpgradeIndex].title
	textureRect.texture = cardResources[currentUpgradeIndex].texture
	descriptionLabel.text = cardResources[currentUpgradeIndex].description

func _on_pressed():
	upgrades.AddUpgrade(cardResources[currentUpgradeIndex].upgradeType)
	get_parent().visible = false
	get_tree().paused = false
