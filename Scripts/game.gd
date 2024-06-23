extends Node2D

#adding nodes
@onready var player_1 = $Players/Player1
@onready var player_2 = $Players/Player2
@onready var ui = $UI

#preload scene
var lightning = preload("res://Scenes/lightning.tscn")

#player health
const MAX_HEALTH = 100
var health = MAX_HEALTH

func _ready():
	ui.health_bar.value = 100

#add the lightning bolt
func zap():
	#check ui if player has the juice
	if ui.zap_num > 0:
		#make lightning
		var instance = lightning.instantiate()
		var hitbox = instance.get_child(0)
		hitbox.shape.a = player_1.global_position
		hitbox.shape.b = player_2.global_position
		var lightning_dist = player_1.global_position.distance_to(player_2.global_position)
		var lightning_angle = player_1.global_position.angle_to_point(player_2.global_position)
		var texture = instance.get_child(1)
		texture.region_rect = Rect2(0,0,16,lightning_dist)
		texture.global_position = player_1.global_position
		texture.offset.y = lightning_dist/2
		texture.rotation = lightning_angle - deg_to_rad(90)
		add_child(instance)

#checks p1 for input
func _on_player_1_zap():
	zap()

func hit_player(damage):
	health -= damage;
	ui.health_bar.value = health
