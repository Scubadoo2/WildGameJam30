extends Control


#Quick Reference
var countHolder
var maxHolder

var count = 0
var maximum = 100

signal GameOver(how)

# Called when the node enters the scene tree for the first time.
func _ready():
	countHolder = $Holder/Count
	maxHolder = $Holder/Max


func SetMax(newMax):
	maximum = newMax
	maxHolder.set_text(String(newMax))
	
func SetCount(newAmount):
	count = newAmount
	countHolder.set_text(String(newAmount))
	if(newAmount > maximum):
		emit_signal("GameOver", "nightmares")

## Carto Addition
func ReachedMax() -> bool:
	return count >= 100
## -- ##
