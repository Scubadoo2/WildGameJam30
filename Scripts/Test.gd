extends Node

var rightColor = Color(.2,1.0,.2)
var wrongColor = Color(1.0,.2,.2)

onready var polygon = $Node2D/Polygon2D
var defaultColor

onready var beat = $Control/BeatHolder
onready var timer = $Timer

onready var stressDisplay = $Control/Stress

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	defaultColor = polygon.color
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(Input.is_action_just_pressed("attack")):
		if(beat.IsInBeat()):
			polygon.set_color(rightColor)
		else:
			polygon.set_color(wrongColor)
			
		timer.start()

func resetColor():
	polygon.set_color(defaultColor)
	
func ChangeStress(amount):
	stressDisplay.ChangeStress(amount)
