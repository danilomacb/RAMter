extends Area2D

@export var damage: float

@onready var collisionShape2d: CollisionShape2D = $CollisionShape2D
@onready var penetratorCounter: int = Globals.UpgradePenetratorCounter
@onready var reflectorCounter: int = Globals.UpgradeReflectorCounter
@onready var camera: Camera2D = get_node("/root/Game/Player/Camera2D")

@onready var width = ProjectSettings.get_setting("display/window/size/viewport_width") / camera.zoom.x / 2
@onready var height = ProjectSettings.get_setting("display/window/size/viewport_height") / camera.zoom.y / 2

var direction: Vector2

func _process(delta):
	translate(direction * delta * 200)

func _on_area_entered(area):
	if area.get_parent().is_in_group("Enemies"):
		area.get_parent().get_node("Hp").TakeDamage(1)
		
		penetratorCounter -= 1
		
		if penetratorCounter < 0:
			queue_free()

func _on_visible_on_screen_notifier_2d_screen_exited():
	if Globals.UpgradeReflectorCounter > 0:
		if reflectorCounter <= 0:
			queue_free()

		if global_position.x > camera.global_position.x + width || global_position.x < camera.global_position.x - width:
			direction = Vector2(direction.x * -1, direction.y)
		
		if global_position.y < camera.global_position.y - height || global_position.y > camera.global_position.y + height:
			direction = Vector2(direction.x, direction.y * -1)
		
		var newRotation = atan2(direction.y, direction.x)
		rotation = newRotation
		
		reflectorCounter -= 1
