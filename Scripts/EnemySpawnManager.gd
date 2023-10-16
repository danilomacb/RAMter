extends Node

@export var timer: Timer

@onready var camera: Camera2D = get_node("/root/Game/Player/Camera2D")

var enemys: Array[PackedScene] = [
	load("res://Prefabs/Enemies/Enemy.tscn"), 
	load("res://Prefabs/Enemies/Tiilibra.tscn"), 
	load("res://Prefabs/Enemies/NaoConhecido.tscn"),
	load("res://Prefabs/Enemies/Jabs.tscn")
]

var width = ProjectSettings.get_setting("display/window/size/viewport_width")
var height = ProjectSettings.get_setting("display/window/size/viewport_height")

var rng = RandomNumberGenerator.new()
var canSpawnEnemy: bool = true
var time: float = 0.0

const margin = 5

func _ready():
	SpawnEnemys()

func _process(delta):
	time += delta

func SpawnEnemys():
	if !canSpawnEnemy:
		return
	
	canSpawnEnemy = false
	timer.wait_time = 1 - (time / 10) * 0.1
	
	if timer.wait_time < 0.1:
		timer.wait_time = 0.1
	
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
	
	var chance = [96, 98, 99]
	
	chance[0] = 96 - int(time / 5) - int(time / 10) 
	chance[1] = 98 - int(time / 5)
	
	if chance[0] < 5:
		chance[0] = 5
	
	if chance[1] < 15:
		chance[1] = 15
		
	if randomEnemyIndex < chance[0]:
		return enemys[0]
	
	if randomEnemyIndex < chance[1]:
		return enemys[1]
	
	if randomEnemyIndex < chance[2]:
		return enemys[2]
		
	return enemys[3]

func _on_timer_timeout():
	canSpawnEnemy = true
	SpawnEnemys()
