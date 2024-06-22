extends Area2D

#checks if the body is the right one and then collects coin
func _on_body_entered(body):
	if body.has_method("collect"):
		body.collect()
		queue_free()
