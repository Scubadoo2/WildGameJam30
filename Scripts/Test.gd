extends Node

var rightColor = Color(.2,1.0,.2)
var wrongColor = Color(1.0,.2,.2)

onready var timer = $Timer
onready var polygon = $Node2D/Polygon2D
var defaultColor

onready var ui = $UI

export (int) var nightmares = 30
export (int) var candles = 4

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	defaultColor = polygon.color
	ui.SetNMCount(nightmares)
	ui.SetCandleCount(candles)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if(Input.is_action_just_pressed("attack")):
		if(ui.IsInBeat()):
			polygon.set_color(rightColor)
		else:
			polygon.set_color(wrongColor)
			
		timer.start()

func resetColor():
	polygon.set_color(defaultColor)
	
func HealTest(amount):
	ui.Heal(amount)
	
func HurtTest(amount):
	ui.TakeDamage(amount)
	
func AddNM(amount):
	nightmares += amount
	ui.SetNMCount(nightmares)
	
func RemoveNM(amount):
	nightmares -= amount
	ui.SetNMCount(nightmares)

func AddCandle(amount):
	candles += amount
	ui.SetCandleCount(candles)
	
func RemoveCandle(amount):
	candles -= amount
	ui.SetCandleCount(candles)
