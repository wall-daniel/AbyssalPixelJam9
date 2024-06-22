extends Node2D

@onready var player_1 = $Player1
@onready var player_2 = $Player2

var lightning = preload("res://Scenes/lightning.tscn")

func zap():
	var instance = lightning.instantiate()
	instance.get_child(0).shape.a = player_1.global_position
	instance.get_child(0).shape.b = player_2.global_position
	add_child(instance)

func _on_player_1_zap(_n_zap):
	zap()
