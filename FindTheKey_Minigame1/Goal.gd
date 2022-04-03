extends Area

signal goal_found

func _on_Goal_body_entered(body):
	emit_signal("goal_found")
