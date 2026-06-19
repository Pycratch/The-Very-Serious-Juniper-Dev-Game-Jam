extends Sprite2D

@onready var Pointer = get_parent().get_node("Pointer")

var spin_timer : float = 2.5
var prizes : Array = [
	"Ignition",
	"Tires",
	"Exhaust",
	"Aerodynamics",
	"Brakes",
	"Supercharger",
	"Transmission",
	"Suspension",
	"Cooling System",
	"Drivetrain",
	"Differential",
	"Fuel System",
	"Intake",
	"Steering",
	"Interior", #Cosmetic
	"Bumper",
	"Bonnet",
	"Seats"
]

var Intake : Array = [
	"Stock Intake",
	"Street Intake",
	"Sport Intake",
	"Race Intake"
]

var FuelSystem : Array = [
	"Stock Fuel System",
	"Race Fuel System"
]

var Ignition : Array = [
	"Stock Ignition",
	"Race Ignition"
]
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var easeOutQuadtween = create_tween()
	easeOutQuadtween.set_trans(Tween.TRANS_CIRC)
	easeOutQuadtween.set_ease(Tween.EASE_OUT)
	if Input.is_action_just_pressed("spin"):
		easeOutQuadtween.tween_property(self, "global_rotation", randi() % 70 + 40, spin_timer)
		await get_tree().create_timer(spin_timer).timeout
		for body in Pointer.get_overlapping_areas():
			var prize = body.get_child(1).name
			if prize not in prizes:
				return
			
			
