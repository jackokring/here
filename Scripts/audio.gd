extends AudioStreamPlayer

# Bass generator
const centre = Vector2(1.0, 1.0)
var playback
var rate
var freq = 440.0 / 8
# zero crossing
var phase = 0.5
var time = 0.0
var bpm = 120.0 * 2


func _ready() -> void:
	rate = 1 / stream.mix_rate
	start()


func _process(delta: float) -> void:
	fill_buffer()


func start():
	play()
	playback = get_stream_playback()
	fill_buffer()


func fill_buffer():
	var frames = playback.get_frames_available()
	var inc_env = bpm / 60.0 * rate
	for i in range(frames):
		var inc = freq * rate
		playback.push_frame((phase - 0.5) * (1.0 - time) * centre)
		phase = fmod(phase + inc, 1.0)
		time = fmod(time + inc_env, 1.0)
