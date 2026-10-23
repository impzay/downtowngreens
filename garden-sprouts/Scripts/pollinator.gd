extends Node2D

var mouse_over_plant = null
var target_plant = null
var is_moving: bool = false
var target_pos: Vector2 = Vector2.ZERO
var total_plants_pollinated: int = 0;
var held_pollen: String = "";
var level: int = 1

@export var transition_time: int
@onready var sfx_handler = get_parent().get_node("Sound_Handler")
@onready var sprite = $AnimatedSprite2D
@onready var pumpkin = preload("res://Scenes/pumpkin.tscn")
@export var pumpkin_offset: Vector2 = Vector2(0, 30)
@onready var beehive_pos = %Beehive


var pollinate_on_arrival: bool = false
var tasks_per_level: int 

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	if GameManager.paused:
		return
	
	if !is_moving:
		return

	position = position.lerp(target_pos, delta * 1.5)
	
	#task gets completed if a plant is successfully pollinated.
	if position.distance_to(target_pos) < 15.0:
		is_moving = false
		if pollinate_on_arrival:
			pollinate_on_arrival = false
			target_plant.pollinate()
			target_plant = null
			task_completed(target_pos)
		move(beehive_pos.global_position)
		
			

func task_completed(pos: Vector2):
	GameManager.total_tasks_completed += 1
	
	#check if all plants are pollinated and update # of remaining plants to be pollinated	 
	
	if GameManager.level == 1:
		if GameManager.total_tasks_completed >= 1:
			celebrate()
			await get_tree().create_timer(3.0).timeout
			GameManager.next_level()
	elif GameManager.level == 2:
		if GameManager.total_tasks_completed >= 2:
			celebrate()
			await get_tree().create_timer(3.0).timeout
			GameManager.next_level()
	elif GameManager.level == 3:
		if GameManager.total_tasks_completed >= 2:
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
	#play_sound("flying")

func _input(inp: InputEvent) -> void:
	if inp is InputEventMouseButton and inp.button_index == MOUSE_BUTTON_LEFT and inp.pressed:
		play_sound("button_click")
		#checks for correct pollen matchups
		#are you hovering over a plant? if plant is not pollinated, pollinate it, 
		if mouse_over_plant: 
			if GameManager.paused:
				return
				
			if held_pollen != mouse_over_plant.plant_type and !mouse_over_plant.is_pollinated:
				print("you dont have this plants pollen");
				return
			
			if mouse_over_plant.is_pollinated == false:  #if the plant is not pollinated
				held_pollen = ""
				target_plant = mouse_over_plant
				pollinate_on_arrival = true
			else:
				set_pollen(mouse_over_plant)
			move(inp.position)


	
func _on_mouse_entered_plant(plant):
	set_plant(plant)
	play_sound("button_hover")
	
func _on_mouse_exited_plant(plant):
		mouse_over_plant = null;

func set_pollen(plant):
	if plant == null:
		return
	
	held_pollen = plant.plant_type
	print("Updated held pollen to ", held_pollen)
	
func get_pollen():
	return held_pollen

func set_plant(plant):
	mouse_over_plant = plant
	print("Currently Selected Plant: ", mouse_over_plant)

func get_plant():
	return mouse_over_plant

func set_glow(on: bool) -> void:
	$AnimatedSprite2D.material.set_shader_parameter("glow_strength", 1.5 if on else 0.0)
	
