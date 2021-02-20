extends ColorRect


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var player = $AnimationPlayer

signal FadedOut()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func FadeOut(durration):
	player.play("Fade out", -1, 1.0/durration)

func DoneFading(played = 1):
	if(played == "Fade out"):
		emit_signal("FadedOut")

