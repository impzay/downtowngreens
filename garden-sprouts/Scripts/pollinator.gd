extends Node2D

var mouse_over_plant = null
var is_moving: bool = false
var target_pos: Vector2 = Vector2.ZERO
var total_plants_pollinated: int = 0;
var held_pollen: String = "";
var level: int = 1
@export var transition_time: int
@onready var sfx_handler = get_parent().get_node("Sound_Handler")
@onready var sprite = $AnimatedSprite2D

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	if !is_moving:
		return
	
	position = position.lerp(target_pos, delta * 1.5)
	
	#task gets completed if a plant is successfully pollinated.
	if position.distance_to(target_pos) < 15.0:
		is_moving = false
		#task_completed()
		

func task_completed():
	#check if all plants are pollinated and update # of remaining plants to be pollinated
	GameManager.total_plants_pollinated += 1;
	print("+1 pollinated plant")
	if GameManager.level == 1:
		if GameManager.total_plants_pollinated >= 1:
			celebrate()
			await get_tree().create_timer(3.0).timeout
			GameManager.next_level()
	elif GameManager.level == 2:
		if GameManager.total_plants_pollinated >= 2:
			celebrate()
			await get_tree().create_timer(3.0).timeout
			GameManager.next_level()
	elif GameManager.level == 3:
		if GameManager.total_plants_pollinated >= 2:
			celebrate()
			win()
			
func celebrate():
	play_sound("yay")
	
	#add celebration animation here

func win():
	print("you win!")
	GameManager.game_won = true
	#play again button pops up 
	
func play_sound(sound_name : String):
	sfx_handler.get_sound(sound_name)

func move(new_pos):
	target_pos = new_pos
	is_moving = true

func _input(inp: InputEvent) -> void:
	if inp is InputEventMouseButton and inp.button_index == MOUSE_BUTTON_LEFT and inp.pressed:
		play_sound("button_click")
		
		#checks for correct pollen matchups
		
		
		#are you hovering over a plant? if plant is not pollinated, pollinate it, 
		if mouse_over_plant: 
			if held_pollen != mouse_over_plant[0] and !mouse_over_plant[1]:
				print("you dont have this plants pollen");
				return
			
			if mouse_over_plant[1] == false:
				mouse_over_plant[1] = true
				task_completed()
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
	print("Updated held pollen to ", held_pollen)
	
func get_pollen():
	return held_pollen

func set_plant(plant):
	mouse_over_plant = plant
	print("Currently Selected Plant: ", mouse_over_plant)

func get_plant():
	return mouse_over_plant
