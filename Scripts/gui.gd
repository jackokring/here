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
			# update volume
			update_audio_selected($Setup/VList/Buses.selected)
			# update fullscreen
			$Setup/VList/FullScreen.set_pressed_no_signal(Global.get_fullscreen())
			# set locale lang
			for l in range(Global.lang_id.size()):
				if Global.get_lang() == Global.lang_id[l]:
					$Setup/VList/Lang.selected = l
			$Play.visible = true
			$Play/VList/Play.grab_focus()
		# when always visible
		if $Lore.visible or $Credits.visible:
			if Input.is_action_pressed("ui_up"):
				RTL_scroll_by($Lore/RichTextLabel, -10)
				RTL_scroll_by($Credits/RichTextLabel, -10)
			if Input.is_action_pressed("ui_down"):
				RTL_scroll_by($Lore/RichTextLabel, 10)
				RTL_scroll_by($Credits/RichTextLabel, 10)
	# hide
	if not visible and last:
		# save settings
		Global.save()

func RTL_scroll_by(rtl: RichTextLabel, by: int) -> void:
	rtl.get_v_scroll_bar().value += by

func save_exit() -> void:
	Global.save_exit()

# Audio updater
func update_audio_selected(selected: int) -> void:
	$Setup/VList/Volume.set_value_no_signal(Global.get_track_vol(Global.audio_id[selected]))

func update_audio_changed(value: float) -> void:
	Global.set_track_vol(Global.audio_id[$Setup/VList/Buses.selected], value)

func update_lang_selected(lang: int) -> void:
	Global.set_lang(Global.lang_id[lang])

# open browser
func meta_clicked(meta: Variant) -> void:
	OS.shell_open(str(meta))

func fullscreen_toggled(toggled_on: bool) -> void:
	Global.set_fullscreen(toggled_on)

func unpause() -> void:
	Game.paused = false
