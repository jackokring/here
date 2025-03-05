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
var lpf: AudioEffectFilter

# Tune
const notes: Array[float] = [
	27.5, 29.13524, 30.86771, 32.7032,
	34.64783, 36.7081, 38.89087, 41.20344,
	43.65353, 46.2493, 48.99943, 51.91309,
]
const env_mod: Array[float] = [
	#0 freqMul, envGain, rez
	32.0, 1.0, 0.77,
	#1
	16.0, 3.0, 3.0
]
const pat_step = 4
const pat_para = 3
const stride = pat_para * pat_step
const pats: Array[int] = [
	#0 [Note], stutterCount, [envMod]
	0, 1, 0,
	11, 2, 1,
	5, 1, 0,
	7, 1, 0,
]
const song: Array[int] = [
	#Pat number
	0
]

func _ready() -> void:
	rate = 1 / stream.mix_rate
	lpf = AudioServer.get_bus_effect(AudioServer.get_bus_index("Bass"), 0) as AudioEffectFilter
	start()


func _process(delta: float) -> void:
	fill_buffer()


func start() -> void:
	play()
	playback = get_stream_playback()
	fill_buffer()


func fill_buffer() -> void:
	var frames: int = playback.get_frames_available()
	var bps: float = bpm / 60.0
	var inc_env: float = bps * rate
	# filter delay approximation (envelope slow Nyquist)
	var fil_d: float = ((get_playback_position() + AudioServer.get_time_since_last_mix())
	* bps)
	var fil_t: float = 1.0 - fmod(fil_d, 1.0)
	var fil_p: int = int(fil_d)
	var fil_i: int = (song[fil_p / pat_step % song.size()]
	* stride + (fil_p % pat_step) * pat_para)
	# can set mod bus filter now
	var mod: int = pats[fil_i + 2]
	var freq: float = notes[pats[fil_i]]
	var df: float = env_mod[3 * mod + 1] * fil_t
	freq *= env_mod[3 * mod] * (1.0 + df)
	var rez: float = env_mod[3 * mod + 2]
	lpf.cutoff_hz = freq
	lpf.resonance = rez 
	for i in range(frames):
		var idx = (song[song_pos / pat_step % song.size()]
		* stride + (song_pos % pat_step) * pat_para)
		var inc: float = notes[pats[idx]] * rate
		time = fmod(time, 1.0)
		var env: float = 1.0 - fmod(pats[idx + 1] * time, 1.0)
		playback.push_frame((phase - 0.5) * env * centre)
		phase = fmod(phase + inc, 1.0)
		time += inc_env
		song_pos += int(time)
