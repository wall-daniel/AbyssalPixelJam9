extends CharacterBody2D

const SPEED = 300.0

func _physics_process(_delta):
	var direction = Input.get_vector("p2-left", "p2-right", "p2-up", "p2-down")
	if direction:
		velocity = direction * SPEED
	else:
		velocity = Vector2(move_toward(velocity.x, 0, SPEED),move_toward(velocity.y, 0, SPEED))

	move_and_slide()
