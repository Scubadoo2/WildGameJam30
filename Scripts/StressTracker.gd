extends Control

var maxStress = 3
var stress = 0

var maxStressShow
var stressShow

onready var stressBar = $VisualStress
onready var stressBarPercent = $VisualStress/StressPercent
onready var tooStressedShow = $VisualStress/Overflow

#Signals
signal GameOver()


# Called when the node enters the scene tree for the first time.
func _ready():
	maxStressShow = $StressCounter/Max
	stressShow = $StressCounter/Current
	
	UpdateVisual()

#Returns if it got too high or not
func ChangeStress(amount):
	
	stress = int(clamp(stress + amount, 0, maxStress))
	
	if(stress >= maxStress):
		emit_signal("GameOver", "stress")
	
	UpdateVisual()
	
func ChangeMaxStress(newMax):
	var difference = maxStress - stress
	maxStress = newMax
	
	stress = int(max(newMax - difference, 0))
	
	ChangeStress(0)
	
	
func UpdateVisual():
	stressShow.text = String(stress)
	maxStressShow.text = String(maxStress)
	
	if(stress >= maxStress):
		tooStressedShow.visible = true
		stressBarPercent.rect_size = stressBar.rect_size
		stressBarPercent.rect_position = Vector2(0,0)
	else:
		tooStressedShow.visible = false
		
		var percent = stress/float(maxStress )
		stressBarPercent.rect_size = Vector2(stressBar.rect_size.x, stressBar.rect_size.y * percent)
		stressBarPercent.rect_position = Vector2(0
			, stressBar.rect_size.y * (1-percent))
		
		
