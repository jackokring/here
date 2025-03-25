extends TabContainer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_page_down"):
		Game.paused = !Game.paused
	var last: bool = visible
	visible = Game.paused
	# new visible first focus
	if visible:
		# focus handle only for logical last open
		if not last:
			self.get_tab_bar().grab_focus()
		# other focus checks to enter tabs?


# open browser
func meta_clicked(meta: Variant) -> void:
	OS.shell_open(str(meta))
