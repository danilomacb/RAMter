extends RigidBody2D

@export var damage: float

func _on_area_2d_body_entered(body):
	if body.is_in_group("Enemies"):
		body.get_node("Hp").TakeDamage(1)
