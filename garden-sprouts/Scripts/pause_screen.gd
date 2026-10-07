extends Control

@onready var button_container = $CanvasLayer/Panel/VBoxContainer
@onready var pause_screen = $CanvasLayer

func _ready():
	pause_screen.visible = false

func _process(delta: float) -> void:
	pass 
	
	
func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed:
		if event.keycode == KEY_ESCAPE:
			show_pause_screen()
			

func show_pause_screen():
	if !pause_screen.visible:
		pause_screen.visible = true
		GameManager.paused = true
	else:
		pause_screen.visible = false 
		GameManager.paused = false


func _on_quit_pressed() -> void:
	GameManager.quit()


func _on_music_pressed() -> void:
	AudioHandler.toggle_music()


func _on_sound_pressed() -> void:
	pass


func _on_dialog_pressed() -> void:
	pass # Replace with function body.


func _on_captions_pressed() -> void:
	pass # Replace with function body.
