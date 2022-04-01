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
signal Collision
var start_Position_x = 608
var start_Position_y = 96

func _ready():
	position.x = start_Position_x
	position.y = start_Position_y

func move(dir):
	rayDown.cast_to = inputs[dir] * tile_size
	rayDown.force_raycast_update()
	if !rayDown.is_colliding():
		move_tween(dir)
		
	#if $CollisionShape2D.position.x != start_Position_x or $CollisionShape2D.position.y != start_Position_y:
		#emit_signal("Collision")
		
		
func move_tween(dir):
	tween.interpolate_property(self, "position", position, position + inputs[dir] * tile_size, 1.0/speed, tween.TRANS_SINE, tween.EASE_IN_OUT)
	tween.start()
	
func _unhandled_input(event):
	if tween.is_active():
		return
	for dir in inputs.keys():
		if event.is_action_pressed(dir):
			move(dir)
			

func _process(delta):
	if $CollisionShape2D.position.x != start_Position_x or $CollisionShape2D.position.y != start_Position_y:
		emit_signal("Collision")


