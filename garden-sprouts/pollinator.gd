extends Node2D

var mouse_hover_able_plant = null
var is_moving: bool = false
var target_pos: Vector2 = Vector2.ZERO

func _process(delta: float) -> void:
	if is_moving:
		position = position.lerp(target_pos, delta * 1.5)
		
	if position.distance_to(target_pos) < 2.0:
		position = target_pos
		is_moving = false	

func move(new_pos):
	target_pos = new_pos
	is_moving = true

func _input(inp: InputEvent) -> void:
	if inp is InputEventMouseButton and mouse_hover_able_plant:
		self.move(inp.position)

func _on_mouse_entered_plant(plant):
	mouse_hover_able_plant = plant;
	
func _on_mouse_exited_plant(plant):
	mouse_hover_able_plant = null;
