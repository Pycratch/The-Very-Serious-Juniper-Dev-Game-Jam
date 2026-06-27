extends Node2D

var winner :String#using string coz tired
var there_is_winner :bool = false
var start = false
var prize_money = 2000

@export var cars :Array[Car]

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func start_cars():
	for i in cars:
		i.can_start = true

func _on_car_player_won():
	winner = "Player"
	#using string coz tired


func _on_car_enemy_won():
	winner = "Enemy"

func set_winner():
	if not there_is_winner:
		return
	if not winner:
		return
	if winner == "Player":
		$WinSprite.show()
		GameStats.Money += prize_money
	elif winner == "Enemy":
		$LoseSprite.show()


func _on_countdown_timer_timeout():
	start = true
	$StartSound.play()
	start_cars()


func _on_countdown_start_timeout():
	if start:
		return
	$SecondSound.play()
	$CountdownStart.start()
