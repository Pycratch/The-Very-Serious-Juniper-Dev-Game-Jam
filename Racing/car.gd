class_name Car extends PathFollow2D

@export var racing_line :Path2D

enum Types {PLAYER, ENEMY}
@export var type :Types
var speed :float

#signals
signal player_won
signal enemy_won

##variable to allow driving
var can_start :bool = false

#texture rect values
var blue_car :Rect2 = Rect2(38.0, 34.0, 21.0, 30.0)
var red_car :Rect2 = Rect2(6.0, 34.0, 21.0, 30.0)

#onreadies
@onready var texture = $Texture
@onready var racing_node = get_parent().get_parent()

# Called when the node enters the scene tree for the first time.
func _ready():
	set_speed()
	set_texture_region()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	drive()
	if progress_ratio > 0.95 and progress_ratio < 1.0:
		set_winning()

func set_speed():
	if type == Types.PLAYER and GameStats.Power >= 500:
		speed = GameStats.Power * 0.01
	elif type == Types.ENEMY and GameStats.Power >= 500:
		speed = GameStats.Power * randf_range(1.0, 1.2) * 0.1

func set_texture_region():
	texture.region_enabled = true
	if type == Types.PLAYER:
		texture.region_rect = blue_car
	elif type == Types.ENEMY:
		texture.region_rect = red_car

func drive():
	if not can_start:
		return
	if not speed:
		return
	progress += speed

func set_winning():
	can_start = false
	if racing_node.there_is_winner == false:
		print("null")
		if type == Types.PLAYER:
			print("play")
			player_won.emit()
			racing_node.there_is_winner = true
		elif type == Types.ENEMY:
			print("enem")
			enemy_won.emit()
			racing_node.there_is_winner = true
	progress_ratio = 0.0
