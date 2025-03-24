extends Node
# Access by Global.
# Used as a global space for preventing the abstract class paradigm.
# this implies actual subroutines not to be duplicated and first parameter
# sometimes is class.


## DisplayServer
# set fullscreen from options
func set_fullscreen(full: bool):
	if full:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)


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
