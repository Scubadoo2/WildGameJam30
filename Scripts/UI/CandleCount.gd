extends Control


var count = 0
var countHolder


# Called when the node enters the scene tree for the first time.
func _ready():
	countHolder = $Count
	ChangeCount(count)


func ChangeCount(newAmount):
	count = newAmount
	countHolder.set_text(String(newAmount))
