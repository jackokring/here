extends TileMapLayer
var rand: RandomNumberGenerator = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	make_paths()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func make_paths() -> void:
	# generator based on level
	rand.seed = hash(Game.level)
	# total locations
	var total: int = Global.dim.x * Global.dim.y
	# 25 to 50%
	var paths: int = rand.randf_range(0.25, 0.5) * total
	var done: int = 0
	while not done > paths:
		# make a path
		var vert: bool = bool(rand.randi() % 2)
		if vert:
			var start: int = rand.randi_range(0, Global.dim.y - 1)
			var end: int = rand.randi_range(0, Global.dim.y - 1)
			var at: int = rand.randi_range(0, Global.dim.x - 1)
			if start > end:
				var t: int = end
				end = start
				start = t
			for i in range(start, end + 1):
				Global.pos_to_newtile(self, Vector2i(at, i), Atlas.field[Atlas.PATH])
			done += end - start + 1
		else:
			var start: int = rand.randi_range(0, Global.dim.x - 1)
			var end: int = rand.randi_range(0, Global.dim.x - 1)
			var at: int = rand.randi_range(0, Global.dim.y - 1)
			if start > end:
				var t: int = end
				end = start
				start = t
			for i in range(start, end + 1):
				Global.pos_to_newtile(self, Vector2i(i, at), Atlas.field[Atlas.PATH])
			done += end - start + 1
	# now merge based on neighbours
	for x in range(Global.dim.x):
		for y in range(Global.dim.y):
			if not_grass(Vector2i(x, y)):
				var U: bool = not_grass(Vector2i(x, y - 1))
				var D: bool = not_grass(Vector2i(x, y + 1))
				var L: bool = not_grass(Vector2i(x - 1, y))
				var R: bool = not_grass(Vector2i(x + 1, y))
				var i: int = int(U) + int(D) * 2 + int(L) * 4 + int(R) * 8
				# combined path join
				Global.pos_to_newtile(self, Vector2i(x, y), Atlas.paths[i])

func not_grass(pos: Vector2i) -> bool:
	var c: Vector2i = Global.pos_to_tile(self, pos)
	# not empty grass or wall so path at this point
	return (c != Atlas.field[Atlas.GRASS]) and (c != Atlas.field[Atlas.WALL])

# TileMapLayer collision kinematics
func use_atlas():
	return Atlas.field
