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
onready var goal1 = $Maze/Goal/CollisionShape
onready var goal2 = $Maze2/Goal/CollisionShape
onready var goal3 = $Maze3/Goal/CollisionShape
onready var goal4 = $Maze4/Goal/CollisionShape
onready var goal5 = $Maze5/Goal/CollisionShape

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
"""
func _input(event):
	if event.is_action_pressed("reset"):
		reset()

func reset():
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
	countdown.minutes = 3
	countdown.seconds = 0
	lose.visible = false
	win.visible = false
"""

func _on_Maze_playerWins():
	print("YOU WIN!!!")
	timer.stop()
	win.visible = true
	$Victory.play()
	goal1.disabled = true
	emit_signal("victory")


func _on_Maze2_playerWins():
	print("YOU WIN!!!")
	timer.stop()
	win.visible = true
	$Victory.play()
	goal2.disabled = true
	emit_signal("victory")


func _on_Maze3_playerWins():
	print("YOU WIN!!!")
	timer.stop()
	win.visible = true
	$Victory.play()
	goal3.disabled = true
	emit_signal("victory")


func _on_Maze4_playerWins():
	print("YOU WIN!!!")
	timer.stop()
	win.visible = true
	$Victory.play()
	goal4.disabled = true
	emit_signal("victory")


func _on_Maze5_playerWins():
	print("YOU WIN!!!")
	timer.stop()
	win.visible = true
	$Victory.play()
	goal5.disabled = true
	emit_signal("victory")


func _on_Countdown_countdown_over():
	print("YOU LOSE!!!")
	lose.visible = true
	goal1.disabled = true
	goal2.disabled = true
	goal3.disabled = true
	goal4.disabled = true
	goal5.disabled = true
	$Defeat.play()
	emit_signal("defeat")
