extends Node

var title_screen = preload("res://Scenes/TitleScreen/TitleScreen.tscn")
var game = preload("res://Scenes/game_manager/Game.tscn")

var current_node

func _ready():
	play_title()
	

func play_game():
	if current_node != null:
		remove_child(current_node)
		current_node.queue_free()
		current_node = null
	
	var game_node = game.instance()
	current_node = game_node
	add_child(current_node)
	
func play_title():
	if current_node != null:
		remove_child(current_node)
		current_node.queue_free()
		current_node = null
	
	var title_node = title_screen.instance()
	title_node.connect("quit", self, "quit_game")
	title_node.connect("play_game", self, "play_game")
	current_node = title_node
	add_child(title_node)
	
func quit_game():
	get_tree().quit()
