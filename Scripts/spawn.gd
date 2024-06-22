extends Marker2D

#gets the node for Enemies to place them there instead of on the spawn idk it is just cleaning but was kind of a waste of 30 minutes
@onready var enemies = $"../../Enemies"
#load the enemy scene
@onready var enemy = preload("res://Scenes/enemy.tscn")

# Called when the node enters the scene tree for the first time.
#spawn on ready but we can change this to a timer/chance system with a limit on spawn or something
func _ready():
	spawn()

#the actual instantiation of the enemy and reparenting to the Enemies node in Game scene
func spawn():
	var spawn_enemy = enemy.instantiate()
	add_child(spawn_enemy)
	spawn_enemy.reparent(enemies)
