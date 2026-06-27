extends Control

@onready var CategoryButton = $MarginContainer/VBoxContainer/HBoxContainer/CategoryButton
@onready var PartsButton = $MarginContainer/VBoxContainer/HBoxContainer/PartsButton
@export var added_power : float
var assigned_parts : Array = []
var current_owned_parts : Array[ItemPart] = []
@export var equipped_parts : Dictionary = {}

func _process(delta: float) -> void:
	pass

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	EventBus.inventory_updated.connect(refresh_inventory)
	$MarginContainer/POWER.text = "Power: " + str(added_power)
	
	CategoryButton.item_selected.connect(_on_category_button_item_selected)
	PartsButton.item_selected.connect(_on_parts_button_item_selected)
	CategoryButton.clear()
	for category_name in ItemPart.Types.keys():
		CategoryButton.add_item(category_name)
	refresh_inventory()

func refresh_inventory():
	current_owned_parts.clear()
	PartsButton.clear()
	
	for item in Collection.Items:
		current_owned_parts.append(item)
	
	var current_idx = CategoryButton.selected
	if current_idx != -1:
		_on_category_button_item_selected(current_idx)
		
func add_parts(owned_items):
	for item in owned_items:
		current_owned_parts.append(item)
		
func power_calculation():
	added_power = 0
	
	for type in equipped_parts:
		var part = equipped_parts[type]
		added_power += part.power
	
	GameStats.Power = added_power
	$MarginContainer/POWER.text = "Power: " + str(added_power)

func _on_category_button_item_selected(index: int) -> void:
	var selected_category = CategoryButton.get_item_text(index)
	PartsButton.clear()
	
	if not ItemPart.Types.has(selected_category):
		return
			
	var target_type_enum = ItemPart.Types[selected_category]
	
	for item in current_owned_parts:
		if item.type == target_type_enum:
			PartsButton.add_item(item.Name)
			var i = PartsButton.get_item_count() - 1
			PartsButton.set_item_metadata(i, item)


func _on_parts_button_item_selected(index: int) -> void:
	var selected_part = PartsButton.get_item_metadata(index) as ItemPart
	
	if selected_part:
		equipped_parts[selected_part.type] = selected_part
	
	power_calculation()
