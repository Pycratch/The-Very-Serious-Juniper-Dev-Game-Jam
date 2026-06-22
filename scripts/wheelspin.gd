extends Sprite2D

@onready var Pointer = get_parent().get_node("Pointer")
@onready var WinSound = get_parent().get_node("WinSound")
@onready var SpinSound = get_parent().get_node("SpinSound")
@onready var parent = get_parent()

@export var engine_icon : Texture2D
@export var tires_icon : Texture2D
@export var exhaust_icon : Texture2D
@export var aerodynamics_icon : Texture2D
@export var brakes_icon : Texture2D
@export var supercharger_icon : Texture2D
@export var turbocharger_icon : Texture2D
@export var transmission_icon : Texture2D
@export var suspension_icon : Texture2D
@export var cooling_system_icon : Texture2D
@export var drivetrain_icon : Texture2D
@export var fuel_system_icon : Texture2D
@export var weight_reduction_icon : Texture2D
@export var differential_icon : Texture2D

var final_prize : String
var spin_timer : float = 2.5
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
	"Turbocharger": turbocharger,
	"Supercharger": supercharger,
	"Cooling System": cooling_system,
	"Drivetrain": drivetrain,
	"Differential": differential,
	"Fuel System": fuel_system,
	"Weight Reduction": weight_reduction
}

@onready var prizes_icons : Dictionary = {
	"Engine": engine_icon,
	"Tires": tires_icon,
	"Exhaust": exhaust_icon,
	"Aerodynamics": aerodynamics_icon,
	"Brakes": brakes_icon,
	"Transmission": transmission_icon,
	"Suspension": suspension_icon,
	"Turbocharger": turbocharger_icon,
	"Supercharger": supercharger_icon,
	"Cooling System": cooling_system_icon,
	"Drivetrain": drivetrain_icon,
	"Differential": differential_icon,
	"Fuel System": fuel_system_icon,
	"Weight Reduction": weight_reduction_icon
}

var engine : Array = [
	"Inline-4",
	"V6",
	"V8",
	"V10",
	"V12",
]

var exhaust : Array = [
	"Axle-Back",
	"Cat-Back",
	"Turbo-Back"
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

var transmission : Array = [
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
	if parent.visible == false:
		return
	
	if Input.is_action_just_pressed("spin"):
		var easeOutQuadtween = create_tween()
		easeOutQuadtween.set_trans(Tween.TRANS_CIRC)
		easeOutQuadtween.set_ease(Tween.EASE_OUT)
	
		for child in get_children():
			setup_prizes(child)
			child.roll_rarity()
		
		easeOutQuadtween.tween_property(self, "global_rotation", randi() % 70 + 40, spin_timer)
		SpinSound.play()
		await get_tree().create_timer(spin_timer).timeout
		
		var body = Pointer.get_collider()
		if body:
			var prize = body.get_child(1).name
			var rarity = body.rolled_rarity
			roll_prize(prize, rarity)
			

func roll_prize(prize, rarity):
	WinSound.play()
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
	for rarity in rarities: #Hier wird die Rarity gerollt
		first_rolled_rarity += rarity["weight"]
		if roll < first_rolled_rarity:
			return rarity["name"]
			
	print("fallback")
	
func setup_prizes(child):
	child.prize_type = prizes.keys().pick_random()
