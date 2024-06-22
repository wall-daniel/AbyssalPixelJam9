extends Node2D

signal charge_battery()

var players_intersected = []

# Player entering charging station
func _on_area_2d_body_entered(body):
	if not (body.name == 'Player1' or body.name == 'Player2'):
		return
		
	players_intersected.push_front(body)
	print('Player entering charging station')
	
	# Check if both players inside
	if len(players_intersected) == 2:
		print('Both players in charging station')
		$ChargingTimer.start()

# Player no longer in charging station
func _on_area_2d_body_exited(body):
	if not (body.name == 'Player1' or body.name == 'Player2'):
		return
		
	var player_idx = players_intersected.find(body)
	if player_idx != -1:
		print('Player leaving charging station')
		players_intersected.remove_at(player_idx)
		$ChargingTimer.stop()

# Charge the battery
func _on_charging_timer_timeout():
	print('Charging battery...')
	charge_battery.emit()
