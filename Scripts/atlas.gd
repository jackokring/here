extends Node

## Atlas indexes for checks of collision etc.
# directional path filling
enum { Z, U, D, UD, L, LU, LD, LUD, R, RU, RD, RUD, RL, RLU, RLD, RLUD }
const paths: Array[Vector2i] = [
	# 2, 5 and 3, 4 sort of duplicates
	# of 2, 3 and 1, 4 ... gates?
	Vector2i(0, 2), Vector2i(4, 5), Vector2i(4, 4), Vector2i(1, 4),
	Vector2i(5, 5), Vector2i(3, 5), Vector2i(3, 3), Vector2i(5, 2),
	Vector2i(5, 4), Vector2i(1, 5), Vector2i(1, 3), Vector2i(4, 2),
	Vector2i(2, 3), Vector2i(5, 3), Vector2i(4, 3), Vector2i(2, 4),
]
# collider comparison
enum { WALL, GRASS, PATH }
const field: Array[Vector2i] = [Vector2i(0, 0), Vector2i(0, 2), Vector2i(2, 1)]
