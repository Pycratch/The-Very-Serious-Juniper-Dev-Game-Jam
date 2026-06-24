class_name Inventory extends Node

@export var Items :Array[ItemPart]

#add item while creating it
func create_item(type :ItemPart.Types, rarity :ItemPart.Rarities):
	var new_item = ItemPart.new()
	new_item.type = type
	new_item.rarity = rarity
	add_item(new_item)

func add_item(part :ItemPart):
	Items.append(part)


#Function to remove an item in the inventory
func delete_item(index):
	Items.remove_at(index)
