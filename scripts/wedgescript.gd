extends Area2D

var prize_type : String
var rolled_rarity : String

const COLOR_TINT = {
	"Common" : Color(0.536, 0.562, 0.535, 1.0), 
	"Rare" : Color(0.0, 0.871, 0.235, 1.0),
	"Epic": Color(0.668, 0.182, 0.95, 1.0),
	"Mythic": Color(0.976, 0.0, 0.0, 1.0),
	"Legendary": Color(0.976, 0.937, 0.216, 1.0)
}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func give_rarity_tint():
	var prize = get_child(1)
	if prize:
		prize.modulate = COLOR_TINT.get(rolled_rarity, Color(1,1,1)) 

func roll_rarity():
	get_child(1).set_name(prize_type)
	rolled_rarity = get_parent().give_rarity("", "")
	give_rarity_tint()
	get_icon(prize_type)
	prize_type = ""

	
func get_icon(type):
	var texture = get_parent().prizes_icons.get(type)
	if type:
		get_child(1).texture = texture
		get_child(1).scale = Vector2(3,3)
