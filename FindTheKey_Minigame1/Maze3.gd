extends Spatial

signal playerWins


func _on_Goal_body_entered(body):
	emit_signal("playerWins")
