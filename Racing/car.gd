class_name Car extends PathFollow2D

@export var racing_line :Path2D

enum Types {PLAYER, ENEMY}
@export var type :Types
var speed :float

##variable to allow driving
var can_start :bool = true

#texture rect values
var blue_car :Rect2 = Rect2(38.0, 34.0, 21.0, 30.0)
var red_car :Rect2 = Rect2(6.0, 34.0, 21.0, 30.0)

#onreadies
@onready var texture = $Texture

# Called when the node enters the scene tree for the first time.
func _ready():
	set_speed()
	set_texture_region()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	drive()

func set_speed():
	if type == Types.PLAYER:
		speed = GameStats.Power
	elif type == Types.ENEMY:
		speed = GameStats.Power * randf_range(0.8, 1.2)

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
