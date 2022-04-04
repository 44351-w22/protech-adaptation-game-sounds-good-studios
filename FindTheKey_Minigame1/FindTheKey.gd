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
onready var countdown = $Countdown
onready var timer = $Countdown/Timer
onready var lose = $Countdown/Defeat
onready var win = $Countdown/Victory

func _ready():
	rng.randomize()
	startingMaze = rng.randi_range(1, 5)
	if startingMaze == 1:
		player.translation = Vector3(0, 1, 0)
	elif startingMaze == 2:
		player.translation = Vector3(0, 1, -205)
	elif startingMaze == 3:
		player.translation = Vector3(0, 1, 203)
	elif startingMaze == 4:
		player.translation = Vector3(201, 1, 0)
	elif startingMaze == 5:
		player.translation = Vector3(-204, 1, 0)
	else:
		print("error with random number generation")


func _on_Maze_playerWins():
	print("YOU WIN!!!")
	timer.stop()
	win.visible = true
	emit_signal("victory")


func _on_Maze2_playerWins():
	print("YOU WIN!!!")
	timer.stop()
	win.visible = true
	emit_signal("victory")


func _on_Maze3_playerWins():
	print("YOU WIN!!!")
	timer.stop()
	win.visible = true
	emit_signal("victory")


func _on_Maze4_playerWins():
	print("YOU WIN!!!")
	timer.stop()
	win.visible = true
	emit_signal("victory")


func _on_Maze5_playerWins():
	print("YOU WIN!!!")
	timer.stop()
	win.visible = true
	emit_signal("victory")


func _on_Countdown_countdown_over():
	print("YOU LOSE!!!")
	lose.visible = true
	emit_signal("defeat")
