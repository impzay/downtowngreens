extends Node2D


func _process(_delta: float) -> void:
	return

func move(new_pos):
	#calculate a smooth path eventually
	self.position = new_pos;

func _input(inp: InputEvent) -> void:
	if inp is InputEventMouseButton and #able_plant is true:
		self.move(inp.position)
