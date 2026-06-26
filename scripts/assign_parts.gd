extends Control

@export var added_power : float
var assigned_parts : Array = []
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var owned_items : Array = get_parent().given_items
	if Input.is_action_just_pressed("Test1"):
		add_parts(owned_items)
		owned_items.clear
		
func add_parts(owned_items):
	for i in owned_items:
		if i.type == 0:
			assigned_parts.append(i.Name)
			added_power += i.power
		elif i.type == 1:
			assigned_parts.append(i.Name)
			added_power += i.power
		elif i.type == 2:
			assigned_parts.append(i.Name)
			added_power += i.power
		elif i.type == 3:
			assigned_parts.append(i.Name)
			added_power += i.power
		elif i.type == 4:
			assigned_parts.append(i.Name)
			added_power += i.power
		elif i.type == 5:
			assigned_parts.append(i.Name)
			added_power += i.power
		elif i.type == 6:
			assigned_parts.append(i.Name)
			added_power += i.power
		elif i.type == 7:
			assigned_parts.append(i.Name)
			added_power += i.power
		elif i.type == 8:
			assigned_parts.append(i.Name)
			added_power += i.power
		elif i.type == 9:
			assigned_parts.append(i.Name)
			added_power += i.power
		elif i.type == 10:
			assigned_parts.append(i.Name)
			added_power += i.power
		elif i.type == 11:
			assigned_parts.append(i.Name)
			added_power += i.power
		elif i.type == 12:
			assigned_parts.append(i.Name)
			added_power += i.power
		elif i.type == 13:
			assigned_parts.append(i.Name)
			added_power += i.power
		elif i.type == 14:
			assigned_parts.append(i.Name)
			added_power += i.power
			
	$MarginContainer/VBoxContainer/Dropdown/Engine.add_item(assigned_parts[0])
	$MarginContainer/VBoxContainer/Dropdown/Tires.add_item(assigned_parts[1])
	$MarginContainer/VBoxContainer/Dropdown/Exhaust.add_item(assigned_parts[2])
	$MarginContainer/VBoxContainer/Dropdown/Aerodynamics.add_item(assigned_parts[3])
	$MarginContainer/VBoxContainer/Dropdown/Brake.add_item(assigned_parts[4])
	$MarginContainer/VBoxContainer/Dropdown/Transmission.add_item(assigned_parts[5])
	$MarginContainer/VBoxContainer/Dropdown/Suspension.add_item(assigned_parts[6])
	$MarginContainer/VBoxContainer/Dropdown/Turbocharger.add_item(assigned_parts[7])
	$MarginContainer/VBoxContainer/Dropdown/Supercharger.add_item(assigned_parts[8])
	$MarginContainer/VBoxContainer/Dropdown/Cooling_System.add_item(assigned_parts[9])
	$MarginContainer/VBoxContainer/Dropdown/Drivetrain.add_item(assigned_parts[10])
	$MarginContainer/VBoxContainer/Dropdown/Differential.add_item(assigned_parts[11])
	$MarginContainer/VBoxContainer/Dropdown/Fuel_System.add_item(assigned_parts[12])
	$MarginContainer/VBoxContainer/Dropdown/Weight_Reduction.add_item(assigned_parts[13])
	
