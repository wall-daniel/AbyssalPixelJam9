extends CharacterBody2D

signal zap(int)

const SPEED = 300.0
const MAX_HEALTH = 100

var health = MAX_HEALTH
var invulnerable = false
var num_enemies_touching = 0
#controls
var p1_controls: Array = ["p1-left", "p1-right", "p1-up", "p1-down"]
var p2_controls: Array = ["p2-left", "p2-right", "p2-up", "p2-down"]
@export var is_p1 = true
var controls: Array = []
var n_zap = 5

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
		if n_zap > 0:
			n_zap -= 1
			zap.emit(n_zap)

	move_and_slide()

func _on_enemy_intersect(damage):
	num_enemies_touching += 1
	
	if not invulnerable:
		hit(damage)

func _on_enemy_stop_intersect():
	num_enemies_touching -= 1

func hit(damage):
	if not invulnerable:
		health -= damage;
		
		$invulnerability.start()
		invulnerable = true
		print('Ooof: ' + str(health))
		print('Intersections: ' + str(num_enemies_touching))


func _on_invulnerability_timeout():
	invulnerable = false
	
	if num_enemies_touching > 0:
		hit(10)
