extends Node
# Access by Global.
# Used as a global space for preventing the abstract class paradigm.
# this implies actual subroutines not to be duplicated and first parameter
# sometimes is class.


## TileMapLayer
# get tile atlas pos at collision RID shape on tile map layer
func rid_to_tile(tile_map: TileMapLayer, rid: RID):
		var pos = tile_map.get_coords_for_body_rid(rid)
		return tile_map.get_cell_atlas_coords(pos)


# set tile atlas pos at collision RID shape on tile map layer
func rid_to_newtile(tile_map: TileMapLayer, rid: RID, atlas: Vector2i):
		var pos = tile_map.get_coords_for_body_rid(rid)
		tile_map.set_cell(pos, -1, atlas, 0)


# get tile atlas pos at pos
func pos_to_tile(tile_map: TileMapLayer, pos: Vector2i):
	return tile_map.get_cell_atlas_coords(pos)


# set tile atlas pos at pos
func pos_to_newtile(tile_map: TileMapLayer, pos: Vector2i, atlas: Vector2i):
	tile_map.set_cell(pos, -1, atlas, 0)


## RigidBody2D
# get atlas pos
func body_to_sprite(body: RigidBody2D):
	var sprite: Sprite2D = body.get_node("Sprite2D")
	return sprite.frame_coords


# set atlas pos
func body_to_newsprite(body: RigidBody2D, atlas: Vector2i):
	var sprite: Sprite2D = body.get_node("Sprite2D")
	sprite.frame_coords = atlas
