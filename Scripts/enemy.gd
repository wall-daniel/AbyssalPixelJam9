extends CharacterBody2D

const SPEED = 100
@export var health = 2
#stunned
var is_stunned:bool = false
@onready var stuntime = $Stuntime

func _physics_process(_delta):
	if not is_stunned:
		var direction = find_closest() - global_position
		velocity = direction.normalized() * SPEED
		move_and_slide()

func find_closest() -> Vector2:
	var players = get_tree().get_nodes_in_group("player")
	
	var closest_player = players[0]
	
	if players[1].global_position.distance_to(global_position) < closest_player.global_position.distance_to(global_position):
		closest_player = players[1]
	
	return closest_player.global_position

func death():
	queue_free()

func hit():
	health -= 1
	if health == 0:
		death()
	is_stunned = true
	stuntime.start()

func _on_hurt_box_body_entered(body):
	body._on_enemy_intersect(10)

func _on_hurt_box_body_exited(body):
	body._on_enemy_stop_intersect()

func _on_stuntime_timeout():
	is_stunned = false
