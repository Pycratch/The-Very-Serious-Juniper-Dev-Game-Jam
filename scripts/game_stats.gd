extends Node2D

@export var Money : float = 5000.0
@export var Items : int
@export var Power : float = 10

var can_sell :bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("!!TEMP!!ADDMONEY"):
		Money += 10.0
