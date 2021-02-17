extends "res://Scripts/UI/Support/LimitedHolder.gd"


var inventory = []
var prevCount = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	for child in get_children():
		child.set_visible(false)
		inventory.append(child)
		
	maximum = inventory.size()
	

func UpdateVisual():
	if(prevCount == count): return
	
	#Decreasing the inventory
	while prevCount > count:
		prevCount -= 1
		inventory[prevCount].set_visible(false)
		
	#Increasing the inventory
	while prevCount < count:
		inventory[prevCount].set_visible(true)
		prevCount += 1
