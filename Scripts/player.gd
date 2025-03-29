extends RigidBody2D
var loaded: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	body_shape_entered.connect(on_body_shape_entered)
	contact_monitor = true
	max_contacts_reported = 16
	loader()

func loader() -> void:
	loaded = false
	modulate = 0xffffff7f
	$Loading.start()
	position = Global.get_random_position(Global.rand)

func end_loader() -> void:
	modulate = 0xffffffff
	loaded = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	freeze = Game.paused
	if freeze:
		return

func  _integrate_forces(state: PhysicsDirectBodyState2D) -> void:
	var input = Game.speed_baseline * Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	state.apply_central_impulse(input * state.step)
	state.apply_central_impulse(-Game.friction * state.linear_velocity * state.step)

# atlas pos collide 
func map_collide(atlas: Array[Vector2i], id: Vector2i) -> void:
	# maybe not "loaded" delay for collides
	match atlas:
		Atlas.field:
			match id:
				Atlas.field[Atlas.WALL]:
					$Bounce.play()

# body collide
# use body for information exchange?
func body_collide(kind: int, body: RigidBody2D):
	# maybe not "loaded" delay for collides
	match kind:
		Body.PLAYER:
			pass

# all colliders
func on_body_shape_entered(body_rid: RID, body: Node, body_shape_index: int, local_shape_index: int) -> void:
	if body is TileMapLayer:
		var id: Vector2i = Global.rid_to_tile(body, body_rid)
		map_collide(Global.map_to_atlas(body), id)
	if body is RigidBody2D:
		body_collide(Global.body_to_type(body), body)

func is_type():
	return Body.PLAYER
