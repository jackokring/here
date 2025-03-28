extends AudioStreamPlayer

# Bass generator
const pan: Vector2 = Vector2(1.0, 1.0)
var playback: AudioStreamGeneratorPlayback
var rate: float
# zero crossing
var phase: float = 0.5
var time: float = 0.0
const bpm: float = 50.0
const npm: float = bpm * 4.0
var song_pos: int = 0
var lpf: AudioEffectFilter
var dlpf: AudioEffectFilter
var last_drum: int = -1
# Tune
enum { C, Cs, D, Ds, E, F, Fs, G, Gs, A, As, B }
enum { O0 = 1, O1 = 2, O2 = 4, O3 = 8, O4 = 16 }
const notes: PackedFloat32Array = [
	32.7032,# C
	34.64783, 36.7081, 38.89087, 41.20344,
	43.65353, 46.2493, 48.99943, 51.91309,
	27.5 * 2, 29.13524 * 2, 30.86771 * 2,
]
var drum: Array[AudioStreamPlayer]
enum { kick, snare, clap, open, close }
const env_mod: PackedFloat32Array = [
	#freqMul, envGain, rez
	#0 open
	32.0, 0.0, 0.77,
	#1 rez twang
	4.0, 3.0, 3.0,
	#2 neutral twang
	1.0, 2.0, 0.75,
	#3 west coat cut
	0.125, 0.0, 0.8,
]
const pat_step = 4
const pat_para = 8
const stride = pat_para * pat_step
const pats: PackedByteArray = [
	#0 [Note], oct, stutterCount, [envMod], [drum], [drumFiltNote], oct, [drumEnvMod]
	C, O0, 2, 0, kick, C, O3, 0,
	A, O0, 1, 1, open, A, O4, 1,
	F, O0, 4, 0, snare, F, O3, 0,
	E, O0, 1, 0, clap, E, O3, 1,
]
# 256 pattern limit
const song: PackedByteArray = [
	#Pat number
	0
]

func _ready() -> void:
	rate = 1 / stream.mix_rate
	drum = [
		#0 to 4
		$Kick, $Snare, $Clap, $Open, $Closed
	]
	lpf = AudioServer.get_bus_effect(AudioServer.get_bus_index("Bass"), 0) as AudioEffectFilter
	dlpf = AudioServer.get_bus_effect(AudioServer.get_bus_index("Drum"), 0) as AudioEffectFilter
	start()

func _process(delta: float) -> void:
	fill_buffer()

func start() -> void:
	play()
	playback = get_stream_playback()
	fill_buffer()

func fill_buffer() -> void:
	var frames: int = playback.get_frames_available()
	var bps: float = npm / 60.0
	var inc_env: float = bps * rate
	# filter delay approximation (envelope slow Nyquist)
	var fil_d: float = ((get_playback_position() + AudioServer.get_time_since_last_mix())
	* bps)
	var fil_t: float = 1.0 - fmod(fil_d, 1.0)
	var fil_p: int = int(fil_d)
	var fil_i: int = (song[fil_p / pat_step % song.size()]
	* stride + (fil_p % pat_step) * pat_para)
	# can set mod bus filter now
	var mod: int = pats[fil_i + 3]
	var dmod: int = pats[fil_i + 7]
	var freq: float = notes[pats[fil_i]] * pats[fil_i + 1]
	var df: float = env_mod[3 * mod + 1] * fil_t
	freq *= env_mod[3 * mod] * (1.0 + df)
	var rez: float = env_mod[3 * mod + 2]
	lpf.cutoff_hz = freq
	lpf.resonance = rez
	var dfreq: float = notes[pats[fil_i + 5]] * pats[fil_i + 6]
	var ddf: float = env_mod[3 * dmod + 1] * fil_t
	dfreq *= env_mod[3 * dmod] * (1.0 + ddf)
	var drez: float = env_mod[3 * dmod + 2]
	dlpf.cutoff_hz = dfreq
	dlpf.resonance = drez
	# and some drum
	if fil_i != last_drum:
		var d: AudioStreamPlayer = drum[pats[fil_i + 4]]
		# maybe use multiple channels
		d.play()
	last_drum = fil_i 
	for i in range(frames):
		var idx = (song[song_pos / pat_step % song.size()]
		* stride + (song_pos % pat_step) * pat_para)
		var inc: float = notes[pats[idx]] * rate * pats[idx + 1]
		time = fmod(time, 1.0)
		var env: float = 1.0 - fmod(pats[idx + 2] * time, 1.0)
		playback.push_frame((phase - 0.5) * env * pan)
		phase = fmod(phase + inc, 1.0)
		time += inc_env
		var quant = int(time)
		song_pos += quant
		# zero crossing start
		phase = (1 - quant) * phase + quant * 0.5
