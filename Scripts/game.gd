extends Node2D

#adding nodes
@onready var player_1 = $Player1
@onready var player_2 = $Player2
@onready var ui = $UI
#preload scene
var lightning = preload("res://Scenes/lightning.tscn")

#player health
const MAX_HEALTH = 100
var health = MAX_HEALTH

#add the lightning bolt
func zap():
	#check ui if player has the juice
	if ui.zap_num > 0:
		#make lightning
		var instance = lightning.instantiate()
		instance.get_child(0).shape.a = player_1.global_position
		instance.get_child(0).shape.b = player_2.global_position
		add_child(instance)

#checks p1 for input
func _on_player_1_zap():
	zap()

func hit_player(damage):
	health -= damage;
	print('Ooof: ' + str(health))
