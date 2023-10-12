extends Area2D

@export var expType: Globals.ExpType
@export var sprite2D: Sprite2D
@export var crystalsTextures: Array[CompressedTexture2D]

var expIncrementor: int

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

func _on_body_entered(body: CharacterBody2D):
	if body.is_in_group("Player"):
		body.get_node("PlayerExp").AddExp(expIncrementor)
		queue_free()
