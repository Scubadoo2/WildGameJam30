extends Node2D

export (NodePath) var player_path
export (NodePath) var ui_path

var player
var ui

func _ready():
	if player_path != "" and ui_path != "":
		player = get_node(player_path)
		ui = get_node(ui_path)
	
		player.connect("player_attacked", ui, "TakeDamage")
		player.connect("player_heal", ui, "Heal")
	else:
		printerr("Paths not give")
