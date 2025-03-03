extends AudioStreamPlayer

# Bass generator
const centre = Vector2(1.0, 1.0)
var playback
var rate
var freq = 440.0 / 8
# zero crossing
var phase = 0.5

func _ready() -> void:
	rate = stream.mix_rate
	start()


func _process(delta: float) -> void:
	fill_buffer()

func start():
	play()
	playback = get_stream_playback()
	fill_buffer()


func fill_buffer():
	var inc = freq / rate
	var frames = playback.get_frames_available()
	
	for i in range(frames):
		playback.push_frame(centre * (phase - 0.5))
		phase = fmod(phase + inc, 1.0)
