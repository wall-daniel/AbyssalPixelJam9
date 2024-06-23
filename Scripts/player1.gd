extends CharacterBody2D

#signal moment
signal zap()
signal change_zap(add)
#constant moment
const SPEED = 300.0
#controls
var p1_controls: Array = ["p1-left", "p1-right", "p1-up", "p1-down"]
var p2_controls: Array = ["p2-left", "p2-right", "p2-up", "p2-down"]
@export var is_p1 = true
var controls: Array = []
var n_zap = 5
#car for sprite depending on player
var moving: Node
#death mechanics
var is_dead = false

func _ready():
	#check to see what controls to use
	if is_p1:
		moving = $Player1
		$Player2.visible = false
		controls = p1_controls
	else:
		moving = $Player2
		$Player1.visible = false
		controls = p2_controls

func _physics_process(_delta):
	if is_dead:
		return
	#basic movement
	var direction = Input.get_vector(controls[0], controls[1], controls[2], controls[3])
	if direction:
		moving.play("move")
		velocity = direction * SPEED
		rotation = velocity.angle() + deg_to_rad(90)
	else:
		moving.stop()
		velocity = Vector2(move_toward(velocity.x, 0, SPEED),move_toward(velocity.y, 0, SPEED))
	move_and_slide()
	#ZAP
	if Input.is_action_just_pressed("zap"):
		zap.emit()
		change_zap.emit(false)

#collecting the battery
func collect():
	change_zap.emit(true)

func game_over():
	is_dead = true
	moving.play("death")
