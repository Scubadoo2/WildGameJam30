extends Control


var hour = 23
var minute = 40

var hourGoal = 0
var minuteGoal = 10

onready var hourSay = $Hour
onready var minuteSay = $Minute
onready var m = $M
onready var tick = $Ticking

#Signals
signal MinuteChime()
signal HourChime()
signal Win()

#func _ready():
#	StartClock(hour, minute, hourGoal, minuteGoal, tick.get_wait_time() * 30)

# Called when the node enters the scene tree for the first time.
func StartClock(startHour, startMinute, endHour, endMinute, hourLength):
	hour = startHour
	hourGoal = endHour
	
	minute = startMinute
	minuteGoal = endMinute
	
	MajorUpdateDisplay()
	
	tick.set_wait_time(hourLength / 60.0)
	tick.start()

func MinutesLeft():
	var hoursLeft
	if(hour > hourGoal):
		hoursLeft = (24 - hour) + hourGoal
	else:
		hoursLeft = hourGoal - hour
		
	var minutesLeft
	if(minute > minuteGoal):
		minutesLeft = (60 - minute) + minuteGoal
		hoursLeft -= 1
		if(hoursLeft < 0):
			hoursLeft = 23
	
	else:
		minutesLeft = minuteGoal - minute
		
	return (hoursLeft * 60) + minutesLeft

func MinuteHit():
	minute = (minute+1) % 60
	emit_signal("MinuteChime")
	if(minute == 0):
		hour = (hour+1) % 24
		MajorUpdateDisplay()
		emit_signal("HourChime")
	else:
		UpdateDisplay()
		
	if(MinutesLeft() == 0):
		tick.stop()
		emit_signal("Win")

#Meant for just when the minute passes
func UpdateDisplay():
	#Display Minute
	minuteSay.set_text("%02d" % minute)

#Meant for when an hour passes
func MajorUpdateDisplay():
	#Display Hour
	var displayHour = hour % 12
	if(displayHour == 0):
		displayHour = 12
	hourSay.set_text(String(displayHour))
	
	#Display Minute
	minuteSay.set_text("%02d" % minute)
	
	#Display am or pm
	if((hour / 12) >= 1):
		m.set_text("pm")
	else:
		m.set_text("am")
	
func StopTimer(_how):
	tick.stop()
