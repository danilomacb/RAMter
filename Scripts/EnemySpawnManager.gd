extends Node

@onready var camera = get_node("/root/Game/Player/Camera2D")
@onready var timer = $Timer

var enemys: Array[PackedScene] = [load("res://Prefabs/Enemy.tscn"), load("res://Prefabs/Tiilibra.tscn")]

var width = ProjectSettings.get_setting("display/window/size/viewport_width")
var height = ProjectSettings.get_setting("display/window/size/viewport_height")

var rng = RandomNumberGenerator.new()
var canSpawnEnemy = true

const margin = 5

func _process(delta):
	SpawnEnemys()

func SpawnEnemys():
	if !canSpawnEnemy:
		return
	
	canSpawnEnemy = false
	timer.start()
	
	var instantiatedEnemy = GetRandomEnemy().instantiate()
	instantiatedEnemy.global_position = GetRandomEnemyPos()
	add_child(instantiatedEnemy)

func GetRandomEnemyPos() -> Vector2:
	var randomScreenSide = rng.randi_range(0, 3)
	var pos = Vector2.ZERO
	
	match randomScreenSide:
		0:
			var randomScreenPos = rng.randi_range((width / 2) * -1, width / 2)
			pos = Vector2(randomScreenPos, camera.global_position.y - height / 2 - margin)
		1:
			var randomScreenPos = rng.randi_range((width / 2) * -1, width / 2)
			pos = Vector2(randomScreenPos, camera.global_position.y + height / 2 + margin)
		2:
			var randomScreenPos = rng.randi_range((height / 2) * -1, height / 2)
			pos = Vector2(camera.global_position.x - (width / 2) - margin, randomScreenPos)
		3:
			var randomScreenPos = rng.randi_range((height / 2) * -1, height / 2)
			pos = Vector2(camera.global_position.x + (width / 2) + margin, randomScreenPos)
			
	return pos

func GetRandomEnemy() -> PackedScene:
	var randomEnemyIndex = rng.randi_range(0, 99)
	
	if randomEnemyIndex < 94:
		return enemys[0]
	
	return enemys[1]

func _on_timer_timeout():
	canSpawnEnemy = true
