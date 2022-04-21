extends Node

onready var cam = $Player1/GameCam
onready var p1 = $Player1
onready var p2 = $Player2
onready var p3 = $Player3
onready var p4 = $Player4
onready var p1Sprite = $Player1/Sprite
onready var p2Sprite = $Player2/Sprite
onready var p3Sprite = $Player3/Sprite
onready var p4Sprite = $Player4/Sprite
onready var dice = $CanvasLayer/Dice_Roller
onready var diceContainer = $CanvasLayer/Dice_Roller/Container
onready var totalDiceRoll = dice.totalRoll
onready var currentPlayer = Global.current_player
onready var nextPlayer = Global.next_player
onready var music = $SoundEffects/Music
onready var laugh = $SoundEffects/Laugh
onready var cheer = $SoundEffects/Cheer
onready var playerLabel = $CanvasLayer/CurrentPlayer
var rng = RandomNumberGenerator.new()
var map = 0
var hidden = false
var onMainMenu = true

var skins = [preload("res://assets/players/pieceGreen_single00.png"), 
			preload("res://assets/players/piecePurple_single01.png"), 
			preload("res://assets/players/pieceBlue_single18.png"),
			preload("res://assets/players/pieceRed_single01.png"),
			preload("res://assets/players/pieceWhite_single00.png"),
			preload("res://assets/players/pieceYellow_single00.png")]


func _ready():
	rng.randomize()
	p1Sprite.texture = skins[0]
	p2Sprite.texture = skins[1]
	p3Sprite.texture = skins[2]
	p4Sprite.texture = skins[4]
	currentPlayer = p1

func _physics_process(delta):
	#Adjust Moves Left
	if currentPlayer.movesLeft == 0:
		$CanvasLayer/MovesLeft.text = "Moves Left: 0"
	elif currentPlayer.movesLeft == 1:
		$CanvasLayer/MovesLeft.text = "Moves Left: 1"
	elif currentPlayer.movesLeft == 2:
		$CanvasLayer/MovesLeft.text = "Moves Left: 2"
	elif currentPlayer.movesLeft == 3:
		$CanvasLayer/MovesLeft.text = "Moves Left: 3"
	elif currentPlayer.movesLeft == 4:
		$CanvasLayer/MovesLeft.text = "Moves Left: 4"
	elif currentPlayer.movesLeft == 5:
		$CanvasLayer/MovesLeft.text = "Moves Left: 5"
	elif currentPlayer.movesLeft == 6:
		$CanvasLayer/MovesLeft.text = "Moves Left: 6"
	elif currentPlayer.movesLeft == 7:
		$CanvasLayer/MovesLeft.text = "Moves Left: 7"
	elif currentPlayer.movesLeft == 8:
		$CanvasLayer/MovesLeft.text = "Moves Left: 8"
	elif currentPlayer.movesLeft == 9:
		$CanvasLayer/MovesLeft.text = "Moves Left: 9"
	elif currentPlayer.movesLeft == 10:
		$CanvasLayer/MovesLeft.text = "Moves Left: 10"
	elif currentPlayer.movesLeft == 11:
		$CanvasLayer/MovesLeft.text = "Moves Left: 11"
	elif currentPlayer.movesLeft == 12:
		$CanvasLayer/MovesLeft.text = "Moves Left: 12"
	else:
		currentPlayer.movesLeft = 0
		$CanvasLayer/MovesLeft.text = "Moves Left: 0"
	
	#Adjust Maps Found
	if currentPlayer.totalMapsFound == 0:
		$CanvasLayer/MapsFound.text = "Maps Found: 0"
	elif currentPlayer.totalMapsFound == 1:
		$CanvasLayer/MapsFound.text = "Maps Found: 1"
	elif currentPlayer.totalMapsFound == 2:
		$CanvasLayer/MapsFound.text = "Maps Found: 2"
	elif currentPlayer.totalMapsFound == 3:
		$CanvasLayer/MapsFound.text = "Maps Found: 3"
	elif currentPlayer.totalMapsFound == 4:
		$CanvasLayer/MapsFound.text = "Maps Found: 4"
	elif currentPlayer.totalMapsFound == 5:
		$CanvasLayer/MapsFound.text = "Maps Found: 5"
	else:
		currentPlayer.totalMapsFound == 0
		$CanvasLayer/MapsFound.text = "Maps Found: 0"
	
	#Update Player Label
	if currentPlayer == p1:
		playerLabel.text = "Player 1"
	elif currentPlayer == p2:
		playerLabel.text = "Player 2"
	elif currentPlayer == p3:
		playerLabel.text = "Player 3"
	elif currentPlayer == p4:
		playerLabel.text = "Player 4"
	
	#Check for minigame completed
	if hidden == true:
		if Global.maze_beaten == true:
			show_all()
			currentPlayer.key_found = true
			end_turn()
		if Global.timer_end == true:
			show_all()
			end_turn()

func _unhandled_input(event):
	if(event.is_action_pressed("pause")):
		if onMainMenu != true:
			get_tree().paused = true
			$CanvasLayer/Pause.show()

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
	var door_tile = $Doors.tile_set.tile_get_name(1)
	
	if tile == "Light Gray Brick Floor.png 0":
		laugh.play()
		currentPlayer.position.x = 608
		currentPlayer.position.y = 96
		$CanvasLayer/Message.text = "Position Reset!!!"
		$CanvasLayer/Message.show()
		yield(get_tree().create_timer(3.0), "timeout")
		$CanvasLayer/Message.hide()
	elif tile == "Pale Blue Brick Floor.png 1":
		cheer.play()
		select_random_map()
	elif tile == "Purple Brick Floor.png 2":
		laugh.play()
		if currentPlayer.key_found == true:
			currentPlayer.key_found == false
			$CanvasLayer/Message.text = "Key Lost"
			$CanvasLayer/Message.show()
			yield(get_tree().create_timer(3.0), "timeout")
			$CanvasLayer/Message.hide()
		else:
			currentPlayer.position.x = 608
			currentPlayer.position.y = 96
			$CanvasLayer/Message.text = "Position Reset"
			$CanvasLayer/Message.show()
			yield(get_tree().create_timer(3.0), "timeout")
			$CanvasLayer/Message.hide()
	elif tile == "Red Brick Floor.png 3":
		print("red")
	elif tile == "Yellow Brick Floor.png 4":
		cheer.play()
		if(currentPlayer.map1_found == true):
			Global.map1_found = true
		if(currentPlayer.map2_found == true):
			Global.map2_found = true
		if(currentPlayer.map3_found == true):
			Global.map3_found = true
		if(currentPlayer.map4_found == true):
			Global.map4_found = true
		if(currentPlayer.map5_found == true):
			Global.map5_found = true
		$CanvasLayer/Message.text = "Minigame Beginning. \nFIND THE KEY"
		$CanvasLayer/Message.show()
		yield(get_tree().create_timer(3.0), "timeout")
		$CanvasLayer/Message.hide()
		Global.goto_scene("res://FindTheKey_Minigame1/FindTheKey.tscn")
		hide_all()
		#call_deferred("show_all")
	elif door_tile == "MasterDoor.png 1":
		if currentPlayer.key_found == true:
			game_win()
		else:
			$CanvasLayer/Message.text = "Cannot Leave the Belladonna without a Key"
			$CanvasLayer/Message.show()
			yield(get_tree().create_timer(3.0), "timeout")
			$CanvasLayer/Message.hide()

func select_random_map():
	if currentPlayer.map1_found == true and currentPlayer.map2_found == true and currentPlayer.map3_found == true and currentPlayer.map4_found == true and currentPlayer.map5_found == true:
		$CanvasLayer/Message.text = "All Maps Found"
		$CanvasLayer/Message.show()
		yield(get_tree().create_timer(3.0), "timeout")
		$CanvasLayer/Message.hide()
	else:
		map = rng.randi_range(1, 5)
		if map == 1:
			if currentPlayer.map1_found == true:
				select_random_map()
			else:
				currentPlayer.map1_found = true
				currentPlayer.totalMapsFound += 1
				$CanvasLayer/Message.text = "Map of Maze 1 Found"
				$CanvasLayer/Message.show()
				yield(get_tree().create_timer(3.0), "timeout")
				$CanvasLayer/Message.hide()
		elif map == 2:
			if currentPlayer.map2_found == true:
				select_random_map()
			else:
				currentPlayer.map2_found = true
				currentPlayer.totalMapsFound += 1
				$CanvasLayer/Message.text = "Map of Maze 2 Found"
				$CanvasLayer/Message.show()
				yield(get_tree().create_timer(3.0), "timeout")
				$CanvasLayer/Message.hide()
		elif map == 3:
			if currentPlayer.map3_found == true:
				select_random_map()
			else:
				currentPlayer.map3_found = true
				currentPlayer.totalMapsFound += 1
				$CanvasLayer/Message.text = "Map of Maze 3 Found"
				$CanvasLayer/Message.show()
				yield(get_tree().create_timer(3.0), "timeout")
				$CanvasLayer/Message.hide()
		elif map == 4:
			if currentPlayer.map4_found == true:
				select_random_map()
			else:
				currentPlayer.map4_found = true
				currentPlayer.totalMapsFound += 1
				$CanvasLayer/Message.text = "Map of Maze 4 Found"
				$CanvasLayer/Message.show()
				yield(get_tree().create_timer(3.0), "timeout")
				$CanvasLayer/Message.hide()
		elif map == 5:
			if currentPlayer.map5_found == true:
				select_random_map()
			else:
				currentPlayer.map5_found = true
				currentPlayer.totalMapsFound += 1
				$CanvasLayer/Message.text = "Map of Maze 5 Found"
				$CanvasLayer/Message.show()
				yield(get_tree().create_timer(3.0), "timeout")
				$CanvasLayer/Message.hide()
		else:
			pass

func player_turn():
	dice.visible = true
	if currentPlayer.key_found == true:
		$CanvasLayer/KeyFound.visible = true
	else:
		$CanvasLayer/KeyFound.visible = false

func _on_Button_pressed():
	yield(get_tree().create_timer(2.0), "timeout")
	dice.visible = false
	totalDiceRoll = dice.totalRoll
	currentPlayer.movesLeft = totalDiceRoll

func _on_EndTurn_pressed():
	end_turn()

func end_turn():
	if currentPlayer.movesLeft == 0:
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
	else:
		$CanvasLayer/Message.text = "You still have moves left. Cannot pass turn until all moves are used up"
		$CanvasLayer/Message.show()
		yield(get_tree().create_timer(3.0), "timeout")
		$CanvasLayer/Message.hide()

func hide_all():
	hidden = true
	$Title.hide()
	$TileMap.hide()
	$Doors.hide()
	$Player1.hide()
	$Player2.hide()
	$Player3.hide()
	$Player4.hide()
	$CanvasLayer/Dice_Roller.hide()
	$CanvasLayer/EndTurn.hide()
	$CanvasLayer/MapsFound.hide()
	$CanvasLayer/KeyFound.hide()
	$CanvasLayer/MovesLeft.hide()
	playerLabel.hide()
	$OutSideTileMap.hide()
	music.stop()

func show_all():
	#yield(get_tree().create_timer(190.0), "timeout")
	$Title.show()
	$TileMap.show()
	$Doors.show()
	$Player1.show()
	$Player2.show()
	$Player3.show()
	$Player4.show()
	$CanvasLayer/Dice_Roller.show()
	$CanvasLayer/EndTurn.show()
	$CanvasLayer/MapsFound.show()
	$CanvasLayer/MovesLeft.show()
	playerLabel.show()
	$OutSideTileMap.show()
	music.play()
	Global.timer_end = false
	Global.maze_beaten = false

func start_game():
	p1.position.x = p1.start_Position_x
	p1.position.y = p1.start_Position_y
	p2.position.x = p2.start_Position_x
	p2.position.y = p2.start_Position_y
	p3.position.x = p3.start_Position_x
	p3.position.y = p3.start_Position_y
	p4.position.x = p4.start_Position_x
	p4.position.y = p4.start_Position_y
	currentPlayer = p1
	nextPlayer = p2
	move_camera(p1)
	music.play()
	player_turn()

func game_win():
	$CanvasLayer/Message.text = "YOU WIN!!!"
	$CanvasLayer/Message.show()
	yield(get_tree().create_timer(3.0), "timeout")
	$CanvasLayer/Message.hide()


#UI Buttons
func _on_Begin_pressed():
	$StartScreen/ColorRect.hide()
	$StartScreen/MainMenu.hide()
	$CanvasLayer/EndTurn.show()
	$CanvasLayer/MapsFound.show()
	$CanvasLayer/MovesLeft.show()
	playerLabel.show()
	onMainMenu = false
	start_game()


func _on_Exit_pressed():
	get_tree().quit()


func _on_Resume_pressed():
	$CanvasLayer/Pause.hide()
	get_tree().paused = false


func _on_Quit_pressed():
	get_tree().quit()
