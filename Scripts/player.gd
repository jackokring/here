extends RigidBody2D
var last = Vector2(0, 0)


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	contact_monitor = true
	max_contacts_reported = 16


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func  _integrate_forces(state: PhysicsDirectBodyState2D) -> void:
	var vel = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	add_constant_central_force(10.0 * (vel - last))
	last = vel


# atlas pos collide 
func tile_collide(atlas: Array[Vector2i], id: Vector2i) -> void:
	match atlas:
		Atlas.field:
			match id:
				Atlas.field[Atlas.WALL]:
					$Bounce.play()
