extends TileMapLayer
signal tile_collide(id: Vector2i)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


# Field collision kinematics
# N.B. complex of body_entered as RID needed to extract tile from map
func body_shape_entered(body_rid: RID, body: Node, body_shape_index: int, local_shape_index: int) -> void:
	if body == self:
		var id: Vector2i = Global.rid_to_tile(self, body_rid)
		tile_collide.emit(id)
