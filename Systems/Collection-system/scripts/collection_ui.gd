extends Control
#inventory/collection ui
@onready var grid_container :GridContainer = $GridContainer

@export var game_ui :Control

const ITEM_SLOT = preload("uid://crqxbbtpnsvyf")
var deleted_slot #variable for deleting a slot
var given_items : Array = []

# Called when the node enters the scene tree for the first time.
func _ready():
	print()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	create_slots()
	delete_slots()
	set_properties()

#create slots per item in inventory
func create_slots():
	if grid_container.get_child_count() >= Collection.Items.size():
		return
	for i in Collection.Items.size() - grid_container.get_child_count():
		var slot = ITEM_SLOT.instantiate()
		grid_container.add_child(slot)

#function to delete the slots
func delete_slots():
	if Collection.Items.size() >= grid_container.get_child_count():
		return
	grid_container.get_child(grid_container.get_child_count() - 1).queue_free() #deletes the last slot

func set_properties():
	given_items.clear()
	var slots = []
	#put in grid children into an array
	for i in grid_container.get_children():
		slots.append(i)

	#give each slot the matching item from the inventory, by index
	for index in slots.size():
		if index >= Collection.Items.size():
			break  #more slots than items, nothing left to assign
		slots[index].input_slot = Collection.Items[index]
		given_items.append(Collection.Items[index])

func toggle_visibility(ui):
	ui.visible = !ui.visible
	self.visible = !self.visible


func _on_leave_pressed():
	toggle_visibility(game_ui)
