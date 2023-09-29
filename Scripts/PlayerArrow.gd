extends RigidBody2D

func _on_area_2d_body_entered(body):
	print(body)
	if body.is_in_group("Enemies"):
		print("Enemy")
