extends CharacterBody2D

#enemy stat
@onready var speed = Globals.enemy_speed
@export var health = 2
var can_hit = false

#stunned
var is_stunned:bool = true
@onready var stuntime = $Stuntime

#get battery drop
var battery_scene = preload("res://Scenes/pickup.tscn")
@onready var battery_node = $"../../../Battery"

#tell game to hit player
signal enemy_attack(damage)

#animated sprite
@onready var squirt = $Squirt

#tell game that enemy has died
signal enemy_died

func _ready():
	$Spawn.play()
	squirt.play("spawn")
	await squirt.animation_finished
	is_stunned = false
	can_hit = true
	squirt.play("idle")

func _physics_process(_delta):
	#player movement
	if not is_stunned:
		var direction = find_closest() - global_position
		velocity = direction.normalized() * speed
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
	get_node("../../").enemy_died()
	$CollisionShape2D.disabled = true
	can_hit = false
	squirt.play("death")
	await squirt.animation_finished
	drop()
	queue_free()

#checking the drop chance
func drop():
	randomize()
	var drop_chance = randi_range(1,5)
	if drop_chance == 5:
		var battery = battery_scene.instantiate()
		add_child(battery)
		battery.reparent(battery_node)

#enemy hit
func hit():
	$AnimationPlayer.play("hit")
	is_stunned = true
	health -= 1
	if health == 0:
		call_deferred("death")
	else:
		squirt.animation = "stunned"
		stuntime.start()

var intersected_players = []
var ready_to_attack = true

#idk what Danny did here
func _on_hurt_box_body_entered(body):
	# Set current player
	if not body in intersected_players:
		intersected_players.push_front(body)
	
	# Check if they can attack
	if ready_to_attack and can_hit:
		get_node("../../").hit_player(10)
		
	# Set timer
	$AttackTimer.start()

func _on_hurt_box_body_exited(body):
	# Remove player from intersected
	var body_idx = intersected_players.find(body)
	if body_idx != -1:
		intersected_players.remove_at(body_idx)

#stun cooldown
func _on_stuntime_timeout():
	if health > 0:
		squirt.animation = "hurt_idle"
		is_stunned = false

# Attack timer
func _on_attack_timer_timeout():
	# Check if still intersecting with a player
	if len(intersected_players) != 0:
		get_node("../../").hit_player(10)
		
		# Reset timer
		$AttackTimer.start()
