extends Node2D

var is_selected:bool = false;
var time: float = 0.0;

@onready var petals: CPUParticles2D = $NoPollen_Effect
@onready var sparkles: CPUParticles2D = $HasPollen_Effect
@onready var pumpkin = preload("res://Scenes/pumpkin.tscn")
@onready var sprite: AnimatedSprite2D = $Sprite2D
@onready var pump_spawn: Marker2D = %PumpkinSpawn
@export var plant_type: String;
@export var is_pollinated: bool = false

enum State {SAD, GROWING, HAPPY}
@export var state = State.HAPPY

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
	
func start_hovering():
	time = 1.0;
	is_selected = true
	

func update_sprite():
	if sprite == null:
		return
	
	match state:
		State.SAD:
			sprite.play("Unfertilized Flower")
		State.HAPPY:
			sprite.play("Fertilized Flower")
	
	petals.emitting = state == State.SAD
	sparkles.emitting = state == State.HAPPY
	

func grow():
	sprite.play("Growing_Pumpkin")
	await sprite.animation_finished
	var pump = pumpkin.instantiate()
	pump.position = pump_spawn.global_position
	get_parent().add_child(pump)


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
	if state != State.SAD:
		return
		
	is_pollinated = true
	state = State.GROWING
	await grow()
	state = State.HAPPY
	update_sprite()
