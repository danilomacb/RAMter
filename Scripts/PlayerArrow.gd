extends Area2D

@export var damage: float

var direction

func _process(delta):
	translate(direction * delta * 200)

func _on_area_entered(area):
	if area.get_parent().is_in_group("Enemies"):
		area.get_parent().get_node("Hp").TakeDamage(1)
