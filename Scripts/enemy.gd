extends CharacterBody2D
#enemy stat
const SPEED = 100
@export var health = 2
#stunned
var is_stunned:bool = false
@onready var stuntime = $Stuntime

#get battery drop
var battery_scene = preload("res://Scenes/pickup.tscn")
@onready var battery_node = $"../../../Battery"

func _physics_process(_delta):
	#player movement
	if not is_stunned:
		var direction = find_closest() - global_position
		velocity = direction.normalized() * SPEED
		move_and_slide()

#looks for closest player called in physics process
func find_closest() -> Vector2:
	var players = get_tree().get_nodes_in_group("player")
	
	var closest_player = players[0]
	
	if players[1].global_position.distance_to(global_position) < closest_player.global_position.distance_to(global_position):
		closest_player = players[1]
	
	return closest_player.global_position

#dying moment
func death():
	queue_free()

#checking the drop chance
func drop():
	randomize()
	var drop_chance = randi_range(1,5)
	if drop_chance == 5:
		var battery = battery_scene.instantiate()
		add_child(battery)
		battery.reparent(battery_node)
	death()

#enemy hit
func hit():
	health -= 1
	if health == 0:
		call_deferred("drop")
	is_stunned = true
	stuntime.start()

#idk what Danny did here
func _on_hurt_box_body_entered(body):
	body._on_enemy_intersect(10)

func _on_hurt_box_body_exited(body):
	body._on_enemy_stop_intersect()

#stun cooldown
func _on_stuntime_timeout():
	is_stunned = false
