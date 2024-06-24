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
var is_dead = false
var immune = false

#limit enemies
var enemy_max = 15
var enemylimit = enemy_max
var enemy_killed = 0
var limit_reached = false

#scoring system
var score: int = 0
var score_mult: float = 1.0

func _ready():
	ui.update_score(score)
	ui.health_bar.value = health
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
	if is_dead or immune:
		return
	health -= damage;
	ui.health_bar.value = health
	if health <= 0:
		is_dead = true
		player_1.game_over()
		player_2.game_over()
		return
	player_1.play_immune()
	player_2.play_immune()
	immune = true
	$Players/Iframes.start()

func _on_iframes_timeout():
	immune = false

func enemy_died():
	score_points(100)
	enemy_killed += 1
	if enemy_killed == enemy_max:
		win()

func win():
	score_points(1000)
	print("you win")

func score_points(points):
	score += int(points * score_mult)
	ui.update_score(score)
