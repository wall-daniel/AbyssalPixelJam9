extends Area2D

#check if lightning hits and enemy
func _on_body_entered(body):
	if body.has_method("hit"):
		body.hit()

#timer to kill the lightning so it is not always up and kills everything I would never make a mistake like that hehe
func _on_timer_timeout():
	queue_free()
