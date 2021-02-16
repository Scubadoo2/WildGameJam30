extends Control

var maxStress = 3
var stress = 0

var maxStressShow
var stressShow

onready var stressBar = $VisualStress
onready var stressBarPercent = $VisualStress/StressPercent
onready var tooStressedShow = $VisualStress/Overflow


# Called when the node enters the scene tree for the first time.
func _ready():
	maxStressShow = $StressCounter/Max
	stressShow = $StressCounter/Current
	
	maxStressShow.text = String(maxStress)
	stressShow.text = String(stress)
	
	ChangeVisual()

#Returns if it got too high or not
func ChangeStress(amount):
	var newStress = stress + amount
	if(newStress > maxStress):
		stress = maxStress + 1
		ChangeVisual()
		return true
	elif(newStress < 0):
		newStress = 0
		
	stress = newStress
	ChangeVisual()
	return false
	
	
func ChangeVisual():
	stressShow.text = String(stress)
	
	if(stress > maxStress):
		tooStressedShow.visible = true
		stressBarPercent.rect_size = stressBar.rect_size
		stressBarPercent.rect_position = Vector2(0,0)
	else:
		tooStressedShow.visible = false
		
		var percent = stress/float(maxStress + 1)
		stressBarPercent.rect_size = Vector2(stressBar.rect_size.x, stressBar.rect_size.y * percent)
		stressBarPercent.rect_position = Vector2(0
			, stressBar.rect_size.y * (1-percent))
		
		
