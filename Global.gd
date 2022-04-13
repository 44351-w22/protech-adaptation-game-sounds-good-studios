extends Node

var current_player = current_player setget set_current_player
var current_player_key = false setget set_current_player_key 
var next_player = next_player setget set_next_player


func set_current_player(value):
	current_player = value

func set_current_player_key(value):
	current_player_key = value

func set_next_player(value):
	next_player = value
