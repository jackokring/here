extends Node
# Access by $Global

# get tile atlas pos at collision RID shape on tile
func rid_to_tile(tile_map: TileMapLayer, rid: RID):
		var pos = tile_map.get_coords_for_body_rid(rid)
		return tile_map.get_cell_atlas_coords(pos)
