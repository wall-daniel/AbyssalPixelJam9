extends Marker2D

@onready var enemy = preload("res://Scenes/enemy.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	print(global_position)
	spawn()


func spawn():
	var spawn_enemy = enemy.instantiate()
	add_child(spawn_enemy)
