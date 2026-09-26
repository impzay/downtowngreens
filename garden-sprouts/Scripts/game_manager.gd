extends Node

var level: int = 1;
var total_plants_pollinated: int = 0;
var game_won: bool = false

func next_level():
	
	level += 1;
	total_plants_pollinated = 0;
	
	var ui = get_tree().current_scene.get_node("UI")
	ui.fade()
	await get_tree().create_timer(1.0).timeout
	
	get_tree().change_scene_to_file("res://Scenes/level%d.tscn" % level)
	
	await get_tree().create_timer(0.1).timeout
	var new_ui = get_tree().current_scene.get_node("UI")
	new_ui.black_screen.color = Color(0, 0, 0, 1)  # ensure starts black
	new_ui.fade_out()
	
func get_level():
	return level

func restart():
	game_won = false
	level = 1
	total_plants_pollinated = 0
	get_tree().change_scene_to_file("res://Scenes/main.tscn")
