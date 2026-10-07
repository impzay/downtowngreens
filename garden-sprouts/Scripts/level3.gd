extends Node2D

@onready var UI = $UI
@onready var replay_button = $UI/ReplayButton

func _ready() -> void:
	replay_button.visible = false

func _process(delta: float) -> void:
	if GameManager.game_won:
		replay_button.visible = true


func _on_replay_button_pressed() -> void:
	GameManager.restart()
