extends Control

#Heartbeat variables we set ourselves
var forgive = .1 # amount off a person can be from the beat

#Quick reference to objects
onready var timer = $Timer
onready var meter = $Meter
onready var meterPlace  = $Meter/Place
onready var heart = $Heart

#Placement to lessen calculation time
var yPlacement

#Signals
signal heartbeat()


# Called when the node enters the scene tree for the first time.
func _ready():
	yPlacement = (meter.rect_size.y/2) - (meterPlace.rect_size.y/2)
	
	# Make it acutal timing for both-sided check
	forgive = forgive/2
	
	timer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var timeLeft = 1-(timer.time_left / timer.wait_time)
	
	meterPlace.set_position(Vector2((meter.rect_size.x * timeLeft),yPlacement))
	
func IsInBeat():
	if(timer.time_left < forgive || (timer.wait_time - timer.time_left) < forgive):
		return true
	else:
		return false
		
		
func Beat():
	# Fire off our own signal
	emit_signal("heartbeat")
	
	heart.frame = (heart.frame + 1)%2
	
	
