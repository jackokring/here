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
			# update volume
			update_audio_selected($Setup/VList/Buses.selected)
			# update fullscreen
			$Setup/VList/FullScreen.set_pressed_no_signal(Global.get_fullscreen())
		# other focus checks to enter tabs?
		
	# hide
	if not visible and last:
		# save settings
		Global.save()

# Audio updater
func update_audio_selected(selected: int) -> void:
	$Setup/VList/Volume.set_value_no_signal(Global.get_track_vol(Global.audio_id[selected]))

func update_audio_changed(value: float) -> void:
	Global.set_track_vol(Global.audio_id[$Setup/VList/Buses.selected], value)

# open browser
func meta_clicked(meta: Variant) -> void:
	OS.shell_open(str(meta))

func fullscreen_toggled(toggled_on: bool) -> void:
	Global.set_fullscreen(toggled_on)
