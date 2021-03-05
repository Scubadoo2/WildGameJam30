extends Control


# Editable values
export (String) var optionName
export (String) var displayName
export (int) var minimum = 0
export (int) var maximum = 100
export (int) var ticks = 0
export (int) var currentValue = 0 setget UpdateValue

#Holders
var slider
var numberDisplay

# Called when the node enters the scene tree for the first time.
func _ready():
	$Show.set_text(displayName)
	slider = $Slider
	numberDisplay = $Slider/NumberEdit
	
	slider.set_min(minimum)
	slider.set_max(maximum)
	slider.set_ticks(ticks)

	UpdateValue(currentValue)

#####################################
# Updade value function
#
# Updates the value that it stores and 
# Changes the display
#####################################

func UpdateValue(newValue):
	if(slider == null): return
	#check to make sure the value is in range
	if(newValue < minimum):
		currentValue = minimum
	elif(newValue > maximum):
		currentValue = maximum
	else:
		currentValue = newValue
		
	#Set displays
	slider.set_value(currentValue)
	numberDisplay.set_text(String(currentValue))





func SliderChange(newValue):
	if(newValue != currentValue):
		currentValue = newValue
		UpdateValue(currentValue)
		
func DisplayChange(_newText):
	#Check if the number typed in is an actual valid number
	if(numberDisplay.get_text().is_valid_integer()):
		var testValue = numberDisplay.get_text().to_int()
		if(currentValue != testValue):
			currentValue = testValue
			UpdateValue(currentValue)
	else:
		numberDisplay.set_text(String(currentValue))
	
	numberDisplay.release_focus()
