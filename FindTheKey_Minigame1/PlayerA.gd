extends KinematicBody
class_name HedgePlayer

#following this guide: https://www.youtube.com/watch?v=LnUh6j28cEs

export var move_speed = 10.0
export var rotate_speed = 3.0

func _physics_process(delta):
	var z_movement = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	var rotate = Input.get_action_strength("ui_left") - Input.get_action_strength("ui_right")
	
	rotation.y += rotate * rotate_speed * delta
	var direction = Vector3(0, 0, 1).rotated(Vector3(0,1,0), rotation.y)
	var motion = direction * z_movement * delta * move_speed
	move_and_collide(motion)
