extends CanvasLayer

@onready var zap_bar = $ZapBar

var zap_num = 5

func _ready():
	zap_bar.value = zap_num

func _on_player_1_zap(n_zap):
	zap_bar.value = n_zap
