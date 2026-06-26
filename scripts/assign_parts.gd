extends Control

@export var added_power : float
var assigned_parts : Array = []
var current_owned_parts : Array[ItemPart] = []
var equipped_parts : Dictionary = {}

@onready var dropdown_options : Dictionary = {
	ItemPart.Types.Engine: $MarginContainer/VBoxContainer/EngineContainer/Engine,
	ItemPart.Types.Tires: $MarginContainer/VBoxContainer/TiresContainer/Tires
}
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$MarginContainer/POWER.text = "Power: " + str(added_power)
	for type in dropdown_options:
		var dropdown = dropdown_options[type]
		dropdown.item_selected.connect(on_part_selected.bind(type))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var owned_items : Array = get_parent().given_items
	if Input.is_action_just_pressed("Test1"):
		clear_options()
		add_parts(owned_items)
		owned_items.clear()

func clear_options():
	current_owned_parts.clear()
	for dropdown in dropdown_options.values():
		dropdown.clear()
	
	
func add_parts(owned_items):
	for item in owned_items:
		if dropdown_options.has(item.type):
			var selected_dropdown = dropdown_options[item.type]
			selected_dropdown.add_item(item.Name)
			
			var i = selected_dropdown.get_item_count() - 1
			selected_dropdown.set_item_metadata(i, item)
			
			current_owned_parts.append(item)
	
func on_part_selected(index: int, part_type) -> void:
	var dropdown = dropdown_options[part_type]
	var selected_part = dropdown.get_item_metadata(index) as ItemPart
	
	if selected_part:
		equipped_parts[part_type] = selected_part
		
		power_calculation()
		
		
func power_calculation():
	added_power = 0
	
	for type in equipped_parts:
		var part = equipped_parts[type]
		added_power = part.power
	
	$MarginContainer/POWER.text = "Power: " + str(added_power)
