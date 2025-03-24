extends TabContainer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_page_down"):
		Game.paused = !Game.paused
	visible = Game.paused
	if visible:
		self.get_tab_bar().grab_focus()


# open browser
func meta_clicked(meta: Variant) -> void:
	OS.shell_open(str(meta))
