extends Node

onready var cam = $GameCam
onready var p1 = $Player1
onready var dice = $CanvasLayer/Dice_Roller
onready var totalDiceRoll = dice.totalRoll
onready var currentPlayer = p1
onready var nextPlayer = p1

func _ready():
	move_camera(p1)

func move_camera(p):
	cam.get_parent().remove_child(cam)
	p.add_child(cam)

func _on_Player1_Collision():
	var tile_coord = $TileMap.world_to_map($Player1.global_position)
	var tile_index = $TileMap.get_cellv(tile_coord)
	var tile = $TileMap.tile_set.tile_get_name(tile_index)
	
	if tile == "Light Gray Brick Floor.png 0":
		print("gray")
	elif tile == "Pale Blue Brick Floor.png 1":
		print("blue")
	elif tile == "Purple Brick Floor.png 2":
		print("purple")
	elif tile == "Red Brick Floor.png 3":
		print("red")
	elif tile == "Yellow Brick Floor.png 4":
		print("yellow")

func player_turn():
	dice.visible = true

func _on_Button_pressed():
	yield(get_tree().create_timer(2.0), "timeout")
	dice.visible = false
	totalDiceRoll = dice.totalRoll
	currentPlayer.movesLeft = totalDiceRoll

func _on_EndTurn_pressed():
	currentPlayer = nextPlayer
	nextPlayer = currentPlayer
	move_camera(currentPlayer)
	player_turn()
