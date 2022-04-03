extends Spatial

signal playerWins


func _on_Goal_goal_found():
	emit_signal("playerWins")
