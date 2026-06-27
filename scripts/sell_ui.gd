extends Control

@onready var GameUI = get_parent().get_node("GameUI")
@onready var sell_container = $SellContainer
@onready var money_label = $MoneyLabel


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	money_label.text = str(GameStats.Money)
	if visible:
		GameStats.can_sell = true
		print(GameStats.can_sell)
	else:
		GameStats.can_sell = false


func _on_leave_pressed() -> void:
	toggle_visibility(GameUI)


func toggle_visibility(ui):
	ui.visible = !ui.visible
	self.visible = !self.visible

func selling():
	if sell_container.mouse_inside != true:
		return
	if !Input.is_action_just_pressed("mb1"):
		return
	
