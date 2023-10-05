extends TileMap

@export var player: CharacterBody2D
@onready var cameraZoom: Vector2 = player.get_node("Camera2D").zoom

var width = ProjectSettings.get_setting("display/window/size/viewport_width")
var height = ProjectSettings.get_setting("display/window/size/viewport_height")

@onready var tilesDistanceX = (width / (16 * cameraZoom.x)) / 2
@onready var tilesDistanceY = (height / (16 * cameraZoom.y)) / 2

var oldPlayerPos := Vector2.ZERO

func _process(delta):
	GenerateTiles()

func GenerateTiles():
	var playerPos := player.global_position
	
	if playerPos.y > oldPlayerPos.y:
		GenerateTilesDown(playerPos)
	if playerPos.y < oldPlayerPos.y:
		GenerateTilesUp(playerPos)
		
	if playerPos.x > oldPlayerPos.x:
		GenerateTilesRight(playerPos)
	if playerPos.x < oldPlayerPos.x:
		GenerateTilesLeft(playerPos)
	
	oldPlayerPos = playerPos

func GenerateTilesDown(playerPos):
	var playerPosDifY = playerPos.y - oldPlayerPos.y
	
	for i in playerPosDifY:
		var firsTileCoord = Vector2i(playerPos.x / 16  - tilesDistanceX - 1, (oldPlayerPos.y / 16 + i + tilesDistanceY))
		SetTilesHorizontally(firsTileCoord)

func GenerateTilesUp(playerPos):
	var playerPosDifY = oldPlayerPos.y - playerPos.y
	
	for i in playerPosDifY:
		var firsTileCoord = Vector2i(playerPos.x / 16 - tilesDistanceX - 1, (oldPlayerPos.y / 16 - i) - tilesDistanceY)
		SetTilesHorizontally(firsTileCoord)

func SetTilesHorizontally(firsTileCoord):
	for i in (tilesDistanceX * 2) + 1:
		var tileCoord: Vector2i = Vector2i(firsTileCoord.x + i, firsTileCoord.y)
		
		var tile = get_cell_tile_data(0, tileCoord, false)
		if !tile:
			set_cell(0, tileCoord, 1, Vector2i.ZERO, 0)

func GenerateTilesRight(playerPos):
	var playerPosDifX = playerPos.x - oldPlayerPos.x
	
	for i in playerPosDifX:
		var firsTileCoord = Vector2i(playerPos.x / 16 + i + tilesDistanceX + 1, (oldPlayerPos.y / 16 + tilesDistanceY))
		SetTilesVertically(firsTileCoord)

func GenerateTilesLeft(playerPos):
	var playerPosDifX = oldPlayerPos.x - playerPos.x
	
	for i in playerPosDifX:
		var firsTileCoord = Vector2i(playerPos.x / 16 - i - tilesDistanceX + 1, (oldPlayerPos.y / 16 + tilesDistanceY))
		SetTilesVertically(firsTileCoord)

func SetTilesVertically(firsTileCoord):
	for i in (tilesDistanceY * 2) + 1:
		var tileCoord: Vector2i = Vector2i(firsTileCoord.x, firsTileCoord.y - i)
		
		var tile = get_cell_tile_data(0, tileCoord, false)
		if !tile:
			set_cell(0, tileCoord, 1, Vector2i.ZERO, 0)
