extends Control

#Heartbeat variables we set ourselves
var forgive = .2 # amount off a person can be from the beat

#Quick reference to objects
onready var timer = $Rhythm
onready var meter = $Meter
onready var heart = $Heart
onready var meterCenter  = $Meter/Center
onready var beat = $Heartbeat

#References to the bars
onready var meterRO  = $Meter/PlaceRO
onready var meterRI  = $Meter/PlaceRI
onready var meterLO  = $Meter/PlaceLO
onready var meterLI  = $Meter/PlaceLI

#Placement to lessen calculation time
var yPlacement
var halfway
var halfWidth

#Signals
signal heartbeat()


# Called when the node enters the scene tree for the first time.
func _ready():
	yPlacement = (meter.rect_size.y/2) - (meterCenter.rect_size.y/2)
	halfway = meter.rect_size.x/2
	halfWidth = meterCenter.rect_size.x/2
	#barWidth = meterCenter.rect_size.x
	
	# Make it acutal timing for both-sided check
	forgive = forgive/2
	
	timer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var timeLeft = 1-(timer.time_left / timer.wait_time)
	var distance = (meter.rect_size.x * timeLeft)/4
	
	#meterPlace.set_position(Vector2((meter.rect_size.x * timeLeft),yPlacement))
	meterRO.set_position(Vector2(halfway*2 - distance - halfWidth,yPlacement))
	meterRI.set_position(Vector2(halfway*1.5 - distance - halfWidth,yPlacement))
	
	meterLO.set_position(Vector2(distance - halfWidth,yPlacement))
	meterLI.set_position(Vector2(halfway/2 + distance - halfWidth,yPlacement))
	
func IsInBeat():
	if(timer.time_left < forgive || (timer.wait_time - timer.time_left) < forgive):
		return true
	else:
		return false
		
		
func Beat():
	# Fire off our own signal
	emit_signal("heartbeat")
	
	heart.frame = 1
	beat.start()
	
func OffBeat():
	heart.frame = 0
	
func ChangeBeat(newTime):
	var remaining = timer.time_left
	timer.wait_time = newTime
	
	#Restart the timer
	timer.start(0)
		
	
	beat.wait_time = newTime / 4
	
	
