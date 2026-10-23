extends Control


const GAME_SCENE = "res://Scenes/main.tscn"

var pages = [
	{"title": "Welcome!", "body": "Help the garden grow by taking care of the plants.", "image": null},
	{"title": "Pollinate", "body": "Click a flower to pollinate it.", "image": null},
	{"title": "Grow Pumpkins", "body": "Pollinated flower grow into pumpkins!", "image": null},
	
]

var current = 0

@onready var title = $CenterContainer/Panel/VBox/Title
@onready var picture = $CenterContainer/Panel/VBox/Picture
@onready var body = $CenterContainer/Panel/VBox/Body
@onready var page_label = $CenterContainer/Panel/VBox/PageLabel
@onready var back_button = $CenterContainer/Panel/VBox/Buttons/BackButton
@onready var next_button = $CenterContainer/Panel/VBox/Buttons/NextButton

func _ready():
	back_button.pressed.connect(_on_back_pressed)
	next_button.pressed.connect(_on_next_pressed)
	show_page()

func show_page():
	var page = pages[current]
	title.text = page["title"]
	body.text = page["body"]
	picture.texture = page["image"]
	picture.visible = page["image"] != null
	page_label.text = "%d / %d" % [current + 1, pages.size()] #Need more clarification on this <--- to be deleted
	
	back_button.disabled = current == 0
	next_button.text = "play!" if current == pages.size() - 1 else "Next"
	next_button.grab_focus()

func _on_back_pressed():
	current -= 1
	show_page()

func _on_next_pressed():
	if current == pages.size() - 1:
		get_tree().change_scene_to_file(GAME_SCENE)
	else:
		current += 1
		show_page()
