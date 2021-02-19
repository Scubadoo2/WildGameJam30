extends Control

export (String, FILE, "*.tscn") var game_world_path

onready var menu = $MenuButtons


func _on_Start_pressed():
	SFXPlayer.play_sfx("ui_menu_play_game_1", SFXVolume.button_volume)
	yield(get_tree().create_timer(1.0), "timeout")
	get_tree().change_scene(game_world_path)


func _on_Quit_pressed():
	SFXPlayer.play_sfx("ui_menu_select_move", SFXVolume.button_volume)
	get_tree().quit()

func ShowInstructions(show):
	SFXPlayer.play_sfx("ui_menu_select_move", SFXVolume.button_volume)
	$Info.set_visible(show)
	menu.set_visible(!show)
