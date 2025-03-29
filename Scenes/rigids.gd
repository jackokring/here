extends CanvasGroup

# load scenes
var scenes: Array[PackedScene] 
func load_scenes() -> void:
	for i in range(Body.names.size()):
		scenes.append(load("res://Scenes/" + Body.names[i] + ".tscn"))

func _ready() -> void:
	load_scenes()

# Use enum of Body.PLAYER, etc.
func add_rigid(body: int) -> RigidBody2D:
	var b: RigidBody2D = scenes[body].instantiate()
	# add
	add_child(b)
	return b
