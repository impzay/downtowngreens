extends Node2D

signal mouse_entered_plant(plant);
signal mouse_exited_plant(plant);
var is_selected:bool = false;
var time: float = 0.0;

@onready var sprite = $Sprite2D

func _ready():
	var pollinator = get_parent().get_node("Pollinator")
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
	time = 0.0;
	is_selected = true
	
func stop_hovering():
	is_selected = false
	sprite.modulate.a = 1.0

	
func _on_zone_mouse_entered() -> void:
	start_hovering();
	mouse_entered_plant.emit(self)

func _on_zone_mouse_exited() -> void:
	stop_hovering();
	mouse_exited_plant.emit(self)
