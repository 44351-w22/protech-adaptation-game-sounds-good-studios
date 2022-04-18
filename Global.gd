extends Node

<<<<<<< Updated upstream
var current_player = current_player setget set_current_player
var current_player_key = false setget set_current_player_key 
var next_player = next_player setget set_next_player

=======

var current_scene = null


func _ready():
	var root = get_tree().get_root()
	current_scene = root.get_child(root.get_child_count() - 1)
	
func goto_scene(path):
	call_deferred("_deferred_goto_scene", path)
>>>>>>> Stashed changes

func set_current_player(value):
	current_player = value

<<<<<<< Updated upstream
func set_current_player_key(value):
	current_player_key = value
=======

	var s = ResourceLoader.load(path)
>>>>>>> Stashed changes

func set_next_player(value):
	next_player = value
