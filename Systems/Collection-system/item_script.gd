class_name ItemPart extends Resource

enum Types {ENGINE, TIRES, EXHAUST, AERODYNAMICS, SUPERCHARGER, TRANSMISSION, SUSPENSION, BRAKES}
enum Rarities {COMMON, RARE, EPIC, MYTHIC, LEGENDARY}

@export var type :Types = Types.ENGINE
@export var rarity :Rarities
@export var price :float = 1000
@export var power :float = 1
@export var picture :Texture2D = preload("uid://bxog1jit3v6og")
