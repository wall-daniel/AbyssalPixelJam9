extends CharacterBody2D

const SPEED = 100

func _physics_process(_delta):
	var direction = find_closest() - global_position
	velocity = direction.normalized() * SPEED
	move_and_slide()

func find_closest() -> Vector2:
	var players = get_tree().get_nodes_in_group("player")
	
	var closest_player = players[0]
	
	if players[1].global_position.distance_to(global_position) < closest_player.global_position.distance_to(global_position):
		closest_player = players[1]
	
	return closest_player.global_position
