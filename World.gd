extends Node

onready var cam = $GameCam
onready var p1 = $Player1


func _ready():
	move_camera(p1)

func move_camera(p):
	cam.get_parent().remove_child(cam)
	p.add_child(cam)
