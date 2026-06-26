extends Control

@onready var GameUI = get_parent().get_node("GameUI")
@onready var MoneyLabel = %MoneyLabel

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var money = GameStats.Money
	MoneyLabel.text = "Money: \n" + str(money)

func _on_button_pressed() -> void:
	toggle_visibility(GameUI)

func toggle_visibility(ui):
	ui.visible = !ui.visible
	self.visible = !self.visible

func disable_all():
	$MarginContainer/Left/COMMON.disabled = true
	$MarginContainer/Left/RARE.disabled = true
	$MarginContainer/Left/EPIC.disabled = true
	$MarginContainer/Left/MYTHIC.disabled = true
	$MarginContainer/Left/LEGENDARY.disabled = true
	
func enable_all():
	$MarginContainer/Left/COMMON.disabled = false
	$MarginContainer/Left/RARE.disabled = false
	$MarginContainer/Left/EPIC.disabled = false
	$MarginContainer/Left/MYTHIC.disabled = false
	$MarginContainer/Left/LEGENDARY.disabled = false
