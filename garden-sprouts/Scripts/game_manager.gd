extends Node

var level: int = 1;
var total_tasks_completed: int = 0;
var game_won: bool = false
var paused: bool = false
var regular_cursor = preload("res://Assets/Sprites/kenney_cursor-pixel-pack/Tiles/tile_0028.png")
var selector_cursor = preload("res://Assets/Sprites/kenney_cursor-pixel-pack/Tiles/tile_0135.png")


signal mouse_entered_plant();
signal mouse_exited_plant();


func _ready():
	Input.set_custom_mouse_cursor(regular_cursor, Input.CURSOR_ARROW, Vector2(0, 0))

func _on_hover_enter(plant):
	Input.set_custom_mouse_cursor(selector_cursor, Input.CURSOR_ARROW, Vector2(0,0))
	
func _on_hover_exit(plant):
	Input.set_custom_mouse_cursor(regular_cursor, Input.CURSOR_ARROW, Vector2(0, 0))
	
func next_level():
	
	level += 1;
	total_tasks_completed = 0;
	
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
	total_tasks_completed = 0
	get_tree().change_scene_to_file("res://Scenes/main.tscn")

func quit():
	get_tree().quit()
	
