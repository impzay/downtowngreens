extends Control

signal level_transition

@onready var black_screen = $ColorRect
var is_fading: bool = false
var fade_in: bool = false #true = fade to black, false = fade from black
var time: float = 0.0

func _ready() -> void:
	fade_out()
	
func _process(delta):
	if !is_fading:
		return
	
	time += delta * 1.0
	time = clamp(time, 0.0, 1.0)
	
	if fade_in:
		black_screen.color.a = lerp(0.0, 1.0, time)
	else:
		black_screen.color.a = lerp(1.0, 0.0, time)
	
	if time >= 1.0:
		is_fading = false
		time = 0.0

	
func fade():
	is_fading = true
	fade_in = true
	time = 0.0

func fade_out():
	is_fading = true
	fade_in = false
	time = 0.0
	
	
