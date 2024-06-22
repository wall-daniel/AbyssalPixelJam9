extends CanvasLayer
#this is just to change the bar properties
@onready var zap_bar = $ZapBar
#set the bar to full right away
const ZAP_MAX = 7

var zap_num = 7

#set the bar value right away
func _ready():
	zap_bar.value = zap_num

#checks player one if there is a shot taken and if p1 collected a battery
func _on_player_1_change_zap(add):
	if add:
		zap_num += 3
		if zap_num > ZAP_MAX:
			zap_num = ZAP_MAX
	else:
		if zap_num > 0:
			zap_num -= 1
	zap_bar.value = zap_num

#checks player 2 if they collect anything since my code is completly jank idk man I just wanted to make some Globals oh well
func _on_player_2_change_zap(add):
	if add:
		zap_num += 3
		if zap_num > 5:
			zap_num = 5
	zap_bar.value = zap_num
