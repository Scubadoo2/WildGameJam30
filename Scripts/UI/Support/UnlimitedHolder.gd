extends Control

var count = 0
	
func GetItem(amount) -> bool:
	count += amount
	UpdateVisual()
	return true
	
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
