extends Control

func _ready():
	$CenterContainer/VBoxContainer/Start_Button.grab_focus()
	
func _on_play_button_pressed():
		get_tree().change_scene_to_file("res://main.tscn")
	
func _on_quit_button_pressed():
	get_tree().quit()
