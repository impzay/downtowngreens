extends Node2D

var mouse_over_plant = null
var is_moving: bool = false
var target_pos: Vector2 = Vector2.ZERO
var total_plants_pollinated: int = 0;
var held_pollen: String = "";
var level: int = 1
@onready var sfx_handler = $Sound_Handler

func _process(delta: float) -> void:
	if !is_moving:
		return
	
	position = position.lerp(target_pos, delta * 1.5)
	
	#task gets completed if a plant is successfully pollinated.
	if position.distance_to(target_pos) < 15.0:
		is_moving = false
		task_completed()
		

func task_completed():
	#check if all plants are pollinated and update # of remaining plants to be pollinated
	GameManager.total_plants_pollinated += 1;
	if GameManager.level == 1:
		if GameManager.total_plants_pollinated >= 2:
			celebrate()
			GameManager.next_level()
	elif GameManager.level == 2:
		if GameManager.total_plants_pollinated >= 3:
			celebrate()
			GameManager.next_level()
	elif GameManager.level == 3:
		if GameManager.total_plants_pollinated >= 4:
			celebrate()
			win()
			
func celebrate():
	play_sound("yay")
	#add celebration animation here

func win():
	print("you win!")
	#play again button pops up 
	
func play_sound(sound_name : String):
	sfx_handler.get_sound(sound_name)

func move(new_pos):
	target_pos = new_pos
	is_moving = true

func _input(inp: InputEvent) -> void:
	if inp is InputEventMouseButton and inp.button_index == MOUSE_BUTTON_LEFT and inp.pressed:
		play_sound("button_click")
		if mouse_over_plant and !mouse_over_plant[1]:
			mouse_over_plant[1] = true
			set_pollen(mouse_over_plant) 
			
		self.move(inp.position)
	
func _on_mouse_entered_plant(plant):
	set_plant(plant)
	play_sound("button_hover")
	
func _on_mouse_exited_plant(plant):
		mouse_over_plant = null;

func set_pollen(plant):
	if plant == null:
		return
	
	held_pollen = plant[0]
	#print("Updated held pollen to ", held_pollen)
	
func get_pollen():
	return held_pollen

func set_plant(plant):
	mouse_over_plant = plant
	print("Currently Selected Plant: ", mouse_over_plant)

func get_plant():
	return mouse_over_plant
