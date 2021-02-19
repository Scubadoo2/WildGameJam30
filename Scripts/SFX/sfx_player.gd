extends Node

# All sfx that will be used
export (Dictionary) var sfxs

# Keys - sfx_name -> Value - (sfx, stream_player)
var sfx_map = {}

func _ready():
	setup_sfx(sfxs)

func setup_sfx(p_sfxs: Dictionary):
	var sfx_names = p_sfxs.keys()
	for sfx_n in sfx_names:
		# get name and sfx audio
		var audio = sfx_map[sfx_n]
		# create audio player
		var audio_stream = AudioStreamPlayer.new()
		audio_stream.stream = audio
		# add PlayerNSFX onto sfx_map
		sfx_map[sfx_n] = audio_stream

##############
## Interface
##############

func play_sfx(sfx_name: String, volume_db: float):
	var sfx_n_player = get_sfx_player(sfx_name)
	if sfx_n_player != null:
		sfx_n_player.audio_stream.volume_db = volume_db
		sfx_n_player.audio_stream.play()

	
func stop_sfx(sfx_name: String):
	var sfx_n_player = get_sfx_player(sfx_name)
	if sfx_n_player != null:
		sfx_n_player.audio_stream.stop()

func get_sfx_player(sfx_name: String) -> AudioStreamPlayer:
	if sfx_map.has(sfx_map):
		return sfx_map.get(sfx_name)
	return null

