class_name InventorySlot extends Panel

##Put the Item resource in this variable
@export var input_slot :ItemPart

@onready var item_display = $ItemDisplay
@onready var power_label = $PowerLabel

var mouse_inside :bool = false


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	take_properties()
	tooltip_text = input_slot.Name
	
	if GameStats.can_sell:
		power_label.text = str(input_slot.price)
	else:
		power_label.text = str(input_slot.power)
	
	if mouse_inside == true:
		if Input.is_action_just_pressed("mb1") and GameStats.can_sell:
			Collection.delete_item_list(input_slot)
			GameStats.Money += input_slot.price
			queue_free()

#function to take the items stats, like picture and put in into the slot
func take_properties():
	if !is_instance_valid(input_slot):
		return
	item_display.texture = input_slot.picture
	
	#make it so that the value above changes whether in sell mode or inventory mode
	if GameStats.can_sell:
		power_label.text = str(input_slot.price)
	else:
		power_label.text = str(input_slot.power)


func _on_mouse_entered():
	mouse_inside = true


func _on_mouse_exited():
	mouse_inside = false
