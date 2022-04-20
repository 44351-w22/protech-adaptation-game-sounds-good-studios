extends Node

#Position 1: (0, 1, 0)
#Position 2: (0, 1, -205)
#Position 3: (0, 1, 203)
#Position 4: (201, 1, 0)
#Position 5: (-204, 1, 0)

signal victory
signal defeat

var rng = RandomNumberGenerator.new()
var startingMaze = 0
onready var player = $HedgePlayer
onready var ui = $UI
onready var timer = $UI/Timer
onready var lose = $UI/Defeat
onready var win = $UI/Victory
onready var goal1 = $Maze/Goal/CollisionShape
onready var goal2 = $Maze2/Goal/CollisionShape
onready var goal3 = $Maze3/Goal/CollisionShape
onready var goal4 = $Maze4/Goal/CollisionShape
onready var goal5 = $Maze5/Goal/CollisionShape
onready var map1 = $UI/Maze
onready var map2 = $UI/Maze2
onready var map3 = $UI/Maze3
onready var map4 = $UI/Maze4
onready var map5 = $UI/Maze5

func _ready():
	
	rng.randomize()
	startingMaze = rng.randi_range(1, 5)
	if startingMaze == 1:
		player.translation = Vector3(0, 1, 0)
		if Global.map1_found == true:
			map5.visible = true
	elif startingMaze == 2:
		player.translation = Vector3(0, 1, -205)
		if Global.map2_found == true:
			map4.visible = true
	elif startingMaze == 3:
		player.translation = Vector3(0, 1, 203)
		if Global.map3_found == true:
			map2.visible = true
	elif startingMaze == 4:
		player.translation = Vector3(201, 1, 0)
		if Global.map4_found == true:
			map1.visible = true
	elif startingMaze == 5:
		player.translation = Vector3(-204, 1, 0)
		if Global.map5_found == true:
			map3.visible = true
	else:
		print("error with random number generation")


func _unhandled_input(event):
	if(event.is_action_pressed("pause")):
		get_tree().paused = true
		$Pause.show()

func _on_Maze_playerWins():
	print("YOU WIN!!!")
	timer.stop()
	win.visible = true
	$Victory.play()
	goal1.disabled = true
	map1.visible = false
	Global.current_player_key = true
	emit_signal("victory")
	yield(get_tree().create_timer(10.0), "timeout")
	World.show()


func _on_Maze2_playerWins():
	print("YOU WIN!!!")
	timer.stop()
	win.visible = true
	$Victory.play()
	goal2.disabled = true
	map2.visible = false
	Global.current_player_key = true
	emit_signal("victory")
	yield(get_tree().create_timer(10.0), "timeout")
	World.show()


func _on_Maze3_playerWins():
	print("YOU WIN!!!")
	timer.stop()
	win.visible = true
	$Victory.play()
	goal3.disabled = true
	map3.visible = false
	Global.current_player_key = true
	emit_signal("victory")
	yield(get_tree().create_timer(10.0), "timeout")
	World.show()


func _on_Maze4_playerWins():
	print("YOU WIN!!!")
	timer.stop()
	win.visible = true
	$Victory.play()
	goal4.disabled = true
	map4.visible = false
	Global.current_player_key = true
	emit_signal("victory")
	yield(get_tree().create_timer(10.0), "timeout")
	World.show()


func _on_Maze5_playerWins():
	print("YOU WIN!!!")
	timer.stop()
	win.visible = true
	$Victory.play()
	goal5.disabled = true
	map5.visible = false
	Global.current_player_key = true
	emit_signal("victory")
	yield(get_tree().create_timer(10.0), "timeout")
	World.show()


func _on_Countdown_countdown_over():
	print("YOU LOSE!!!")
	lose.visible = true
	goal1.disabled = true
	goal2.disabled = true
	goal3.disabled = true
	goal4.disabled = true
	goal5.disabled = true
	map1.visible = false
	map2.visible = false
	map3.visible = false
	map4.visible = false
	map5.visible = false
	$Defeat.play()
	emit_signal("defeat")
	yield(get_tree().create_timer(10.0), "timeout")
	World.show()

func _on_Resume_pressed():
	$Pause.hide()
	get_tree().paused = false
