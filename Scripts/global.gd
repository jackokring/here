extends Node
# Access by Global.
# Used as a global space for preventing the abstract class paradigm.
# this implies actual subroutines not to be duplicated and first parameter
# sometimes is class.
var config = ConfigFile.new()
var audio_id: Array[String] = [ "Master", "DNB", "SFX" ]
var lang_id: Array[String] = [ "en" ]
var rand = RandomNumberGenerator.new()

func _ready() -> void:
	rand.randomize()
	config.load("user://global.cfg")	# error?
	# audio
	for i in audio_id:
		set_track_vol(i, get_track_vol(i))
	# display
	set_fullscreen(get_fullscreen())
	set_lang(get_lang())

func save() -> void:
	config.save("user://global.cfg") # no error

func save_exit() -> void:
	save()
	get_tree().quit()

func reload() -> void:
	_ready()

## AudioServer
func  set_track_vol(id: String, percent: float) -> void:
	AudioServer.set_bus_volume_linear(AudioServer.get_bus_index(id), percent / 100.0)
	config.set_value("audio", id, percent)

func get_track_vol(id: String) -> float:
	var vol = AudioServer.get_bus_volume_linear(AudioServer.get_bus_index(id)) * 100.0
	return config.get_value("audio", id, vol)

## DisplayServer
# set fullscreen from options
func set_fullscreen(full: bool):
	config.set_value("display", "full", full)
	if full:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		# root window
		get_window().move_to_center()

func get_fullscreen():
	return config.get_value("display", "full", false)

func get_random_position(rand: RandomNumberGenerator) -> Vector2:
	var screen = get_viewport().get_visible_rect().size
	return Vector2(rand.randf_range(0, screen.x), rand.randf_range(0, screen.y))

func set_lang(lang: String):
	config.set_value("locale", "lang", lang)
	TranslationServer.set_locale(lang)

func get_lang():
	return config.get_value("locale", "lang", OS.get_locale_language())

## TileMapLayer
# get tile atlas pos at collision RID shape on tile map layer
func rid_to_tile(tile_map: TileMapLayer, rid: RID):
		var pos = tile_map.get_coords_for_body_rid(rid)
		return tile_map.get_cell_atlas_coords(pos)

# set tile atlas pos at collision RID shape on tile map layer
func rid_to_newtile(tile_map: TileMapLayer, rid: RID, atlas: Vector2i):
		var pos = tile_map.get_coords_for_body_rid(rid)
		tile_map.set_cell(pos, 1, atlas, 0)

# get tile atlas pos at pos
func pos_to_tile(tile_map: TileMapLayer, pos: Vector2i):
	return tile_map.get_cell_atlas_coords(pos)

# set tile atlas pos at pos
func pos_to_newtile(tile_map: TileMapLayer, pos: Vector2i, atlas: Vector2i):
	tile_map.set_cell(pos, 1, atlas, 0)

# has specific atlas
func map_to_atlas(tile_map: TileMapLayer):
	if tile_map.has_method("use_atlas"):
		return tile_map.use_atlas()
	return null

## RigidBody2D
# get atlas pos
func body_to_sprite(body: RigidBody2D):
	var sprite: Sprite2D = body.get_node("Sprite2D")
	return sprite.frame_coords

# set atlas pos
func body_to_newsprite(body: RigidBody2D, atlas: Vector2i):
	var sprite: Sprite2D = body.get_node("Sprite2D")
	sprite.frame_coords = atlas

# get body type
func body_to_type(body: RigidBody2D):
	if body.has_method("is_type"):
		return body.is_type()
	return null
