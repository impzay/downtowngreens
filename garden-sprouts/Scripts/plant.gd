extends Node2D


var is_selected:bool = false;
@export var is_pollinated: bool = false; #so we can change sprite state later
@export var plant_type: String;
var time: float = 0.0;
var plant = [];

@onready var sprite = $Sprite2D

func _ready():
	add_to_group("Plants")
	var pollinator = get_parent().get_node("Pollinator")
	plant = [plant_type,is_pollinated];
	mouse_entered_plant.connect(pollinator._on_mouse_entered_plant)
	mouse_exited_plant.connect(pollinator._on_mouse_exited_plant)
	

func _process(delta: float) -> void:
	if is_selected:
		time += delta
		sprite.modulate.a = (sin(time * 3.0) + 1.0) / 4.0 + 0.5	
		#sin gives you a range from -1 to 1
		#time * 3.0 <- speed
		#+1 gives you 0 to 1
		#divide by 4 gives you 0 to 0.5
		#+0.5 gives you 0.5 to 1

func start_hovering():
	time = 1.0;
	is_selected = true
	
func stop_hovering():
	is_selected = false
	sprite.modulate.a = 1.0
	
signal mouse_entered_plant(plant);
signal mouse_exited_plant(plant);
	
func _on_zone_mouse_entered() -> void:
	start_hovering();
	mouse_entered_plant.emit(plant)

func _on_zone_mouse_exited() -> void:
	stop_hovering();
	mouse_exited_plant.emit(plant)
