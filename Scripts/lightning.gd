extends Area2D

func _on_body_entered(body):
	if body.has_method("hit"):
		body.hit()

func _on_timer_timeout():
	queue_free()
