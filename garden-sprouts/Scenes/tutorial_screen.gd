extends Control

const GAME_SCENE = "res://Scenes/main.tscn"
const MENU_SCENE = "res://Scenes/StartScreen.tscn"

const FONT = preload("res://Assets/Fonts/Anja Eliane accent002.ttf")
const MUSIC = preload("res://Assets/Sound/sigmamusicart-background-music-jazz-597003.mp3")
const BEE = preload("res://Assets/Sprites/beesheett.png")
const SAD_FLOWER = preload("res://Assets/Sprites/sad_flower.png")
const HAPPY_FLOWER = preload("res://Assets/Sprites/happy_flower.png")
const PUMPKIN_FLOWER = preload("res://Assets/Sprites/pumpkin_flower.png")
const PUMPKIN = preload("res://Assets/Sprites/pumpkin.png")

var pages = []
var current = 0

@onready var center = $CenterContainer
@onready var panel = $CenterContainer/Panel
@onready var vbox = $CenterContainer/Panel/VBox
@onready var title = $CenterContainer/Panel/VBox/Title
@onready var picture = $CenterContainer/Panel/VBox/Picture
@onready var body = $CenterContainer/Panel/VBox/Body
@onready var page_label = $CenterContainer/Panel/VBox/PageLabel
@onready var buttons = $CenterContainer/Panel/VBox/Buttons
@onready var back_button = $CenterContainer/Panel/VBox/Buttons/BackButton
@onready var next_button = $CenterContainer/Panel/VBox/Buttons/NextButton


func _ready():
	_build_pages()
	_setup_layout()
	back_button.pressed.connect(_on_back_pressed)
	next_button.pressed.connect(_on_next_pressed)
	AudioHandler.play_track(MUSIC)
	show_page()


func _build_pages():
	pages = [
		{
			"title": "Welcome!",
			"body": "You're a busy little bee, and the garden needs your help. Plants can't make fruits and veggies without pollinators like you!",
			"image": _frame(BEE, 0),
		},
		{
			"title": "Find the Pollen",
			"body": "Sparkly flowers are already pollinated. Click one to pick up its pollen.",
			"image": _frame(HAPPY_FLOWER, 1),
		},
		{
			"title": "Pollinate",
			"body": "Droopy flowers still need help. Carry pollen to a droopy flower of the same kind and click it. Pumpkin pollen only works on pumpkins!",
			"image": _frame(SAD_FLOWER, 0),
		},
		{
			"title": "Watch It Grow",
			"body": "Once a flower is pollinated, it grows into food. Real bees do this every day, which is how we get pumpkins, carrots, and more.",
			"image": _frame(PUMPKIN_FLOWER, 13),
		},
		{
			"title": "Clear the Garden",
			"body": "Pollinate every droopy flower to finish the level. Press Esc anytime to pause or change the sound.",
			"image": _frame(PUMPKIN, 0, 32),
		},
	]


# Grabs one frame from a horizontal sprite sheet.
func _frame(sheet: Texture2D, index: int, size: int = 64) -> AtlasTexture:
	var tex := AtlasTexture.new()
	tex.atlas = sheet
	tex.region = Rect2(index * size, 0, size, size)
	return tex


func _setup_layout():
	center.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	panel.custom_minimum_size = Vector2(900, 650)
	vbox.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT, Control.PRESET_MODE_MINSIZE, 40)
	vbox.add_theme_constant_override("separation", 20)

	title.add_theme_font_override("font", FONT)
	title.add_theme_font_size_override("font_size", 72)
	title.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER

	picture.custom_minimum_size = Vector2(0, 240)
	picture.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	picture.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
	picture.texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST

	body.add_theme_font_size_override("font_size", 28)
	body.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	body.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	body.size_flags_vertical = Control.SIZE_EXPAND_FILL

	page_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER

	buttons.alignment = BoxContainer.ALIGNMENT_CENTER
	buttons.add_theme_constant_override("separation", 40)
	for button in [back_button, next_button]:
		button.custom_minimum_size = Vector2(180, 60)
		button.add_theme_font_override("font", FONT)
		button.add_theme_font_size_override("font_size", 36)


func show_page():
	var page = pages[current]
	title.text = page["title"]
	body.text = page["body"]
	picture.texture = page["image"]
	picture.visible = page["image"] != null
	page_label.text = "%d / %d" % [current + 1, pages.size()]

	back_button.text = "Menu" if current == 0 else "Back"
	next_button.text = "Play!" if current == pages.size() - 1 else "Next"
	next_button.grab_focus()


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_right"):
		_on_next_pressed()
	elif event.is_action_pressed("ui_left"):
		_on_back_pressed()
	elif event.is_action_pressed("ui_cancel"):
		get_tree().change_scene_to_file(MENU_SCENE)


func _on_back_pressed():
	if current == 0:
		get_tree().change_scene_to_file(MENU_SCENE)
		return
	current -= 1
	show_page()


func _on_next_pressed():
	if current == pages.size() - 1:
		get_tree().change_scene_to_file(GAME_SCENE)
		return
	current += 1
	show_page()
