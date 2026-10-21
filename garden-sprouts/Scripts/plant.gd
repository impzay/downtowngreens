extends Node2D

var is_selected:bool = false;
var time: float = 0.0;

@onready var petals: CPUParticles2D = $NoPollen_Effect
@onready var sparkles: CPUParticles2D = $HasPollen_Effect
@onready var pumpkin = preload("res://Scenes/pumpkin.tscn")
@onready var sprite: AnimatedSprite2D = $Sprite2D
@export var plant_type: String;
@export var is_pollinated: bool = false
	
func _ready():
	add_to_group("Plants")
	
	var pollinator = get_parent().get_node("Pollinator")

	mouse_entered_plant.connect(pollinator._on_mouse_entered_plant)
	mouse_exited_plant.connect(pollinator._on_mouse_exited_plant)
	update_sprite()
	

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
	

func update_sprite():
	if sprite == null:
		return
	
	if is_pollinated:
		sprite.play("Fertilized Flower")
	else:
		sprite.play("Unfertilized Flower")
	
	petals.emitting = not is_pollinated
	sparkles.emitting = is_pollinated
	#pumpkin.instantiate()	


func stop_hovering():
	is_selected = false
	sprite.modulate.a = 1.0
	
signal mouse_entered_plant();
signal mouse_exited_plant();
	
func _on_zone_mouse_entered() -> void:
	start_hovering();
	mouse_entered_plant.emit(self)

func _on_zone_mouse_exited() -> void:
	stop_hovering();
	mouse_exited_plant.emit(self)

func pollinate() -> void:
	is_pollinated = true
	update_sprite()
