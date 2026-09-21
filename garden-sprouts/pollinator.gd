extends Node2D

var mouse_hover_able_plant = null

func _process(_delta: float) -> void:
	return

func move(new_pos):
	#calculate a smooth path eventually
	self.position = new_pos

func _input(inp: InputEvent) -> void:
	if inp is InputEventMouseButton and mouse_hover_able_plant:
		self.move(inp.position)

func _on_mouse_entered_plant(plant):
	print("moused")
	mouse_hover_able_plant = plant;
	
func _on_mouse_exited_plant(plant):
	mouse_hover_able_plant = null;
