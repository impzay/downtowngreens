extends AudioStreamPlayer

var music_toggled = false

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	self.volume_db = -18.0
	self.bus = "Music"
	
func play_track(track: AudioStream):
	if stream == track and playing:
		return
	stream = track
	play()

func _process(delta: float) -> void:
	if GameManager.paused:
		self.volume_db = -30.0
	else:
		self.volume_db = -18.0


func toggle_music():
	AudioServer.set_bus_mute(AudioServer.get_bus_index("Music"), !music_toggled)
	music_toggled = !music_toggled
