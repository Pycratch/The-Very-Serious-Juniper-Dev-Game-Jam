extends Sprite2D

@onready var Pointer = get_parent().get_node("Pointer")

var min_spin_timer : float = 1.8
var max_spin_timer : float = 3.0
var final_prize : String
var rarities = [
	{"name": "Common", "weight": 50},
	{"name": "Rare", "weight": 25},
	{"name": "Epic", "weight": 15},
	{"name": "Mythic", "weight": 7.5},
	{"name": "Legendary", "weight": 2.5}
]

@onready var prizes : Dictionary = {
	"Engine": engine,
	"Tires": tires,
	"Exhaust": exhaust,
	"Aerodynamics": aerodynamics,
	"Brakes": brakes,
	"Transmission": transmission,
	"Suspension": suspension,
	"Supercharger": supercharger,
	"Cooling System": cooling_system,
	"Drivetrain": drivetrain,
	"Differential": differential,
	"Fuel System": fuel_system,
	"Weight Reduction": weight_reduction
	#"Interior": interior, #Cosmetic
	#"Bumper": bumper,
	#"Bonnet": bonnet,
	#"Seats": seats
}

var engine : Array = [
	"Inline-4",
	"Inline-5",
	"V6",
	"Flat-6",
	"V8",
	"V10",
	"V12",
	"Twin-Turbo V8",
	"Twin-Turbo V12",
    "Hybrid Hypercar Powertrain"
]

var exhaust : Array = [
	"Axle-Back",
	"Cat-Back",
	"Turbo-Back"
]

var transmission : Array = [
	"Direct-Shift Gearbox",
	"Dual-Clutch Transmission",
	"Multi Clutch Transmission",
	
]
var turbocharger : Array = [
	"Stock Turbo",
	"Sport Turbo",
	"Performance Turbo",
	"Twin Turbo",
	"Race Twin Turbo",
    "Anti-Lag Turbo System"
]

var fuel_system : Array = [
	"High Flow Injectors",
	"Performance Fuel Pump",
	"Race Injectors",
	"E85 Conversion",
    "Race Fuel System"
]

var ignition : Array = [
	"Stock Ignition",
	"Race Ignition"
]

var supercharger : Array = [
	"Roots Supercharger",
	"Twin-Screw Supercharger",
    "Race Supercharger"
]

var tires : Array = [
	"Economy Tires",
	"Street Tires",
	"Sport Tires",
	"Performance Tires",
	"Semi-Slicks",
    "Slick Racing Tires"
]

var transimission : Array = [
	"5-Speed Manual",
	"6-Speed Manual",
	"7-Speed DCT",
	"8-Speed DCT",
	"Sequential Gearbox",
    "Race Sequential Gearbox"
]

var suspension : Array = [
	"Stock Suspension",
	"Lowering Springs",
	"Sport Suspension",
	"Coilovers",
	"Adjustable Coilovers",
    "Race Suspension"
]

var brakes : Array = [
	"Stock Brakes",
	"Sport Brakes",
	"Brembo Brakes",
	"Big Brake Kit",
	"Carbon Ceramic Brakes",
    "Race Carbon Brakes"
]

var differential : Array = [
	"Open Differential",
	"Street LSD",
	"Sport LSD",
	"Race LSD",
    "Electronic Race LSD"
]

var drivetrain : Array = [
	"FWD",
	"RWD",
	"AWD",
	"Performance AWD",
    "Race AWD"
]

var aerodynamics : Array = [
	"Lip Spoiler",
	"Sport Wing",
	"GT Wing",
	"Front Splitter",
	"Full Aero Kit",
    "Race Aero Package"
]

var weight_reduction : Array = [
	"Remove Rear Seats",
	"Lightweight Battery",
	"Carbon Hood",
	"Carbon Panels",
	"Full Weight Reduction",
    "Race Weight Reduction"
]

var cooling_system : Array = [
	"Sport Radiator",
	"Performance Radiator",
	"Oil Cooler",
    "Race Cooling Package"
]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("spin"):
		var easeOutQuadtween = create_tween()
		easeOutQuadtween.set_trans(Tween.TRANS_CIRC)
		easeOutQuadtween.set_ease(Tween.EASE_OUT)
	
		for child in get_children():
			child.roll_rarity()
		var spin_timer = randf_range(min_spin_timer, max_spin_timer)
		easeOutQuadtween.tween_property(self, "global_rotation", randi() % 70 + 40, spin_timer)
		await get_tree().create_timer(spin_timer).timeout
		var body = Pointer.get_collider()
		if not body:
			return
		var prize = body.get_child(1).name
		var rarity = body.rolled_rarity
		roll_prize(prize, rarity)
			

func roll_prize(prize, rarity):
	var prize_list = prizes.get(prize)
	if prize_list:
		final_prize = prize_list.pick_random()
		give_rarity(final_prize, rarity)
		
		
func give_rarity(prize, manualrarity):
	if manualrarity != "":
		print(manualrarity + " " + prize)
		return manualrarity
	
	var first_rolled_rarity : float
	var total_weight : int = 0
	for rarity in rarities:
		total_weight += rarity["weight"]
		
	var roll = randf_range(0, total_weight)
	for rarity in rarities:
		first_rolled_rarity += rarity["weight"]
		if roll < first_rolled_rarity:
			#print(rarity["name"] + " " + prize)
			return rarity["name"]
			
	print("fallback")
	
	
	
