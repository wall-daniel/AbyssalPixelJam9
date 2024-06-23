extends CanvasLayer
#this is just to change the bar properties
@onready var zap_bar = $ZapBar
#set the bar to full right away
const ZAP_MAX = 7

var zap_num = 7
#load all the different sprites for the zap meter
var zap_meter = [Rect2(236,2,8,29), Rect2(204,2,8,29), Rect2(172,2,8,29), Rect2(140,2,8,29),Rect2(108,2,8,29), Rect2(76,2,8,29), Rect2(44,2,8,29),Rect2(12,2,8,29)]
#set the bar value right away,
func _ready():
	zap_bar.texture.region = zap_meter[zap_num]

#checks player one if there is a shot taken and if p1 collected a battery
func _on_player_1_change_zap(add):
	if add:
		zap_num += 3
		if zap_num > ZAP_MAX:
			zap_num = ZAP_MAX
	else:
		if zap_num > 0:
			zap_num -= 1
	zap_bar.texture.region = zap_meter[zap_num]

#checks player 2 if they collect anything since my code is completly jank idk man I just wanted to make some Globals oh well
func _on_player_2_change_zap(add):
	if add:
		zap_num += 3
		if zap_num > ZAP_MAX:
			zap_num = ZAP_MAX
	zap_bar.texture.region = zap_meter[zap_num]

# From charging station
func _on_charging_station_charge_battery():
	zap_num += 1
	zap_bar.texture.region = zap_meter[zap_num]
