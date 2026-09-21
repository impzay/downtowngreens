extends Node2D

var mouse_hover_able_plant = null
var is_moving: bool = false
var target_pos: Vector2 = Vector2.ZERO


@onready var sfx_handler = $Sound_Handler


func _process(delta: float) -> void:
	if !is_moving:
		return
	
	position = position.lerp(target_pos, delta * 1.5)
	
	if position.distance_to(target_pos) < 15.0:
		position = position
		is_moving = false
		task_completed()
		

func task_completed():
	celebrate()
	return
	
func celebrate():
	sfx_handler.get_child(0).play()
	


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
