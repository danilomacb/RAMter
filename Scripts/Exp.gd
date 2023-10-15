extends Area2D

@export var expType: Globals.ExpType
@export var sprite2D: Sprite2D
@export var crystalsTextures: Array[CompressedTexture2D]

@onready var expCollectedSfx: AudioStreamPlayer2D = get_node("/root/Game/ExpCollectedSfx")

var expIncrementor: int
var goToPlayer: bool = false
var player: CharacterBody2D

func _ready():
	match expType:
		Globals.ExpType.Green:
			sprite2D.texture = crystalsTextures[0]
			expIncrementor = 1
			
		Globals.ExpType.Blue:
			sprite2D.texture = crystalsTextures[1]
			expIncrementor = 2
			
		Globals.ExpType.Red:
			sprite2D.texture = crystalsTextures[2]
			expIncrementor = 3
			
		Globals.ExpType.Yellow:
			sprite2D.texture = crystalsTextures[3]
			expIncrementor = 9999

func _process(delta):
	if !goToPlayer:
		return
	
	global_position = global_position.move_toward(player.global_position, delta * 150)

func _on_body_entered(body: CharacterBody2D):
	if body.is_in_group("Player"):
		body.get_node("PlayerExp").AddExp(expIncrementor)
		expCollectedSfx.play()
		queue_free()

func _on_area_2d_body_entered(body):
	if body.is_in_group("Player"):
		player = body
		goToPlayer = true
