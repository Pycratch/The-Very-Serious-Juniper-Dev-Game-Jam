extends Node2D

@export var cars :Array[Car]
var winner :String#using string coz tired
var there_is_winner :bool = false
var start : bool = false
var prize_money = 2000
var can_start : bool = false
var play_sound : bool = false
var can_race : bool = true
var number = 3

@export var TimerLabel : Label

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if get_parent().visible:
		can_start = true
	else:
		can_start = false
		
func start_cars():
	winner = ""
	for i in cars:
		print("BOMB")
		there_is_winner = false
		i.set_speed()
		i.can_start = true
		can_start = false
		
func _on_car_player_won():
	winner = "Player"
	set_winner()
	#using string coz tired


func _on_car_enemy_won():
	winner = "Enemy"
	set_winner()

func set_winner():
	if not winner:
		return
	if winner == "Player":
		$WinSprite.show()
		GameStats.Money += prize_money
		print("Player")
	elif winner == "Enemy":
		$LoseSprite.show()
		print("Enemy")
	can_race = true

func _on_countdown_timer_timeout():
	if can_start == true:
		start = true
		$StartSound.play()
		start_cars()
		print("Start Cars")
		can_start = false


func _on_countdown_start_timeout():
	pass

func set_timer_label():
	TimerLabel.text = str(number)
	number -= 1
	await get_tree().create_timer(1).timeout
	TimerLabel.text = str(number)
	number -= 1
	await get_tree().create_timer(1).timeout
	TimerLabel.text = str(number)
	number -= 1
	await get_tree().create_timer(1).timeout
	TimerLabel.text = str(number)
	number -= 1


func _on_start_pressed() -> void:
	if can_race and get_parent().visible:
		can_race = false
		$CountdownTimer.start()
		number = 3
		set_timer_label()
		$WinSprite.hide()
		$LoseSprite.hide()
