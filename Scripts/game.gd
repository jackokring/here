extends Node

# Game globals
var level: int = 1
# sets impulse per frame
var speed_baseline: float = 3.0
# sets slow down fraction of velocity per frame
var friction: float = 0.05
var paused: bool = false
var playing: bool = false
