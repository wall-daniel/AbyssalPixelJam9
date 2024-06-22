extends CanvasLayer

@onready var zap_bar = $ZapBar

var zap_num = 5

func _ready():
	zap_bar.value = zap_num

func _on_player_1_change_zap(add):
	if add:
		zap_num += 3
		if zap_num > 5:
			zap_num = 5
	else:
		if zap_num > 0:
			zap_num -= 1
	zap_bar.value = zap_num

func _on_player_2_change_zap(add):
	if add:
		zap_num += 3
		if zap_num > 5:
			zap_num = 5
	zap_bar.value = zap_num
