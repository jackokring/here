extends Node

# Game globals
var level: int = 1
# sets impulse per frame
var speed_baseline: float = 50.0
# sets slow down fraction of velocity per frame
var friction: float = 0.8
var paused: bool = false
# playing is user interaction or if not then demo mode
var playing: bool = false
