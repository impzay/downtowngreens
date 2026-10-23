extends Control

func _ready():
	%Start_Button.grab_focus()

func _on_quit_button_pressed():
	get_tree().quit()

func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/main.tscn")

func _on_tutorial_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/tutorial_screen.tscn")
