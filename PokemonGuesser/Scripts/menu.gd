# Menu
extends Control

@onready var parallax_2d: ParallaxBackground = $Parallax2D
@onready var scroll_container: ScrollContainer = $MarginContainer/ScrollContainer
@onready var kanto_score_label: Label = $MarginContainer/ScrollContainer/VBoxContainer/KantoTextureButton/KantoScoreLabel
@onready var johto_score_label: Label = $MarginContainer/ScrollContainer/VBoxContainer/JohtoTextureButton/JohtoScoreLabel
@onready var hoenn_score_label: Label = $MarginContainer/ScrollContainer/VBoxContainer/HoennTextureButton/HoennScoreLabel
@onready var sinnoh_score_label: Label = $MarginContainer/ScrollContainer/VBoxContainer/SinnohTextureButton/SinnohScoreLabel
@onready var teselia_score_label: Label = $MarginContainer/ScrollContainer/VBoxContainer/TeseliaTextureButton/TeseliaScoreLabel
@onready var kalos_score_label: Label = $MarginContainer/ScrollContainer/VBoxContainer/KalosTextureButton/KalosScoreLabel
@onready var alola_score_label: Label = $MarginContainer/ScrollContainer/VBoxContainer/AlolaTextureButton/AlolaScoreLabel
@onready var galar_score_label: Label = $MarginContainer/ScrollContainer/VBoxContainer/GalarTextureButton/GalarScoreLabel
@onready var hisui_score_label: Label = $MarginContainer/ScrollContainer/VBoxContainer/HisuiTextureButton/HisuiScoreLabel
@onready var paldea_score_label: Label = $MarginContainer/ScrollContainer/VBoxContainer/PaldeaTextureButton/PaldeaScoreLabel
@onready var unknown_score_label: Label = $MarginContainer/ScrollContainer/VBoxContainer/UnknownTextureButton/UnknownScoreLabel
@onready var kanto_grid_container: GridContainer = $MarginContainer/ScrollContainer/VBoxContainer/KantoGridContainer
@onready var johto_grid_container: GridContainer = $MarginContainer/ScrollContainer/VBoxContainer/JohtoGridContainer
@onready var hoenn_grid_container: GridContainer = $MarginContainer/ScrollContainer/VBoxContainer/HoennGridContainer
@onready var sinnoh_grid_container: GridContainer = $MarginContainer/ScrollContainer/VBoxContainer/SinnohGridContainer
@onready var teselia_grid_container: GridContainer = $MarginContainer/ScrollContainer/VBoxContainer/TeseliaGridContainer
@onready var kalos_grid_container: GridContainer = $MarginContainer/ScrollContainer/VBoxContainer/KalosGridContainer
@onready var alola_grid_container: GridContainer = $MarginContainer/ScrollContainer/VBoxContainer/AlolaGridContainer
@onready var galar_grid_container: GridContainer = $MarginContainer/ScrollContainer/VBoxContainer/GalarGridContainer
@onready var hisui_grid_container: GridContainer = $MarginContainer/ScrollContainer/VBoxContainer/HisuiGridContainer
@onready var paldea_grid_container: GridContainer = $MarginContainer/ScrollContainer/VBoxContainer/PaldeaGridContainer
@onready var unknown_grid_container: GridContainer = $MarginContainer/ScrollContainer/VBoxContainer/UnknownGridContainer
@onready var kanto_play_button: Button = $MarginContainer/ScrollContainer/VBoxContainer/KantoPlayButton
@onready var johto_play_button: Button = $MarginContainer/ScrollContainer/VBoxContainer/JohtoPlayButton
@onready var hoenn_play_button: Button = $MarginContainer/ScrollContainer/VBoxContainer/HoennPlayButton
@onready var sinnoh_play_button: Button = $MarginContainer/ScrollContainer/VBoxContainer/SinnohPlayButton
@onready var teselia_play_button: Button = $MarginContainer/ScrollContainer/VBoxContainer/TeseliaPlayButton
@onready var kalos_play_button: Button = $MarginContainer/ScrollContainer/VBoxContainer/KalosPlayButton
@onready var alola_play_button: Button = $MarginContainer/ScrollContainer/VBoxContainer/AlolaPlayButton
@onready var galar_play_button: Button = $MarginContainer/ScrollContainer/VBoxContainer/GalarPlayButton
@onready var hisui_play_button: Button = $MarginContainer/ScrollContainer/VBoxContainer/HisuiPlayButton
@onready var paldea_play_button: Button = $MarginContainer/ScrollContainer/VBoxContainer/PaldeaPlayButton
@onready var unknown_play_button: Button = $MarginContainer/ScrollContainer/VBoxContainer/UnknownPlayButton
@onready var v_box_container: VBoxContainer = $MarginContainer/ScrollContainer/VBoxContainer
@onready var kanto_texture_button: TextureButton = $MarginContainer/ScrollContainer/VBoxContainer/KantoTextureButton
@onready var johto_texture_button: TextureButton = $MarginContainer/ScrollContainer/VBoxContainer/JohtoTextureButton
@onready var hoenn_texture_button: TextureButton = $MarginContainer/ScrollContainer/VBoxContainer/HoennTextureButton
@onready var sinnoh_texture_button: TextureButton = $MarginContainer/ScrollContainer/VBoxContainer/SinnohTextureButton
@onready var teselia_texture_button: TextureButton = $MarginContainer/ScrollContainer/VBoxContainer/TeseliaTextureButton
@onready var kalos_texture_button: TextureButton = $MarginContainer/ScrollContainer/VBoxContainer/KalosTextureButton
@onready var alola_texture_button: TextureButton = $MarginContainer/ScrollContainer/VBoxContainer/AlolaTextureButton
@onready var galar_texture_button: TextureButton = $MarginContainer/ScrollContainer/VBoxContainer/GalarTextureButton
@onready var hisui_texture_button: TextureButton = $MarginContainer/ScrollContainer/VBoxContainer/HisuiTextureButton
@onready var paldea_texture_button: TextureButton = $MarginContainer/ScrollContainer/VBoxContainer/PaldeaTextureButton
@onready var unknown_texture_button: TextureButton = $MarginContainer/ScrollContainer/VBoxContainer/UnknownTextureButton
@onready var change_scene_animation: AnimationPlayer = $ChangeSceneAnimation
@onready var animation_timer: Timer = $AnimationTimer
@onready var kanto_score_texture_rect: TextureRect = $MarginContainer/ScrollContainer/VBoxContainer/KantoTextureButton/ScoreTextureRect
@onready var johto_score_texture_rect: TextureRect = $MarginContainer/ScrollContainer/VBoxContainer/JohtoTextureButton/ScoreTextureRect
@onready var hoenn_score_texture_rect: TextureRect = $MarginContainer/ScrollContainer/VBoxContainer/HoennTextureButton/ScoreTextureRect
@onready var sinnoh_score_texture_rect: TextureRect = $MarginContainer/ScrollContainer/VBoxContainer/SinnohTextureButton/ScoreTextureRect
@onready var teselia_score_texture_rect: TextureRect = $MarginContainer/ScrollContainer/VBoxContainer/TeseliaTextureButton/ScoreTextureRect
@onready var kalos_score_texture_rect: TextureRect = $MarginContainer/ScrollContainer/VBoxContainer/KalosTextureButton/ScoreTextureRect
@onready var alola_score_texture_rect: TextureRect = $MarginContainer/ScrollContainer/VBoxContainer/AlolaTextureButton/ScoreTextureRect
@onready var galar_score_texture_rect: TextureRect = $MarginContainer/ScrollContainer/VBoxContainer/GalarTextureButton/ScoreTextureRect
@onready var hisui_score_texture_rect: TextureRect = $MarginContainer/ScrollContainer/VBoxContainer/HisuiTextureButton/ScoreTextureRect
@onready var paldea_score_texture_rect: TextureRect = $MarginContainer/ScrollContainer/VBoxContainer/PaldeaTextureButton/ScoreTextureRect
@onready var unknown_score_texture_rect: TextureRect = $MarginContainer/ScrollContainer/VBoxContainer/UnknownTextureButton/ScoreTextureRect
@onready var title_texture_button: TextureButton = $MarginContainer/ScrollContainer/VBoxContainer/TitleTextureButton
@onready var title_label: Label = $MarginContainer/ScrollContainer/VBoxContainer/TitleTextureButton/TitleLabel
@onready var form_check_button: CheckButton = $MarginContainer/ScrollContainer/VBoxContainer/Settings/HBoxContainer/FormCheckButton

@export var scroll_friction := 0.95
@export var scroll_min_velocity := 0.2

var previous_scroll := 0.0
var scroll_velocity := Vector2.ZERO
var dragging := false
var animating := true
var first_animation := true

func _ready() -> void:
	form_check_button.button_pressed = Global.form_variety
	title_label.size = Vector2(320, 139)
	animating = true
	first_animation = true
	change_scene_animation.play("CLOSED")
	form_check_button.button_pressed = Global.form_variety
	await set_scores()
	await hide_grids()
	await load_grids()
	await Global.save_data()
	await connect_buttons()
	await display_grids(Global.region)
	change_scene_animation.play("start_scene")
	animation_timer.start()

func _process(delta: float) -> void:
	parallax_2d.scroll_offset += Vector2(30, -15) * delta
	if scroll_container.scroll_vertical != previous_scroll:
		parallax_2d.scroll_offset.y += previous_scroll - scroll_container.scroll_vertical
		previous_scroll = scroll_container.scroll_vertical
	if not dragging and scroll_velocity.length() > scroll_min_velocity:
		scroll_container.scroll_vertical -= scroll_velocity.y
		scroll_velocity *= scroll_friction

func set_scores():
	kanto_score_label.text = str(Global.kanto_best_score)
	johto_score_label.text = str(Global.johto_best_score)
	hoenn_score_label.text = str(Global.hoenn_best_score)
	sinnoh_score_label.text = str(Global.sinnoh_best_score)
	teselia_score_label.text = str(Global.teselia_best_score)
	kalos_score_label.text = str(Global.kalos_best_score)
	alola_score_label.text = str(Global.alola_best_score)
	galar_score_label.text = str(Global.galar_best_score)
	hisui_score_label.text = str(Global.hisui_best_score)
	paldea_score_label.text = str(Global.paldea_best_score)
	unknown_score_label.text = str(Global.unknown_best_score)
	if Global.kanto_best_score == Global.kanto_pokédex.size():
		kanto_score_texture_rect.modulate = Color(1.0, 1.0, 1.0, 1.0)
	else:
		kanto_score_texture_rect.modulate = Color(0.784, 0.715, 0.0, 1.0)
	if Global.johto_best_score == Global.johto_pokédex.size():
		johto_score_texture_rect.modulate = Color(1.0, 1.0, 1.0, 1.0)
	else:
		johto_score_texture_rect.modulate = Color(0.784, 0.715, 0.0, 1.0)
	if Global.hoenn_best_score == Global.hoenn_pokédex.size():
		hoenn_score_texture_rect.modulate = Color(1.0, 1.0, 1.0, 1.0)
	else:
		hoenn_score_texture_rect.modulate = Color(0.784, 0.715, 0.0, 1.0)
	if Global.sinnoh_best_score == Global.sinnoh_pokédex.size():
		sinnoh_score_texture_rect.modulate = Color(1.0, 1.0, 1.0, 1.0)
	else:
		sinnoh_score_texture_rect.modulate = Color(0.784, 0.715, 0.0, 1.0)
	if Global.teselia_best_score == Global.teselia_pokédex.size():
		teselia_score_texture_rect.modulate = Color(1.0, 1.0, 1.0, 1.0)
	else:
		teselia_score_texture_rect.modulate = Color(0.784, 0.715, 0.0, 1.0)
	if Global.kalos_best_score == Global.kalos_pokédex.size():
		kalos_score_texture_rect.modulate = Color(1.0, 1.0, 1.0, 1.0)
	else:
		kalos_score_texture_rect.modulate = Color(0.784, 0.715, 0.0, 1.0)
	if Global.alola_best_score == Global.alola_pokédex.size():
		alola_score_texture_rect.modulate = Color(1.0, 1.0, 1.0, 1.0)
	else:
		alola_score_texture_rect.modulate = Color(0.784, 0.715, 0.0, 1.0)
	if Global.galar_best_score == Global.galar_pokédex.size():
		galar_score_texture_rect.modulate = Color(1.0, 1.0, 1.0, 1.0)
	else:
		galar_score_texture_rect.modulate = Color(0.784, 0.715, 0.0, 1.0)
	if Global.hisui_best_score == Global.hisui_pokédex.size():
		hisui_score_texture_rect.modulate = Color(1.0, 1.0, 1.0, 1.0)
	else:
		hisui_score_texture_rect.modulate = Color(0.784, 0.715, 0.0, 1.0)
	if Global.paldea_best_score == Global.paldea_pokédex.size():
		paldea_score_texture_rect.modulate = Color(1.0, 1.0, 1.0, 1.0)
	else:
		paldea_score_texture_rect.modulate = Color(0.784, 0.715, 0.0, 1.0)
	if Global.unknown_best_score == Global.unknown_pokédex.size():
		unknown_score_texture_rect.modulate = Color(1.0, 1.0, 1.0, 1.0)
	else:
		unknown_score_texture_rect.modulate = Color(0.784, 0.715, 0.0, 1.0)

func hide_grids():
	kanto_grid_container.visible = false
	kanto_play_button.visible = false
	johto_grid_container.visible = false
	johto_play_button.visible = false
	hoenn_grid_container.visible = false
	hoenn_play_button.visible = false
	sinnoh_grid_container.visible = false
	sinnoh_play_button.visible = false
	teselia_grid_container.visible = false
	teselia_play_button.visible = false
	kalos_grid_container.visible = false
	kalos_play_button.visible = false
	alola_grid_container.visible = false
	alola_play_button.visible = false
	galar_grid_container.visible = false
	galar_play_button.visible = false
	hisui_grid_container.visible = false
	hisui_play_button.visible = false
	paldea_grid_container.visible = false
	paldea_play_button.visible = false
	unknown_grid_container.visible = false
	unknown_play_button.visible = false

func display_grids(region : String):
	if region == "KANTO":
		kanto_grid_container.visible = !kanto_grid_container.visible
		kanto_play_button.visible = kanto_grid_container.visible
		if first_animation:
			scroll_container.scroll_vertical = 0
	else:
		kanto_grid_container.visible = false
		kanto_play_button.visible = false
	if region == "JOHTO":
		johto_grid_container.visible = !johto_grid_container.visible
		johto_play_button.visible = johto_grid_container.visible
		if first_animation:
			scroll_container.scroll_vertical = 178
	else:
		johto_grid_container.visible = false
		johto_play_button.visible = false
	if region == "HOENN":
		hoenn_grid_container.visible = !hoenn_grid_container.visible
		hoenn_play_button.visible = hoenn_grid_container.visible
		if first_animation:
			scroll_container.scroll_vertical = 268
	else:
		hoenn_grid_container.visible = false
		hoenn_play_button.visible = false
	if region == "SINNOH":
		sinnoh_grid_container.visible = !sinnoh_grid_container.visible
		sinnoh_play_button.visible = sinnoh_grid_container.visible
		if first_animation:
			scroll_container.scroll_vertical = 357
	else:
		sinnoh_grid_container.visible = false
		sinnoh_play_button.visible = false
	if region == "TESELIA":
		teselia_grid_container.visible = !teselia_grid_container.visible
		teselia_play_button.visible = teselia_grid_container.visible
		if first_animation:
			scroll_container.scroll_vertical = 409
	else:
		teselia_grid_container.visible = false
		teselia_play_button.visible = false
	if region == "KALOS":
		kalos_grid_container.visible = !kalos_grid_container.visible
		kalos_play_button.visible = kalos_grid_container.visible
		if first_animation:
			scroll_container.scroll_vertical = 498
	else:
		kalos_grid_container.visible = false
		kalos_play_button.visible = false
	if region == "ALOLA":
		alola_grid_container.visible = !alola_grid_container.visible
		alola_play_button.visible = alola_grid_container.visible
		if first_animation:
			scroll_container.scroll_vertical = 588
	else:
		alola_grid_container.visible = false
		alola_play_button.visible = false
	if region == "GALAR":
		galar_grid_container.visible = !galar_grid_container.visible
		galar_play_button.visible = galar_grid_container.visible
		if first_animation:
			scroll_container.scroll_vertical = 677
	else:
		galar_grid_container.visible = false
		galar_play_button.visible = false
	if region == "HISUI":
		hisui_grid_container.visible = !hisui_grid_container.visible
		hisui_play_button.visible = hisui_grid_container.visible
		if first_animation:
			scroll_container.scroll_vertical = 698
	else:
		hisui_grid_container.visible = false
		hisui_play_button.visible = false
	if region == "PALDEA":
		paldea_grid_container.visible = !paldea_grid_container.visible
		paldea_play_button.visible = paldea_grid_container.visible
		if first_animation:
			scroll_container.scroll_vertical = 856
	else:
		paldea_grid_container.visible = false
		paldea_play_button.visible = false
	if region == "UNKNOWN":
		unknown_grid_container.visible = !unknown_grid_container.visible
		unknown_play_button.visible = unknown_grid_container.visible
		await get_tree().process_frame
		scroll_container.scroll_vertical = scroll_container.get_v_scroll_bar().max_value
	else:
		unknown_grid_container.visible = false
		unknown_play_button.visible = false

func _on_kanto_texture_button_pressed() -> void:
	if scroll_velocity == Vector2.ZERO:
		display_grids("KANTO")

func _on_johto_texture_button_pressed() -> void:
	if scroll_velocity == Vector2.ZERO:
		display_grids("JOHTO")

func _on_hoenn_texture_button_pressed() -> void:
	if scroll_velocity == Vector2.ZERO:
		display_grids("HOENN")

func _on_sinnoh_texture_button_pressed() -> void:
	if scroll_velocity == Vector2.ZERO:
		display_grids("SINNOH")

func _on_teselia_texture_button_pressed() -> void:
	if scroll_velocity == Vector2.ZERO:
		await display_grids("TESELIA")

func _on_kalos_texture_button_pressed() -> void:
	if scroll_velocity == Vector2.ZERO:
		display_grids("KALOS")

func _on_alola_texture_button_pressed() -> void:
	if scroll_velocity == Vector2.ZERO:
		display_grids("ALOLA")

func _on_galar_texture_button_pressed() -> void:
	if scroll_velocity == Vector2.ZERO:
		display_grids("GALAR")

func _on_hisui_texture_button_pressed() -> void:
	if scroll_velocity == Vector2.ZERO:
		display_grids("HISUI")

func _on_paldea_texture_button_pressed() -> void:
	if scroll_velocity == Vector2.ZERO:
		display_grids("PALDEA")

func _on_unknown_texture_button_pressed() -> void:
	if scroll_velocity == Vector2.ZERO:
		display_grids("UNKNOWN")

func load_grids():
	load_grid(1, Global.kanto_pokédex, Global.kanto_learnt_pokémon, kanto_grid_container)
	load_grid(152, Global.johto_pokédex, Global.johto_learnt_pokémon, johto_grid_container)
	load_grid(252, Global.hoenn_pokédex, Global.hoenn_learnt_pokémon, hoenn_grid_container)
	load_grid(387, Global.sinnoh_pokédex, Global.sinnoh_learnt_pokémon, sinnoh_grid_container)
	load_grid(494, Global.teselia_pokédex, Global.teselia_learnt_pokémon, teselia_grid_container)
	load_grid(650, Global.kalos_pokédex, Global.kalos_learnt_pokémon, kalos_grid_container)
	load_grid(722, Global.alola_pokédex, Global.alola_learnt_pokémon, alola_grid_container)
	load_grid(810, Global.galar_pokédex, Global.galar_learnt_pokémon, galar_grid_container)
	load_grid(899, Global.hisui_pokédex, Global.hisui_learnt_pokémon, hisui_grid_container)
	load_grid(906, Global.paldea_pokédex, Global.paldea_learnt_pokémon, paldea_grid_container)
	load_grid(808, Global.unknown_pokédex, Global.unknown_learnt_pokémon, unknown_grid_container)

func load_grid(start_number : int, pokédex : Array, learnt_pokémon : Dictionary, container : GridContainer):
	for n in pokédex.size():
		var panel = PanelContainer.new()
		panel.connect("gui_input", Callable(self, "_on_button_gui_input"))
		panel.custom_minimum_size = Vector2(72, 72)
		var pokémon_name := str(pokédex[n])
		if learnt_pokémon.keys().has(pokémon_name):
			var texture_path := "res://Assets/Pokémon/" + pokémon_name.to_lower().replace(" ", "-") + ".png"
			var sprite = TextureRect.new()
			sprite.texture = load(texture_path)
			if sprite.texture == null:
				sprite.texture = load("res://Assets/Pokémon/MissingNo.png")
				push_warning("The image of the pokémon " + pokédex[n].to_upper() + " has not been found or does not exist.")
			sprite.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
			sprite.expand_mode = TextureRect.EXPAND_IGNORE_SIZE

			var knowledge_level = learnt_pokémon[pokémon_name]
			if knowledge_level < 0:
				sprite.modulate = Color(0, 0, 0, 0.8)
			sprite.connect("gui_input", Callable(self, "_on_button_gui_input"))
			panel.add_child(sprite)
		else:
			var label = Label.new()
			var label_number = start_number + n
			while str(label_number).length() < 4:
				label_number = str(0) + str(label_number)
			label.text = str(label_number)
			label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
			var settings = LabelSettings.new()
			settings.font_size = 26
			label.label_settings = settings
			label.connect("gui_input", Callable(self, "_on_button_gui_input"))
			panel.add_child(label)
		container.add_child(panel)

func _on_kanto_play_button_pressed() -> void:
	if scroll_velocity == Vector2.ZERO:
		Global.region = "KANTO"
		change_scene_animation.play("leave_scene")
		animation_timer.start()
		animating = true

func _on_johto_play_button_pressed() -> void:
	if scroll_velocity == Vector2.ZERO:
		Global.region = "JOHTO"
		change_scene_animation.play("leave_scene")
		animation_timer.start()
		animating = true

func _on_hoenn_play_button_pressed() -> void:
	if scroll_velocity == Vector2.ZERO:
		Global.region = "HOENN"
		change_scene_animation.play("leave_scene")
		animation_timer.start()
		animating = true

func _on_sinnoh_play_button_pressed() -> void:
	if scroll_velocity == Vector2.ZERO:
		Global.region = "SINNOH"
		change_scene_animation.play("leave_scene")
		animation_timer.start()
		animating = true

func _on_teselia_play_button_pressed() -> void:
	if scroll_velocity == Vector2.ZERO:
		Global.region = "TESELIA"
		change_scene_animation.play("leave_scene")
		animation_timer.start()
		animating = true

func _on_kalos_play_button_pressed() -> void:
	if scroll_velocity == Vector2.ZERO:
		Global.region = "KALOS"
		change_scene_animation.play("leave_scene")
		animation_timer.start()
		animating = true

func _on_alola_play_button_pressed() -> void:
	if scroll_velocity == Vector2.ZERO:
		Global.region = "ALOLA"
		change_scene_animation.play("leave_scene")
		animation_timer.start()
		animating = true

func _on_galar_play_button_pressed() -> void:
	if scroll_velocity == Vector2.ZERO:
		Global.region = "GALAR"
		change_scene_animation.play("leave_scene")
		animation_timer.start()
		animating = true

func _on_hisui_play_button_pressed() -> void:
	if scroll_velocity == Vector2.ZERO:
		Global.region = "HISUI"
		change_scene_animation.play("leave_scene")
		animation_timer.start()
		animating = true

func _on_paldea_play_button_pressed() -> void:
	if scroll_velocity == Vector2.ZERO:
		Global.region = "PALDEA"
		change_scene_animation.play("leave_scene")
		animation_timer.start()
		animating = true

func _on_unknown_play_button_pressed() -> void:
	if scroll_velocity == Vector2.ZERO:
		Global.region = "UNKNOWN"
		change_scene_animation.play("leave_scene")
		animation_timer.start()
		animating = true

func _on_button_gui_input(event):
	if event is InputEventScreenTouch:
		if event.pressed:
			dragging = true
			scroll_velocity = Vector2.ZERO
		else:
			dragging = false
	if event is InputEventScreenDrag:
		scroll_container.scroll_vertical -= event.relative.y
		scroll_velocity.y = event.relative.y
		get_viewport().set_input_as_handled()

func connect_buttons():
	kanto_play_button.connect("gui_input", Callable(self, "_on_button_gui_input"))
	johto_play_button.connect("gui_input", Callable(self, "_on_button_gui_input"))
	hoenn_play_button.connect("gui_input", Callable(self, "_on_button_gui_input"))
	sinnoh_play_button.connect("gui_input", Callable(self, "_on_button_gui_input"))
	teselia_play_button.connect("gui_input", Callable(self, "_on_button_gui_input"))
	kalos_play_button.connect("gui_input", Callable(self, "_on_button_gui_input"))
	alola_play_button.connect("gui_input", Callable(self, "_on_button_gui_input"))
	galar_play_button.connect("gui_input", Callable(self, "_on_button_gui_input"))
	hisui_play_button.connect("gui_input", Callable(self, "_on_button_gui_input"))
	paldea_play_button.connect("gui_input", Callable(self, "_on_button_gui_input"))
	unknown_play_button.connect("gui_input", Callable(self, "_on_button_gui_input"))
	kanto_texture_button.connect("gui_input", Callable(self, "_on_button_gui_input"))
	johto_texture_button.connect("gui_input", Callable(self, "_on_button_gui_input"))
	hoenn_texture_button.connect("gui_input", Callable(self, "_on_button_gui_input"))
	sinnoh_texture_button.connect("gui_input", Callable(self, "_on_button_gui_input"))
	teselia_texture_button.connect("gui_input", Callable(self, "_on_button_gui_input"))
	kalos_texture_button.connect("gui_input", Callable(self, "_on_button_gui_input"))
	alola_texture_button.connect("gui_input", Callable(self, "_on_button_gui_input"))
	galar_texture_button.connect("gui_input", Callable(self, "_on_button_gui_input"))
	hisui_texture_button.connect("gui_input", Callable(self, "_on_button_gui_input"))
	paldea_texture_button.connect("gui_input", Callable(self, "_on_button_gui_input"))
	unknown_texture_button.connect("gui_input", Callable(self, "_on_button_gui_input"))

func _on_animation_timer_timeout() -> void:
	if first_animation:
		first_animation = false
		animating = false
	else:
		change_scene_animation.play("CLOSED")
		if Global.region == "MENU":
			get_tree().change_scene_to_file("res://Scenes/intro.tscn")
		else:
			get_tree().change_scene_to_file("res://Scenes/gameplay.tscn")

func _on_title_texture_button_pressed() -> void:
	if scroll_velocity == Vector2.ZERO:
		Global.region = "MENU"
		change_scene_animation.play("leave_scene")
		animation_timer.start()
		animating = true
		var title_tween : Tween = create_tween()
		title_tween.tween_property(title_label.label_settings, "font_size", 35, 0.2)
		title_tween.tween_interval(0.2)
		title_tween.tween_property(title_label.label_settings, "font_size", 48, 0.2)

func _on_form_check_button_toggled(toggled_on: bool) -> void:
	Global.form_variety = form_check_button.button_pressed
