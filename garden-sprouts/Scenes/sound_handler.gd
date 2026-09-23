extends Node2D

@onready var sound_player = $AudioStreamPlayer2D
var sounds_library = {
	"yay": preload("res://Assets/Sound/yay.mp3"),
	"button_click": preload("res://Assets/Sound/506054__mellau__button-click-1.wav"),
	"button_hover": preload("res://Assets/Sound/338229__fachii__button-hover.wav")
}

func get_sound(sound_name : String):
	if sounds_library.has(sound_name):
		sound_player.stream = sounds_library[sound_name]
		sound_player.play()
	else:
		push_error("Sound not found.")
		
func _ready() -> void:
	#add background music here
	return
