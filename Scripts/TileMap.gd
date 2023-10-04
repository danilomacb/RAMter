extends TileMap

@export var player: CharacterBody2D
@onready var cameraZoom: Vector2 = player.get_node("Camera2D").zoom

var width = ProjectSettings.get_setting("display/window/size/viewport_width")
var height = ProjectSettings.get_setting("display/window/size/viewport_height")

@onready var tilesDistanceX = (width / (16 * cameraZoom.x)) / 2
@onready var tilesDistanceY = (height / (16 * cameraZoom.y)) / 2

func _process(delta):
	var firsTileCoord = Vector2i(player.global_position.x - tilesDistanceX, player.global_position.y - tilesDistanceY)
	
	for i in tilesDistanceX * 2:
		var tileCoord: Vector2i = Vector2i(firsTileCoord.x + i, firsTileCoord.y)
		var tile = get_cell_tile_data(0, tileCoord, false)
		if !tile:
			set_cell(0, tileCoord, 1, Vector2.ZERO, 0)
		
	
	
