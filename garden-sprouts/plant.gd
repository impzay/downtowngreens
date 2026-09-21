extends Node2D

signal mouse_entered_plant(plant);
signal mouse_exited_plant(plant);

func _ready():
	var pollinator = get_parent().get_node("Pollinator")
	mouse_entered_plant.connect(pollinator._on_mouse_entered_plant)
	mouse_exited_plant.connect(pollinator._on_mouse_exited_plant)

func _on_zone_mouse_entered() -> void:
	mouse_entered_plant.emit(self)

func _on_zone_mouse_exited() -> void:
	mouse_exited_plant.emit(self)
