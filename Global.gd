extends Node

var current_scene = null

var current_player = current_player setget set_current_player
var next_player = next_player setget set_next_player
var current_player_key = false setget set_current_player_key
var map1_found = false setget set_map1_found
var map2_found = false setget set_map2_found
var map3_found = false setget set_map3_found
var map4_found = false setget set_map4_found
var map5_found = false setget set_map5_found

func _ready():
	var root = get_tree().get_root()
	current_scene = root.get_child(root.get_child_count() - 1)
	
func goto_scene(path):
	call_deferred("_deferred_goto_scene", path)

func _deferred_goto_scene(path):
	
	current_scene.free()

	
	var s = ResourceLoader.load(path)

	current_scene = s.instance()

	get_tree().get_root().add_child(current_scene)

	get_tree().set_current_scene(current_scene)

func set_map1_found(value):
	map1_found = value
func set_map2_found(value):
	map2_found = value
func set_map3_found(value):
	map3_found = value
func set_map4_found(value):
	map4_found = value
func set_map5_found(value):
	map5_found = value
func set_current_player(value):
	current_player = value
func set_next_player(value):
	next_player = value
func set_current_player_key(value):
	current_player_key = value
