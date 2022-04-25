extends KinematicBody2D

const speed = 3
const tile_size = 64
onready var rayDown = $Down


onready var tween = $Tween
var inputs = {"ui_right": Vector2.RIGHT,
"ui_left": Vector2.LEFT,
"ui_up": Vector2.UP,
"ui_down": Vector2.DOWN}
signal Collision
var start_Position_x = 608
var start_Position_y = 96

export var movesLeft = 0
export var map1_found = false
export var map2_found = false
export var map3_found = false
export var map4_found = false
export var map5_found = false
export var small_key_found = false
export var main_key_found = false
export var totalMapsFound = 0

func _ready():
	position.x = start_Position_x
	position.y = start_Position_y


func move(dir):
	if movesLeft > 0:
		$MoveSound.play()
		rayDown.cast_to = inputs[dir] * tile_size
		rayDown.force_raycast_update()
		if !rayDown.is_colliding():
			move_tween(dir)
			movesLeft -= 1
		if movesLeft == 0:
			emit_signal("Collision")
		
		
func move_tween(dir):
	tween.interpolate_property(self, "position", position, position + inputs[dir] * tile_size, 1.0/speed, tween.TRANS_SINE, tween.EASE_IN_OUT)
	tween.start()
	
func _unhandled_input(event):
	if tween.is_active():
		return
	for dir in inputs.keys():
		if event.is_action_pressed(dir):
			move(dir)
				
			
