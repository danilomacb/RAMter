extends Node

var enemy = load("res://Prefabs/Enemy.tscn")
var player = load("res://Prefabs/Player.tscn")
@onready var cameraPos = get_node("/root/Game/Player/Camera2D").global_position

var width = ProjectSettings.get_setting("display/window/size/viewport_width")
var height = ProjectSettings.get_setting("display/window/size/viewport_height")

func _ready():
	var pos = Vector2(cameraPos.x, cameraPos.y - height / 2 - 10)
	var instantiatedEnemy = enemy.instantiate()
	instantiatedEnemy.global_position = pos
	
	add_child(instantiatedEnemy)
