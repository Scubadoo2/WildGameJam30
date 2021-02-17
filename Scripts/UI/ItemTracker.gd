extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var items = []
var itemLookup = []

# Called when the node enters the scene tree for the first time.
func _ready():
	#Gather all the item types that can be gathered
	for child in get_children():
		if(child is ReferenceRect):
			continue
			
		items.append(child)
		itemLookup.append(child.get_name().to_lower())
		
func GetItem(itemType, amount) -> bool:
	if(itemLookup.find(itemType) >= 0):
		return items[itemLookup.find(itemType)].GetItem(amount)
	else:
		print("ERROR: " + itemType + " is not an item that can be stored.")
		return false

func UseItem(itemType, amount) -> bool:
	if(itemLookup.find(itemType) >= 0):
		return items[itemLookup.find(itemType)].UseItem(amount)
	else:
		print("ERROR: " + itemType + " is not an item that can be used.")
		return false
