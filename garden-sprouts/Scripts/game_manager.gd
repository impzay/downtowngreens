extends Node

var level: int = 1;
var total_plants_pollinated: int = 0;

func next_level():
	level += 1;
	total_plants_pollinated = 0;
	get_tree().change_scene_to_file("res://Scenes/Level%d.tscn" % level)

func get_level():
	return level
