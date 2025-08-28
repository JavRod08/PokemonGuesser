# Gameplay
extends Control

@onready var texture_rect: TextureRect = $MarginContainer/VBoxContainer/HSplitContainer/TextureRect
@onready var text_edit: TextEdit = $MarginContainer/VBoxContainer/TextEdit
@onready var answer: Label = $MarginContainer/VBoxContainer/Answer
@onready var submit_button: Button = $MarginContainer/VBoxContainer/SubmitButton
@onready var correction: PanelContainer = $MarginContainer/VBoxContainer/HBoxContainer/Correction
@onready var correction_label: Label = $MarginContainer/VBoxContainer/HBoxContainer/Correction/CorrectionLabel
@onready var next_button: Button = $MarginContainer/VBoxContainer/HBoxContainer/NextButton
@onready var correction_animation: AnimationPlayer = $CorrectionAnimation
@onready var correction_timer: Timer = $CorrectionAnimation/CorrectionTimer
@onready var texture_rect_animated: TextureRect = $MarginContainer/VBoxContainer/HSplitContainer/TextureRectAnimated
@onready var h_split_container: HSplitContainer = $MarginContainer/VBoxContainer/HSplitContainer
@onready var next_pokémon_timer: Timer = $NextPokémonTimer
@onready var parallax_2d: ParallaxBackground = $Parallax2D
@onready var points_label: Label = $MarginContainer/VBoxContainer/PointsLabel
@onready var change_scene_animation: AnimationPlayer = $ChangeSceneAnimation
@onready var option_button: OptionButton = $MarginContainer/VBoxContainer/OptionButton

@export var current_pokémon := "MISSINGNO"

var animating := true
var next_pokémon_name : String
var strikes := 0
var points := 0
var last_label := ""
var texture_path : String
var first_click := ""

var pokédex : Array
var guessed_pokémon : Array
var learnt_pokémon : Dictionary

func _ready() -> void:
	animating = true
	change_scene_animation.play("CLOSED")
	await choose_pokédex(Global.region)
	await update_score()
	if Global.mode == "NAMES":
		submit_button.text = "SUBMIT"
		if learnt_pokémon.size() < 1:
			current_pokémon = pokédex[0]
		else:
			current_pokémon = pokédex[Global.rng.randi_range(0, int(pokédex.size() * 0.1))]
	elif Global.mode == "FORMS":
		var forms = Global.forms_pokédex["ALCREMIE"]
		current_pokémon = "ALCREMIE_" + forms[Global.rng.randi_range(0, forms.size() - 1)]
		print(current_pokémon)
		submit_button.text = "FIRST!"
	await load_scene(current_pokémon)
	await choose_next_pokémon(current_pokémon)
	change_scene_animation.play("start_scene")
	correction_timer.start()

func _process(delta: float) -> void:
	if text_edit.text.find("\n") != -1:
		if last_label.length() > 0:
			text_edit.text = last_label
		else:
			text_edit.text = text_edit.text.replace("\n", "")
		submit_answer(true)
		correct_answer(current_pokémon)
	parallax_2d.scroll_offset += Vector2(30, -15) * delta
	last_label = text_edit.text

func _on_button_pressed() -> void:
	if !animating:
		submit_answer(true)
		correct_answer(current_pokémon)

func load_scene(pokémon_name): # Setups the scene
	correction_animation.play("RESET")
	load_pokémon(pokémon_name)
	submit_answer(false)

func load_pokémon(pokémon): # Changes the pokémon sprite shown
	await display_pokémon(pokémon, false)
	h_split_container.split_offset = h_split_container.size.x
	texture_rect.visible = true
	texture_rect_animated.visible = false
	texture_rect.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
	texture_rect_animated.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
	if next_pokémon_name != "":
		current_pokémon = next_pokémon_name

func submit_answer(state): # Shows or hides the submited state
	if Global.mode == "NAMES":
		option_button.visible = false
		if state:
			answer.visible = true
			answer.text = text_edit.text
			var text = format(answer.text)
			if answer.text.length() > 25:
				answer.text = answer.text.substr(0,23) + "..."
			elif text.length() == 0:
				answer.text = "???"
			text_edit.visible = false
			submit_button.visible = false
			correction.visible = true
			next_button.visible = true
		else:
			answer.visible = false
			text_edit.visible = true
			submit_button.visible = true
			correction.visible = false
			next_button.visible = false
		text_edit.text = ""
	elif Global.mode == "FORMS":
		text_edit.visible = false
		if state:
			answer.visible = true
			if first_click == "":
				answer.text = option_button.get_item_text(0) + " " + option_button.get_item_text(option_button.get_selected_id())
			else:
				answer.text = "???"
			var text = format(answer.text)
			if answer.text.length() > 25:
				answer.add_theme_font_size_override("font_size", 12)
			else:
				answer.add_theme_font_size_override("font_size", 25)
			if text.length() == 0:
				answer.text = "???"
			option_button.visible = false
			submit_button.visible = false
			correction.visible = true
			next_button.visible = true
		else:
			answer.visible = false
			option_button.visible = true
			submit_button.visible = true
			correction.visible = false
			next_button.visible = false

func correct_answer(correct_answer): # Corrects and displays correction
	var background = StyleBoxFlat.new()
	var correct = format(correct_answer)
	var introduced : String
	if Global.mode == "NAMES":
		introduced = format(answer.text)
		if correct == introduced:
			if !learnt_pokémon.has(correct_answer):
				learnt_pokémon[correct_answer] = 6.5
			else:
				learnt_pokémon[correct_answer] = ((10 - abs(learnt_pokémon[correct_answer])) + 0.5)
				if learnt_pokémon[correct_answer] >= 10.0:
					learnt_pokémon[correct_answer] = 9.5
			guessed_pokémon.push_back(correct_answer.to_upper())
			points += 1
			correction_label.text = "CORRECT"
			background.bg_color = Color(0.36, 0.63, 0.33, 1.00)
			if guessed_pokémon.size() == pokédex.size():
				correction_animation.play("won")
				points_label.text = "Correct: " + str(points) + " - Incorrect: " + str(strikes) + "/3"
				strikes = 3
				#correction_timer.start()
				
			else:
				correction_animation.play("right")
				update_score()
		else:
			if !learnt_pokémon.has(correct_answer):
				learnt_pokémon[correct_answer] = -5
			else:
				learnt_pokémon[correct_answer] = sign(learnt_pokémon[correct_answer]) * (abs(learnt_pokémon[correct_answer]) - 0.5)
				if learnt_pokémon[correct_answer] == 0.0:
					learnt_pokémon[correct_answer] = 0.0
				elif learnt_pokémon[correct_answer] <= -10.0:
					learnt_pokémon[correct_answer] = -9.5
			correction_label.text = correct_answer
			background.bg_color = Color(0.92, 0.27, 0.11, 1.00)
			strikes += 1
			update_score()
			if strikes >= 3:
				correction_animation.play("lost")
			else:
				correction_animation.play("wrong")
		animating = true
		correction_timer.start()
		background.corner_radius_bottom_left = 5
		background.corner_radius_bottom_right = 5
		background.corner_radius_top_left = 5
		background.corner_radius_top_right = 5
		correction.add_theme_stylebox_override("panel", background)
	elif Global.mode == "FORMS":
		introduced = format(option_button.get_item_text(0) + "_" + option_button.get_item_text(option_button.get_selected_id()))
		if introduced == correct:
			guessed_pokémon.push_back(correct_answer.to_upper())
			points += 1
			var correction_theme = correction_label.label_settings
			correction_theme.font_size = 35
			correction_label.text = "CORRECT"
			background.bg_color = Color(0.36, 0.63, 0.33, 1.00)
			if guessed_pokémon.size() == Global.total_forms:
				correction_animation.play("won")
				points_label.text = "Correct: " + str(points) + " - Incorrect: " + str(strikes) + "/3"
				strikes = 3
			else:
				correction_animation.play("right")
				update_score()
		else:
			correction_label.text = correct_answer.replace("_", " ")
			strikes += 1
			var correction_theme = correction_label.label_settings
			if correction_label.text.length() > 20:
				correction_theme.font_size = 25
			else:
				correction_theme.font_size = 35
			background.bg_color = Color(0.92, 0.27, 0.11, 1.00)
			update_score()
			if strikes >= 3:
				correction_animation.play("lost")
			else:
				correction_animation.play("wrong")
		animating = true
		correction_timer.start()
		background.corner_radius_bottom_left = 5
		background.corner_radius_bottom_right = 5
		background.corner_radius_top_left = 5
		background.corner_radius_top_right = 5
		correction.add_theme_stylebox_override("panel", background)

func _on_next_button_pressed() -> void: # Changes the pokémon shown
	if !animating:
		animating = true
		choose_next_pokémon(current_pokémon)
	elif strikes == 5:
		strikes = 6
		change_scene_animation.play("leave_scene")
		correction_timer.start()

func choose_next_pokémon(current): # Chooses a pokémon based on learning. If not found, choses next pokédex entry.
	var chosen_pokémon_name := ""
	var found_candidate := false
	if Global.mode == "NAMES":
		var random_chance := 0
		random_chance = learnt_pokémon.size() - 20

		if learnt_pokémon.size() < 1 and current.to_upper() != pokédex[0].to_upper():
			chosen_pokémon_name = pokédex[0]
			if chosen_pokémon_name != "":
				found_candidate = true
				print("First pokémon in the pokédex chosen!")
			else:
				push_warning("Could not find the first pokémon in the pokédex.")

		if !found_candidate and (random_chance > 0 and learnt_pokémon.size() >= pokédex.size() * 0.9) or (random_chance > 10 and learnt_pokémon.size() < pokédex.size() * 0.9): # Choses a pokémon randomly somtimes.
			if Global.rng.randi_range(1, int(random_chance / pokédex.size())) == 1:
				var available_pokémon = []
				for p_name in pokédex:
					if !guessed_pokémon.has(p_name) and current.to_upper() != p_name.to_upper():
						available_pokémon.append(p_name)

				if !available_pokémon.is_empty():
					chosen_pokémon_name = available_pokémon[Global.rng.randi_range(0, available_pokémon.size() - 1)]
					found_candidate = true
					print("A random pokémon chosen!")
				else:
					push_warning("There isn't any pokémon available for the random pick.")

		if !found_candidate and learnt_pokémon.size() < pokédex.size() * 0.9 and Global.rng.randi_range(1, int(pokédex.size() / learnt_pokémon.size())) < learnt_pokémon.size() / 2:
			var start_index = pokédex.find(current.to_upper())
			random_chance = Global.rng.randi_range(-1, 2)
			while random_chance == 0:
				random_chance = Global.rng.randi_range(-1, 2)
			print("Choosing next pokémon through slightly randomised pokédex order. Random offset: ", random_chance)
			if start_index == -1:
				start_index = 0
			var initial_check_index = start_index
			var current_index = start_index
			while true:
				current_index = (current_index + random_chance) % pokédex.size()
				var candidate = pokédex[current_index]
				if !guessed_pokémon.has(candidate) and current.to_upper() != candidate.to_upper():
					chosen_pokémon_name = candidate
					found_candidate = true
					break
				if current_index == initial_check_index:
					if guessed_pokémon.size() == (pokédex.size() - 1) and !guessed_pokémon.has(current.to_upper()):
						chosen_pokémon_name = current.to_upper()
						found_candidate = true
						break
					else:
						chosen_pokémon_name = pokédex[(start_index + 1) % pokédex.size()]
						found_candidate = true
						break

		if !found_candidate: # If the pokémon hasn't been chosen randomly.
			print("Choosing pokémon through closeness to other learnt pokémon in the pokédex.")
			var pokémon_for_sorting = []
			for key in learnt_pokémon.keys():
				var original_value = learnt_pokémon[key]
				var random_offset = Global.rng.randf_range(-1.0, 1.0)
				var modified_value = abs(abs(original_value) + random_offset)
				pokémon_for_sorting.append([key, original_value, modified_value])

			var un_guessed_pokémon_valid_candidates = []
			for p_name in pokédex:
				if !guessed_pokémon.has(p_name) and current.to_upper() != p_name.to_upper():
					un_guessed_pokémon_valid_candidates.append(p_name)

			var added_count = 0
			for p in pokémon_for_sorting:
				if added_count >= 4:
					break

				var learnt_pokemon_name = p[0]
				var learnt_pokemon_index_in_pokedex = pokédex.find(learnt_pokemon_name)

				if learnt_pokemon_index_in_pokedex != -1:
					var candidates_around_learnt_pokemon = []
					var search_range = 1
					var range_calculation
					for i in range(-search_range, search_range + 1):
						var potential_index = learnt_pokemon_index_in_pokedex + i
						if potential_index < 0:
							while potential_index < 0 and pokédex.size() > 0:
								#potential_index += pokédex.size()
								potential_index = 0
						elif potential_index >= pokédex.size():
							potential_index %= pokédex.size()

						var candidate_name = pokédex[potential_index]

						if un_guessed_pokémon_valid_candidates.has(candidate_name):
							var already_in_sorting_list = false
							for sorted_p in pokémon_for_sorting:
								if sorted_p[0] == candidate_name:
									already_in_sorting_list = true
									break
							if !already_in_sorting_list:
								candidates_around_learnt_pokemon.append(candidate_name)

					if !candidates_around_learnt_pokemon.is_empty():
						candidates_around_learnt_pokemon.shuffle()
						var chosen_candidate = candidates_around_learnt_pokemon[0]
						var random_modified_value = Global.rng.randf_range(3.0, 7.0)
						pokémon_for_sorting.append([chosen_candidate, 0.0, random_modified_value])
						added_count += 1
						un_guessed_pokémon_valid_candidates.erase(chosen_candidate)

			if added_count < 4:
				#un_guessed_pokémon_valid_candidates.shuffle()
				for candidate in un_guessed_pokémon_valid_candidates:
					if added_count >= 4:
						break
					var already_in_sorting_list = false
					for p in pokémon_for_sorting:
						if p[0] == candidate:
							already_in_sorting_list = true
							break
					if !already_in_sorting_list:
						var random_modified_value = Global.rng.randf_range(3.0, 7.0)
						pokémon_for_sorting.append([candidate, 0.0, random_modified_value])
						added_count += 1

			pokémon_for_sorting.sort_custom(func(a, b): return a[2] < b[2])

			var sorted_pokémon_names = []
			for pokémon in pokémon_for_sorting:
				sorted_pokémon_names.append(pokémon[0])

			for n in 10:
				if n >= sorted_pokémon_names.size():
					break
				var candidate = sorted_pokémon_names[n]
				if !guessed_pokémon.has(candidate) and current.to_upper() != candidate.to_upper():
					chosen_pokémon_name = candidate
					found_candidate = true
					break

		if !found_candidate:
			print("Choosing next pokémon in the pokédex as no candidate has yet been found.")
			var start_index = pokédex.find(current.to_upper())
			if start_index == -1:
				start_index = 0
			var initial_check_index = start_index
			var current_index = start_index
			while true:
				current_index = (current_index + 1) % pokédex.size()
				var candidate = pokédex[current_index]
				if !guessed_pokémon.has(candidate) and current.to_upper() != candidate.to_upper():
					chosen_pokémon_name = candidate
					found_candidate = true
					break
				if current_index == initial_check_index:
					if guessed_pokémon.size() == (pokédex.size() - 1) and !guessed_pokémon.has(current.to_upper()):
						chosen_pokémon_name = current.to_upper()
						found_candidate = true
						break
					else:
						chosen_pokémon_name = pokédex[(start_index + 1) % pokédex.size()]
						found_candidate = true
						break

		if chosen_pokémon_name == "":
			chosen_pokémon_name = "MISSINGNO"
			push_warning("Could not determine next pokémon.")
	
	
	
	elif Global.mode == "FORMS":
		#Obtener todas las claves (nombres de Pokémon) y mezclar su orden para una búsqueda semi-aleatoria.
		var all_keys = Global.forms_pokédex.keys()
		all_keys.shuffle()
		
		var starting_key_index = 0
		var starting_form_index = 0
		var forms_array : Array
		
		if submit_button.text == "FIRST!":
			submit_button.text = "SUBMIT"
			option_button.clear()
			option_button.add_separator("ALCREMIE")
			forms_array = Global.forms_pokédex["ALCREMIE"]
			for n in forms_array.size():
				option_button.add_item(forms_array[n])
			first_click = option_button.get_item_text(1)
			option_button.set_item_text(1, "???")
			return
		else:
		# Bucle principal para encontrar un candidato no adivinado.
			for i in range(all_keys.size()):
				var current_key = all_keys[i]
				forms_array = Global.forms_pokédex[current_key] # Mezclar las formas para una selección aleatoria dentro del array.
				forms_array = shuffle_array(forms_array, Global.rng)
				if !found_candidate:
						for j in range(forms_array.size()):
							var current_form = forms_array[j]
							var candidate_string = current_key + "_" + current_form
							
							if not candidate_string in guessed_pokémon:
								chosen_pokémon_name = candidate_string
								option_button.clear()
								found_candidate = true
								option_button.add_separator(current_key.to_upper()) 
								forms_array = shuffle_array(forms_array, Global.rng)
								for n in forms_array.size():
									option_button.add_item(forms_array[n])
								first_click = option_button.get_item_text(1)
								option_button.set_item_text(1, "???")
				else:
					break

		# Si se llegara a este punto, significa que algo no funcionó como se esperaba.
		# Esto podría ocurrir en un caso muy improbable donde la verificación inicial fallara.
		if !found_candidate:
			push_warning("No se pudo encontrar un candidato válido. Devolviendo 'MISSINGNO'.")
			chosen_pokémon_name = "MISSINGNO"
	
	
	next_pokémon_name = chosen_pokémon_name
	texture_path = ""
	display_pokémon(next_pokémon_name, true)
	if guessed_pokémon.size() > 0 or strikes > 0:
		animate_next_pokémon()
	print(next_pokémon_name)

func _on_correction_timer_timeout() -> void: # Makes it able to interact after the animation ended.
	if strikes < 3:
		animating = false
	elif strikes == 3:
		correction_timer.start()
		strikes += 1
	elif strikes == 4:
		if Global.mode == "NAMES":
			if Global.kanto_best_score < points and Global.region == "KANTO":
				Global.kanto_best_score = points
			if Global.johto_best_score < points and Global.region == "JOHTO":
				Global.johto_best_score = points
			if Global.hoenn_best_score < points and Global.region == "HOENN":
				Global.hoenn_best_score = points
			if Global.sinnoh_best_score < points and Global.region == "SINNOH":
				Global.sinnoh_best_score = points
			if Global.teselia_best_score < points and Global.region == "TESELIA":
				Global.teselia_best_score = points
			if Global.kalos_best_score < points and Global.region == "KALOS":
				Global.kalos_best_score = points
			if Global.alola_best_score < points and Global.region == "ALOLA":
				Global.alola_best_score = points
			if Global.galar_best_score < points and Global.region == "GALAR":
				Global.galar_best_score = points
			if Global.hisui_best_score < points and Global.region == "HISUI":
				Global.hisui_best_score = points
			if Global.paldea_best_score < points and Global.region == "PALDEA":
				Global.paldea_best_score = points
			if Global.unknown_best_score < points and Global.region == "UNKNOWN":
				Global.unknown_best_score = points
		elif Global.forms_best_score < points and Global.mode == "FORMS":
			Global.forms_best_score = points
		strikes = 5
	elif strikes > 5:
		change_scene_animation.play("CLOSED")
		if Global.mode == "NAMES":
			get_tree().change_scene_to_file("res://Scenes/menu.tscn")
		elif Global.mode == "FORMS":
			get_tree().change_scene_to_file("res://Scenes/intro.tscn")

func animate_next_pokémon(): # Initiates transition to the next Pokémon
	animating = true
	texture_rect_animated.visible = true
	texture_rect.stretch_mode = TextureRect.STRETCH_SCALE
	texture_rect_animated.stretch_mode = TextureRect.STRETCH_SCALE
	var tween: Tween = create_tween()
	h_split_container.split_offset = h_split_container.size.x
	tween.tween_property(h_split_container, "split_offset", 0, 0.5)
	next_pokémon_timer.start()

func _on_next_pokémon_timer_timeout() -> void: # Enables play after animation
	animating = false
	load_scene(next_pokémon_name)

func update_score(): # Updates the score label
		points_label.text = "Correct: " + str(points) + " - Incorrect: " + str(strikes) + "/3"

func choose_pokédex(region):
	if Global.mode == "NAMES":
		print("NAMES mode selected!")
		if region == "KANTO":
			pokédex = Global.kanto_pokédex
			learnt_pokémon = Global.kanto_learnt_pokémon
		elif region == "JOHTO":
			pokédex = Global.johto_pokédex
			learnt_pokémon = Global.johto_learnt_pokémon
		elif region == "HOENN":
			pokédex = Global.hoenn_pokédex
			learnt_pokémon = Global.hoenn_learnt_pokémon
		elif region == "SINNOH":
			pokédex = Global.sinnoh_pokédex
			learnt_pokémon = Global.sinnoh_learnt_pokémon
		elif region == "TESELIA":
			pokédex = Global.teselia_pokédex
			learnt_pokémon = Global.teselia_learnt_pokémon
		elif region == "KALOS":
			pokédex = Global.kalos_pokédex
			learnt_pokémon = Global.kalos_learnt_pokémon
		elif region == "ALOLA":
			pokédex = Global.alola_pokédex
			learnt_pokémon = Global.alola_learnt_pokémon
		elif region == "GALAR":
			pokédex = Global.galar_pokédex
			learnt_pokémon = Global.galar_learnt_pokémon
		elif region == "HISUI":
			pokédex = Global.hisui_pokédex
			learnt_pokémon = Global.hisui_learnt_pokémon
		elif region == "PALDEA":
			pokédex = Global.paldea_pokédex
			learnt_pokémon = Global.paldea_learnt_pokémon
		elif region == "UNKNOWN":
			pokédex = Global.unknown_pokédex
			learnt_pokémon = Global.unknown_learnt_pokémon
	elif Global.mode == "FORMS":
		print("FORMS mode selected!")
		return

func display_pokémon(pokémon, for_animation):
	if Global.mode == "NAMES":
		if texture_path == "":
			if Global.form_variety and Global.forms_pokédex.has(pokémon.to_upper()):
				print("Choosing random form!")
				var available_forms = Global.forms_pokédex[pokémon.to_upper()]
				var random_index = Global.rng.randi_range(0, available_forms.size() - 1)
				var chosen_form = available_forms[random_index]
				texture_path = "res://Assets/Pokémon_Forms/" + pokémon.to_lower().replace(" ", "-") + "_" + chosen_form.to_lower().replace(" ", "-") + ".png"
			else:
				texture_path = "res://Assets/Pokémon/" + pokémon.to_lower().replace(" ", "-") + ".png"
		
	elif Global.mode == "FORMS":
		texture_path = "res://Assets/Pokémon_Forms/" + pokémon.to_lower().replace(" ", "-") + ".png"
	
	if for_animation:
		texture_rect_animated.texture = load(texture_path)
		if texture_rect_animated.texture == null:
			texture_rect_animated.texture = load("res://Assets/Pokémon/MissingNo.png")
			push_warning("The file with the image of the pokémon " + current_pokémon.to_upper() + " does not exist or has not been found.")
	else:
		texture_rect.texture = load(texture_path)
		if texture_rect.texture == null:
			texture_rect.texture = load("res://Assets/Pokémon/MissingNo.png")
			push_warning("The file with the image of the pokémon " + current_pokémon.to_upper() + " does not exist or has not been found.")

func format(text : String) -> String:
	return text.to_upper().replace(" ", "").replace(":", "").replace(".", "").replace("Á", "A").replace("É", "E").replace("Í", "I").replace("Ó", "O").replace("Ú", "U").replace("'", "").replace("Ç", "C").replace("Ñ", "N").replace("-", "")

func _on_option_button_pressed() -> void:
	if first_click != "":
		option_button.set_item_text(1, first_click)
		first_click = ""

func shuffle_array(array : Array, rng : RandomNumberGenerator) -> Array:
	var shuffled_array = array.duplicate()
	var n = shuffled_array.size()
	while n > 1:
		var k = rng.randi_range(0, n - 1)
		n -= 1
		var temp = shuffled_array[n]
		shuffled_array[n] = shuffled_array[k]
		shuffled_array[k] = temp
	return shuffled_array
