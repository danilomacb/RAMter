extends Button

@export var cardResources: Array[CardResource]

@onready var titleLabel: Label = $TitleLabel
@onready var textureRect: TextureRect = $TextureRect
@onready var descriptionLabel: Label = $DescriptionLabel
@onready var cardSelectedSfx: AudioStreamPlayer2D = get_node("/root/Game/Player/CardSelectedSfx")

var upgrades = load("res://Scripts/Upgrades.gd").new()

var rng = RandomNumberGenerator.new()

var currentUpgradeIndex: int = 0

func _ready():
	var player = get_node("/root/Game/Player/PlayerExp")
	player.OnLevelUp.connect(RandomizeUpgradeCard)

func RandomizeUpgradeCard():
	currentUpgradeIndex = rng.randi_range(0, cardResources.size() - 1)
	
	if Globals.InstantiatedCardsIndexes.size() > 0:
		var i: int = 0
		while i < Globals.InstantiatedCardsIndexes.size(): 
			if Globals.InstantiatedCardsIndexes[i] == cardResources[currentUpgradeIndex].upgradeType:
				currentUpgradeIndex = rng.randi_range(0, cardResources.size() - 1)
				i = 0
			else:
				i += 1
	
	titleLabel.text = cardResources[currentUpgradeIndex].title
	textureRect.texture = cardResources[currentUpgradeIndex].texture
	descriptionLabel.text = cardResources[currentUpgradeIndex].description
	
	Globals.InstantiatedCardsIndexes.push_back(cardResources[currentUpgradeIndex].upgradeType)

func _on_pressed():
	upgrades.AddUpgrade(cardResources[currentUpgradeIndex].upgradeType)
	get_parent().visible = false
	Globals.ShowingLvUpPanel = false
	Globals.InstantiatedCardsIndexes.clear()
	cardSelectedSfx.play()
	
	if !Globals.GamePaused:
		get_tree().paused = false
