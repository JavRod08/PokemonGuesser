extends Control

@onready var parallax_2d: ParallaxBackground = $Parallax2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var audio_stream_player: AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var music_check_button: CheckButton = $MarginContainer/VBoxContainer/Settings/HBoxContainer/MusicCheckButton
@onready var sfx_check_button: CheckButton = $MarginContainer/VBoxContainer/Settings/HBoxContainer/SFXCheckButton
@onready var change_scene_animation: AnimationPlayer = $ChangeSceneAnimation
@onready var animation_timer: Timer = $AnimationTimer
@onready var title_label: Label = $MarginContainer/VBoxContainer/TitleLabel
@onready var back_sprite_2d: Sprite2D = $Credits/BackSprite2D
@onready var background_sprite_2d: Sprite2D = $Credits/BackgroundSprite2D
@onready var credits_label: Label = $Credits/ScrollContainer/CreditsLabel
@onready var exit_texture_button: TextureButton = $Credits/ExitTextureButton
@onready var scroll_container: ScrollContainer = $Credits/ScrollContainer
@onready var form_texture_button: TextureButton = $MarginContainer/VBoxContainer/FormTextureButton

var path : String
var animating := false
var change_scene := false

func _ready() -> void:
	animation_player.play("RESET")
	if !Global.started:
		audio_stream_player.play()
		animating = false
		change_scene_animation.play("RESET")
		Global.started = true
	else:
		animating = true
		change_scene_animation.play("CLOSED")
		change_scene_animation.play("start_scene")
		change_scene = false
		animation_timer.start()
		Global.save_data()
	if Global.total_forms <= Global.forms_best_score:
		form_texture_button.self_modulate = Color(0.658, 0.64, 1.0, 1.0)
	else:
		form_texture_button.self_modulate = Color(1.0, 1.0, 1.0, 1.0)

func _process(delta: float) -> void:
	parallax_2d.scroll_offset += Vector2(30, -15) * delta

func _on_pokémon_texture_button_pressed() -> void:
	if !animating:
		Global.mode = "NAMES"
		Global.music = music_check_button.button_pressed
		change_scene_animation.play("leave_scene")
		path = "res://Scenes/menu.tscn"
		animating = true
		change_scene = true
		animation_timer.start()

func _on_form_texture_button_pressed() -> void:
	if !animating:
		#Global.music = music_check_button.button_pressed
		#animation_player.play("coming_soon")
		#Global.mode = "FORMS"
		
		Global.mode = "FORMS"
		Global.music = music_check_button.button_pressed
		change_scene_animation.play("leave_scene")
		path = "res://Scenes/gameplay.tscn"
		animating = true
		change_scene = true
		animation_timer.start()

func _on_music_check_button_pressed() -> void:
	if !animating:
		Global.music = music_check_button.button_pressed

func _on_sfx_check_button_pressed() -> void:
	if !animating:
		Global.sfx = sfx_check_button.button_pressed

func _on_timer_timeout() -> void:
	Global.music = true

func _on_animation_timer_timeout() -> void:
	if change_scene:
		change_scene_animation.play("CLOSED")
		get_tree().change_scene_to_file(path)
	else:
		animating = false
		change_scene_animation.play("RESET")

func _on_credits_texture_button_pressed() -> void:
	if !animating:
		scroll_container.scroll_horizontal = 0
		scroll_container.scroll_vertical = 0
		animation_player.play("RESET")
		animation_player.play("show_credits")
		change_scene = false
		animating = true
		animation_timer.start()

func _on_texture_button_pressed() -> void:
	if !animating:
		animation_player.play("SHOWN")
		animation_player.play("hide_credits")
		animating = true
		change_scene = false
		animation_timer.start()
