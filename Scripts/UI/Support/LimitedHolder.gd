extends Control

var maximum = 3
var count = 0
	
func GetItem(amount) -> bool:
	var temp = count + amount
	if(temp <= maximum):
		count = temp
		UpdateVisual()
		return true
	else:
		return false
	
func UseItem(amount) -> bool:
	var temp = count - amount
	if(temp >= 0):
		count = temp
		UpdateVisual()
		return true
	else:
		return false
		
func UpdateVisual():
	pass
