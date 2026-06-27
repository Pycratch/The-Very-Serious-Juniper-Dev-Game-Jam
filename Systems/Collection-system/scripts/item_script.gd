class_name ItemPart extends Resource

enum Types {
Engine, Tires, Exhaust, Aerodynamics, Supercharger, 
Transmission, Suspension, Brakes, Turbocharger,
Fuel_System, Differential, Drivetrain,
Weight_Reduction, Cooling_System
}
enum Rarities {Common, Rare, Epic, Mythic, Legendary}

@export var Name :String
@export var type :Types
@export var rarity :Rarities
@export var price :float = 1
@export var power :float = 1
@export var picture :Texture2D = preload("uid://bxog1jit3v6og")

var rng = RandomNumberGenerator.new()
var final_prize :String
var prize_list :Array

var common_weight : float = 60.0
var rare_weight : float = 25.0
var epic_weight : float = 15
var mythic_weight : float = 7.5
var legendary_weight : float = 2.5

#the types for all the stuff


var prizes : Dictionary = {
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

func _init():
	Name = Rarities.keys()[rarity] + " " + Types.keys()[type]
	print(type)
	#print(type_string)
	#rodeo()
	#print(typeof(Types.keys()[type]))
	#print(Types.keys().find("Engine")) #This will set type from a string
	

func rodeo():
	set_up_prizes()
	randomize_type()
	randomize_rarity()
	finalize_final_prize()
	calculate_price()
	calculate_power()
	Name = Rarities.keys()[rarity] + " " + final_prize

func set_up_prizes():
	prizes = {
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

var type_string :String

func randomize_type():
	#trying to randomize type and giving it an output of the name of the type
	
	type = Types.values().pick_random()######
	#print(Types.keys()[type])#prints out the index of type
	type_string = Types.keys()[type]
	#print(type_string)

var rarity_string :String
func randomize_rarity():
	#randomize rarity weighted
	rarity = Rarities.values()[rng.rand_weighted([common_weight, rare_weight, epic_weight, mythic_weight, legendary_weight])]
	#prints out the rarity as a string
	#print(Rarities.keys()[rarity])
	rarity_string = Rarities.keys()[rarity]
	Name = Rarities.keys()[rarity] + " " + final_prize
	return rarity_string

func set_rarity(rarity):
	rarity_string = rarity
	rarity = Rarities.values()[Rarities.keys().find(rarity_string)]
	#rarity_string = Rarities.keys()[rarity]
	Name = Rarities.keys()[rarity] + " " + final_prize

func finalize_final_prize():
	#get the prize item using the type as an index to get stuff IDK
	
	prize_list = prizes.get(Types.keys()[type])# same as the line under defining type, line with a lot of ##
	if not prize_list:
		return
	final_prize = prize_list.pick_random()
	Name = Rarities.keys()[rarity] + " " + final_prize

func calculate_price():
	if not prize_list:
		return
	var prize_index = prize_list.find(final_prize) + 1
	var prize_index2 = (rarity + 1) * 5
	price = prize_index2 * 50 + prize_index * 100


func calculate_power():
	if not prize_list:
		return
	#get the index of the itemtype from the array
	var prize_index = prize_list.find(final_prize) + 1
	var prize_index2 = (rarity + 1) * 5
	power = prize_index2 * 10 + prize_index * 10
	print("power calculated")
