extends Control

var dice = [preload("res://assets/dice/dieWhite1.png"),
			preload("res://assets/dice/dieWhite2.png"),
			preload("res://assets/dice/dieWhite3.png"),
			preload("res://assets/dice/dieWhite4.png"),
			preload("res://assets/dice/dieWhite5.png"),
			preload("res://assets/dice/dieWhite6.png")]
			

var rng = RandomNumberGenerator.new()
export var totalRoll = 0

onready var diceA = $Container/DiceA
onready var diceB = $Container/DiceB

func _ready():
	rng.randomize()

func rollDice():
	#figure out actual dice roll
	var dice1 = rng.randi_range(1, 6)
	var dice2 = rng.randi_range(1, 6)
	totalRoll = dice1 + dice2
	
	#randomize dice textures to give illusion of dice rolling
	for i in 10:
		$Click.play()
		diceA.texture = dice[rng.randi_range(0, 5)]
		diceB.texture = dice[rng.randi_range(0, 5)]
		yield(get_tree().create_timer(0.1), "timeout")
	
	#Set final texture to appropriate dice
	$Click.play()
	var dice1index = dice1 - 1
	var dice2index = dice2 - 1
	diceA.texture = dice[dice1index]
	diceB.texture = dice[dice2index]


func _on_Button_pressed():
	rollDice()
