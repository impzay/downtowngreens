extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await get_tree().process_frame  # wait one frame for UI to load
	var ui = get_node("UI")
	ui.fade_out()
	
	AudioHandler.play_track(preload("res://Assets/Sound/sigmamusicart-background-music-jazz-597003.mp3"))
	
