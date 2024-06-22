extends CharacterBody2D

signal zap

const SPEED = 300.0
const MAX_HEALTH = 100

var health = MAX_HEALTH

func _physics_process(_delta):
	var direction = Input.get_vector("p1-left", "p1-right", "p1-up", "p1-down")
	if direction:
		velocity = direction * SPEED
	else:
		velocity = Vector2(move_toward(velocity.x, 0, SPEED),move_toward(velocity.y, 0, SPEED))
	if Input.is_action_just_pressed("zap"):
		zap.emit()

	move_and_slide()

func hit(damage):
	health -= damage;
	print('oof')
	print('Current health: ' + str(health))
