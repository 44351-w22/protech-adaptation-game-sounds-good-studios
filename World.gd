extends Node

onready var cam = $GameCam
onready var p1 = $Player1


func _ready():
	move_camera(p1)

func move_camera(p):
	cam.get_parent().remove_child(cam)
	p.add_child(cam)



func _on_Player1_Collision():
	var playerX = $Player1/CollisionShape2D.global_position.x
	var playerY = $Player1/CollisionShape2D.global_position.y
	var tile_coord = $TileMap.world_to_map($Player1.global_position)
	var tile_index = $TileMap.get_cellv(tile_coord)
	var tile = $TileMap.tile_set.tile_get_name(tile_index)
	print(tile)
	#var tile_name = $TileMap.tile_set.tile_get_name(tile_id)
	#print(tile_name)
