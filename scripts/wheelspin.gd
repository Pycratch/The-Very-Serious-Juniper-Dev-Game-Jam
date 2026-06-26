extends Sprite2D

@onready var Pointer = get_parent().get_node("Pointer")
@onready var WinSound = get_parent().get_node("WinSound")
@onready var SpinSound = get_parent().get_node("SpinSound")
@onready var parent = get_parent()
@onready var FinalPrize = %FinalPrizeLabel

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

var endItem : ItemPart
var final_prize : String
var spin_timer : float = 2.5
var price : float = 30.0
var current_wheelspin_rarity : String = "Common"

var rarities = [
	{"name": "Common", "weight": 50},
	{"name": "Rare", "weight": 25},
	{"name": "Epic", "weight": 15},
	{"name": "Mythic", "weight": 7.5},
	{"name": "Legendary", "weight": 2.5}
]

const COLOR_TINT = {
	"Common" : Color(0.221, 0.235, 0.219, 1.0), 
	"Rare" : Color(0.0, 0.425, 0.095, 1.0),
	"Epic": Color(0.384, 0.042, 0.564, 1.0),
	"Mythic": Color(0.43, 0.0, 0.0, 1.0),
	"Legendary": Color(0.442, 0.422, 0.011, 1.0)
}

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
	"Cooling_System": cooling_system,
	"Drivetrain": drivetrain,
	"Differential": differential,
	"Fuel_System": fuel_system,
	"Weight_Reduction": weight_reduction

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
	"Cooling_System": cooling_system_icon,
	"Drivetrain": drivetrain_icon,
	"Differential": differential_icon,
	"Fuel_System": fuel_system_icon,
	"Weight_Reduction": weight_reduction_icon
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
    "Race Fuel_System"
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
	"Full Weight_Reduction",
    "Race Weight_Reduction"
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
	
	#reset_weight()
	#set_wheelspin_color()
	if Input.is_action_just_pressed("spin") and GameStats.Money >= price and parent.visible:
		#create new end item?
		endItem = ItemPart.new()
		endItem.rodeo()
		GameStats.Money -= price
		get_parent().disable_all()
		var easeOutQuadtween = create_tween()
		easeOutQuadtween.set_trans(Tween.TRANS_CIRC)
		easeOutQuadtween.set_ease(Tween.EASE_OUT)
	
		for child in get_children():
			setup_prizes(child)
			child.roll_rarity()
		
		easeOutQuadtween.tween_property(self, "global_rotation", randi() % 70 + 40, spin_timer)
		SpinSound.play()
		await get_tree().create_timer(spin_timer).timeout
		get_parent().enable_all()
		var body = Pointer.get_collider()
		if body:
			var prize = body.get_child(1).name
			var rarity = body.rolled_rarity
			#set endItem rarity
			endItem.rarity = endItem.Rarities.values()[endItem.Rarities.keys().find(rarity)]
			roll_prize(prize, rarity)
			Collection.add_item(endItem)
			

func roll_prize(prize, rarity):
	WinSound.play()
	var prize_list = endItem.prizes.get(prize)
	if prize_list:
		final_prize = endItem.final_prize
		give_rarity(final_prize, rarity)
		reset_weight()
		
func give_rarity(prize, finalrarity):
	if finalrarity != "":
		print(finalrarity + " " + prize)
		FinalPrize.text = "Prize: \n" + finalrarity + " \n" + prize
		endItem.set_rarity(finalrarity)
		return finalrarity
	
	endItem.randomize_rarity()
	
	finalrarity = endItem.rarity_string
	endItem.set_rarity(finalrarity)
	return finalrarity
			
	print("fallback")
	
func setup_prizes(child):
	child.prize_type = endItem.prizes.keys().pick_random()
	child.temp_prize_type = prizes.keys().pick_random()
	#print(child.prize_type)


func set_wheelspin_color():
	if current_wheelspin_rarity == "Common":
		self.self_modulate = COLOR_TINT.get("Common", Color(1,1,1))
		endItem.common_weight = 50.0
		
	elif current_wheelspin_rarity == "Rare":
		self.self_modulate = COLOR_TINT.get("Rare", Color(1,1,1)) 
		endItem.rare_weight = 50.0
		
	elif current_wheelspin_rarity == "Epic":
		self.self_modulate = COLOR_TINT.get("Epic", Color(1,1,1)) 
		endItem.epic_weight = 50.0
		
	elif current_wheelspin_rarity == "Mythic":
		self.self_modulate = COLOR_TINT.get("Mythic", Color(1,1,1)) 
		endItem.mythic_weight = 50.0
	
	elif current_wheelspin_rarity == "Legendary":
		self.self_modulate = COLOR_TINT.get("Legendary", Color(1,1,1))
		endItem.legendary_weight = 50.0
		
func reset_weight():
	endItem.common_weight = 50.0
	endItem.rare_weight = 25.0
	endItem.epic_weight = 15.0
	endItem.mythic_weight = 7.5
	endItem.legendary_weight = 2.5

func _on_common_toggled(toggled_on: bool) -> void:
	if toggled_on == true:
		price = 50.0
		current_wheelspin_rarity = "Common"

func _on_rare_toggled(toggled_on: bool) -> void:
	if toggled_on == true:
		price = 100.0
		current_wheelspin_rarity = "Rare"

func _on_epic_toggled(toggled_on: bool) -> void:
	if toggled_on == true:
		price = 250.0
		current_wheelspin_rarity = "Epic"

func _on_mythic_toggled(toggled_on: bool) -> void:
	if toggled_on == true:
		price = 500.0
		current_wheelspin_rarity = "Mythic"

func _on_legendary_toggled(toggled_on: bool) -> void:
	if toggled_on == true:
		price = 1500.0
		current_wheelspin_rarity = "Legendary"
