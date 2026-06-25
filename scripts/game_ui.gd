extends Control

@onready var WheelspinUI = get_parent().get_node("WheelspinUI")
@onready var SellUI = get_parent().get_node("SellUI")
@export var InventoryUI :Control
@onready var MoneyLabel = %MoneyLabel

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	set_money()

func _on_wheelspin_pressed() -> void:
	toggle_visibility(WheelspinUI)

func _on_sell_pressed() -> void:
	toggle_visibility(SellUI)

func toggle_visibility(ui):
	ui.visible = !ui.visible
	self.visible = !self.visible

func set_money():
	var money = GameStats.Money
	MoneyLabel.text = "Money: " + str(money)


func _on_inventory_pressed():
	if InventoryUI:
		toggle_visibility(InventoryUI)
