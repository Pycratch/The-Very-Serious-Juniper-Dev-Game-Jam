extends Sprite2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var easeOutQuadtween = create_tween()
	easeOutQuadtween.set_trans(Tween.TRANS_CIRC)
	easeOutQuadtween.set_ease(Tween.EASE_OUT)
	easeOutQuadtween.tween_property(self, "global_rotation", randi() % 70 + 40, 2.5)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
