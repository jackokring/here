extends AudioStreamPlayer

# Bass generator
const centre: Vector2 = Vector2(1.0, 1.0)
var playback: AudioStreamGeneratorPlayback
var rate: float
# zero crossing
var phase: float = 0.5
var time: float = 0.0
var bpm: float = 120.0 * 2
var song_pos: int = 0

# Tune
const notes: Array[float] = [
	27.5, 29.13524, 30.86771, 32.7032,
	34.64783, 36.7081, 38.89087, 41.20344,
	43.65353, 46.2493, 48.99943, 51.91309
]
const pat_step = 4
const pat_para = 1
const pats: Array[int] = [
	#0 Note number,
	0,
	11,
	5,
	7
]
const song: Array[int] = [
	#Pat number
	0
]

func _ready() -> void:
	rate = 1 / stream.mix_rate
	start()


func _process(delta: float) -> void:
	fill_buffer()


func start() -> void:
	play()
	playback = get_stream_playback()
	fill_buffer()


func fill_buffer() -> void:
	var frames: int = playback.get_frames_available()
	var inc_env: float = bpm / 60.0 * rate
	for i in range(frames):
		var note = notes[pats[song[song_pos / pat_step % song.size()] 
		* pat_step * pat_para + (song_pos % pat_step) * pat_para]]
		var inc: float = note * rate
		playback.push_frame((phase - 0.5) * (1.0 - time) * centre)
		phase = fmod(phase + inc, 1.0)
		time += inc_env
		song_pos += int(time)
		time = fmod(time, 1.0)
