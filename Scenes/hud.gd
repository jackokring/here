extends Node2D
var top: float = 100.0
var bottom: float = 100.0

# draw
func _draw() -> void:
	var rect: Rect2 = Global.top_rect()
	rect.size.x *= top / 100.0
	draw_rect(rect, Color.REBECCA_PURPLE)
	rect = Global.bottom_rect()
	rect.size.x *= top / 100.0
	draw_rect(rect, Color.BLUE_VIOLET)

func _process(delta: float) -> void:
	queue_redraw()
