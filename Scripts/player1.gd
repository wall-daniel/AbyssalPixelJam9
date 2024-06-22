extends CharacterBody2D

signal zap

const SPEED = 300.0
const MAX_HEALTH = 100

var health = MAX_HEALTH
#controls
var p1_controls: Array = ["p1-left", "p1-right", "p1-up", "p1-down"]
var p2_controls: Array = ["p2-left", "p2-right", "p2-up", "p2-down"]
@export var is_p1 = true
var controls: Array = []

func _ready():
	if is_p1:
		controls = p1_controls
	else:
		controls = p2_controls

func _physics_process(_delta):
	var direction = Input.get_vector(controls[0], controls[1], controls[2], controls[3])
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
