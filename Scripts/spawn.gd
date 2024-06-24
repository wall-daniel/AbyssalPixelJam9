extends Marker2D

#gets the node for Enemies to place them there instead of on the spawn idk it is just cleaning but was kind of a waste of 30 minutes
@onready var enemies = $"../../Enemies"
#load the enemy scene
@onready var enemy = preload("res://Scenes/enemy.tscn")
@onready var game = $"../.."

var spawn_chance = 3

# Called when the node enters the scene tree for the first time.
#spawn on ready but we can change this to a timer/chance system with a limit on spawn or something

func try_spawn():
	if not game.limit_reached:
		randomize()
		if randi_range(1,spawn_chance) == spawn_chance:
			spawn()

#the actual instantiation of the enemy and reparenting to the Enemies node in Game scene
func spawn():
	if game.pause_spawn:
		return
	game.enemylimit -= 1
	game.enemy_onscreen += 1
	if game.enemylimit <= 0:
		game.limit_reached = true
	if game.enemy_onscreen == game.max_onscreen:
		game.pause_spawn = true
	var spawn_enemy = enemy.instantiate()
	add_child(spawn_enemy)
	spawn_enemy.reparent(enemies)

func _on_timer_timeout():
	if not game.limit_reached:
		try_spawn()
	else:
		$SpawnCD.stop()
