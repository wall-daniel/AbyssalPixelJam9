extends Node2D

signal charge_battery()

var players_intersected = []

func _ready():
	$Sprite2D.frame = 0

# Player entering charging station
func _on_area_2d_body_entered(body):
	if not body.is_in_group("player"):
		return
		
	players_intersected.push_front(body)
	
	# Check if both players inside
	if len(players_intersected) == 2:
		$Sprite2D.frame = 1
		$ChargingTimer.start()

# Player no longer in charging station
func _on_area_2d_body_exited(body):
	if not body.is_in_group("player"):
		return
		
	var player_idx = players_intersected.find(body)
	if player_idx != -1:
		players_intersected.remove_at(player_idx)
		$Sprite2D.frame = 0
		$ChargingTimer.stop()

# Charge the battery
func _on_charging_timer_timeout():
	charge_battery.emit()
