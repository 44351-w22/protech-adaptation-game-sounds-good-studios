extends Node

onready var cam = $GameCam
onready var p1 = $Player1
onready var p2 = $Player2
onready var p3 = $Player3
onready var p4 = $Player4
onready var p1Sprite = $Player1/Sprite
onready var p2Sprite = $Player2/Sprite
onready var p3Sprite = $Player3/Sprite
onready var p4Sprite = $Player4/Sprite
onready var dice = $CanvasLayer/Dice_Roller
onready var totalDiceRoll = dice.totalRoll
onready var currentPlayer = Global.current_player
onready var nextPlayer = Global.next_player

onready var packed_scene = PackedScene.new()

var skins = [preload("res://assets/players/pieceGreen_single00.png"), 
			preload("res://assets/players/piecePurple_single01.png"), 
			preload("res://assets/players/pieceBlue_single18.png"),
			preload("res://assets/players/pieceRed_single01.png"),
			preload("res://assets/players/pieceWhite_single00.png"),
			preload("res://assets/players/pieceYellow_single00.png")]


func _ready():
	p1Sprite.texture = skins[0]
	p2Sprite.texture = skins[1]
	p3Sprite.texture = skins[2]
	p4Sprite.texture = skins[4]
	currentPlayer = p1
	nextPlayer = p2
	move_camera(p1)
	

func move_camera(p):
	cam.get_parent().remove_child(cam)
	p.add_child(cam)


func _on_Player1_Collision():
	yield(get_tree().create_timer(1.0), "timeout")
	call_deferred("detect")

func detect():
	print(currentPlayer.global_position)
	var tile_coord = $TileMap.world_to_map(currentPlayer.global_position)
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
		packed_scene.pack(get_tree().get_current_scene())
		ResourceSaver.save("res://World.tscn", packed_scene)
		Global.goto_scene("res://FindTheKey_Minigame1/FindTheKey.tscn")
		

func player_turn():
	dice.visible = true
	if(Global.current_player_key == true):
		currentPlayer.key = true
		Global.current_player_key = false

func _on_Button_pressed():
	yield(get_tree().create_timer(2.0), "timeout")
	dice.visible = false
	totalDiceRoll = dice.totalRoll
	currentPlayer.movesLeft = totalDiceRoll

func _on_EndTurn_pressed():
	currentPlayer.movesLeft = 0
	currentPlayer = nextPlayer
	if currentPlayer == p1:
		nextPlayer = p2
	elif currentPlayer == p2:
		nextPlayer = p3
	elif currentPlayer == p3:
		nextPlayer = p4
	elif currentPlayer == p4:
		nextPlayer = p1
	else:
		print("error")
	move_camera(currentPlayer)
	player_turn()
