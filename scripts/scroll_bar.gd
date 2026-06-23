extends ScrollContainer

@export var scroll_speed = 200
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	scroll_vertical += scroll_speed * delta
	
	var scrollbar = get_v_scroll_bar()
	var max_scroll = scrollbar.max_value - scrollbar.page
	
	if scroll_vertical >= max_scroll:
		scroll_vertical = 0
