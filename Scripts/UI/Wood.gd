extends "res://Scripts/UI/Support/UnlimitedHolder.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var display = $Amount


func UpdateVisual():
	display.set_text(String(count))

