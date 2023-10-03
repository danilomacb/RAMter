extends Area2D

func _on_body_entered(body: CharacterBody2D):
	if body.is_in_group("Player"):
		body.get_node("PlayerExp").AddExp()
		queue_free()
