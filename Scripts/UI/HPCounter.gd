extends Control

#Main variables
var maxHP = 3
var hp = maxHP

var hpHolder
var maxHolder

#Signals
signal GameOver()

# Called when the node enters the scene tree for the first time.
func _ready():
	#Quick reference
	hpHolder = $Hitpoints
	maxHolder = $Max
	UpdateVisual()
	
func ChangeHP(amount):
	hp = int(clamp(hp + amount, 0, maxHP))
	
	if(hp <= 0):
		emit_signal("GameOver", "hp")
		
	UpdateVisual()
	
func ChangeMaxHP(newMax):
	var difference = maxHP - hp
	maxHP = newMax
	
	hp = int(max(maxHP - difference, 1))
	ChangeHP(0)

func UpdateVisual():
	hpHolder.text = String(hp)
	maxHolder.text = String(maxHP)
	
	
