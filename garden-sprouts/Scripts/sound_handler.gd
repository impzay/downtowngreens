extends Node2D

@onready var sound_player: AudioStreamPlayer2D = $AudioStreamPlayer2D
var sfx_muted: bool = false

func _ready():
	pass

var sounds_library = {
	"flying": preload("res://Assets/Sound/Locusts1.wav"),
	"yay": preload("res://Assets/Sound/yay.mp3"),
	"button_click": preload("res://Assets/Sound/506054__mellau__button-click-1.wav"),
	"button_hover": preload("res://Assets/Sound/338229__fachii__button-hover.wav")
}

func get_sound(sound_name: String):
	if not sounds_library.has(sound_name):
		push_error("Sound not found: " + sound_name)
		return

	var player := AudioStreamPlayer.new()
	player.stream = sounds_library[sound_name]
	player.volume_db = -12.0
	player.bus = "SFX"                          
	add_child(player)
	player.play()
	player.finished.connect(player.queue_free) 

func mute_sounds():
	sfx_muted = !sfx_muted
	AudioServer.set_bus_mute(AudioServer.get_bus_index("SFX"), sfx_muted)
