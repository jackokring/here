extends RigidBody2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func  _integrate_forces(state: PhysicsDirectBodyState2D) -> void:
	add_constant_central_force(Vector2(1.0, 0.0))


func set_frame(number: int) -> void:
	$Sprite2D.frame = number
