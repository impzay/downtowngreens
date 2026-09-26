extends AudioStreamPlayer

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	self.volume_db = -18.0
	self.bus = "Music"
	
func play_track(track: AudioStream):
	if stream == track and playing:
		return
	stream = track
	play()
