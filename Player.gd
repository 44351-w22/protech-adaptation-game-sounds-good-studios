extends KinematicBody2D

const speed = 3
const tile_size = 64
onready var rayDown = $Down
onready var rayLeft = $Left
onready var rayRight = $Right
onready var rayUp = $Up
onready var tween = $Tween
var inputs = {"ui_right": Vector2.RIGHT,
"ui_left": Vector2.LEFT,
"ui_up": Vector2.UP,
"ui_down": Vector2.DOWN}

func _ready():
	position.x = 608
	position.y = 96

func move(dir):
	rayDown.cast_to = inputs[dir] * tile_size
	rayDown.force_raycast_update()
	if !rayDown.is_colliding():
		move_tween(dir)
		
func move_tween(dir):
	tween.interpolate_property(self, "position", position, position + inputs[dir] * tile_size, 1.0/speed, tween.TRANS_SINE, tween.EASE_IN_OUT)
	tween.start()
	
func _unhandled_input(event):
	if tween.is_active():
		return
	for dir in inputs.keys():
		if event.is_action_pressed(dir):
			move(dir)
