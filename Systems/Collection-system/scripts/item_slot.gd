class_name InventorySlot extends Panel

##Put the Item resource in this variable
@export var input_slot :ItemPart

@onready var item_display = $ItemDisplay
@onready var power_label = $PowerLabel

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	take_properties()

#function to take the items stats, like picture and put in into the slot
func take_properties():
	if !is_instance_valid(input_slot):
		return
	item_display.texture = input_slot.picture
	power_label.text = str(input_slot.power)
