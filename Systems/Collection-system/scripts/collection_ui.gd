extends Control

@onready var grid_container :GridContainer = $GridContainer

const ITEM_SLOT = preload("uid://crqxbbtpnsvyf")


var new_slot# variable for creating a new slot
var deleted_slot #variable for deleting a slot
# Called when the node enters the scene tree for the first time.
func _ready():
	#create_slots()
	#set slots per item in inventory
	ItemPart.Rarities.keys().pick_random()
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	create_slots()
	delete_slots()
	set_properties()

#create slots per item in inventory
func create_slots():
	new_slot = ITEM_SLOT.instantiate()
	#make sure slots are not filled
	if grid_container.get_child_count() >= Collection.Items.size():
		return
	for i in Collection.Items.size():
		#i += 1
		grid_container.add_child(new_slot)
		#print(i)

#function to delete the slots
func delete_slots():
	if Collection.Items.size() >= grid_container.get_child_count():
		return
	grid_container.get_child(grid_container.get_child_count() - 1).queue_free()#deletes the last slot
	#print("slot deleted")

func set_properties():
	var slots = []
	#put in grid children into an array
	for i in grid_container.get_children():
		if i in grid_container.get_children():
			if i.get_child_count() > 0:
				slots.append(i)
				slots.append_array(slots)
			
			else:
				slots.append(i)
	#give each child in slots an input slot from the invnetory
	for i in slots:
		for j in Collection.Items:
			i.input_slot = j
	return slots
	
func _on_button_pressed():
	Collection.delete_item(0)
	print(Collection.Items.size())
	#Collection.add_item(ItemPart.Types.ENGINE, ItemPart.Rarities.RARE)
