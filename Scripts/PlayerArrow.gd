extends Area2D

@export var damage: float

@onready var penetratorCounter = Globals.UpgradePenetratorCounter

var direction: Vector2

func _process(delta):
	translate(direction * delta * 200)

func _on_area_entered(area):
	if area.get_parent().is_in_group("Enemies"):
		area.get_parent().get_node("Hp").TakeDamage(1)
		
		penetratorCounter -= 1
		
		if penetratorCounter < 0:
			queue_free()
