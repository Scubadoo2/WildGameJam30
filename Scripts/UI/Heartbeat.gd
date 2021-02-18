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

#Variables for when the beat changes
var changedBeat = false
var newBeat

# Music
onready var musicPlayer = $MusicHolder
var music = [null, preload("res://Sound/Music/Spooky Nightmares (70 BPM).wav"),
	preload("res://Sound/Music/Spooky Nightmares (65 BPM).wav"),
	preload("res://Sound/Music/Spooky Nightmares (60 BPM).wav")]
	
var musicBeat = [null, 6.0/7.0, 12.0/13.0, 1]

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
	
	#Set music and timer
	musicPlayer.set_stream(music.back())
	musicPlayer.play()
	timer.start(musicBeat.back())


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	var timeLeft = 1-(timer.time_left / timer.wait_time)
	var distance = (meter.rect_size.x * timeLeft)/4
	
	meterRO.set_position(Vector2(halfway*2 - distance - halfWidth,yPlacement))
	meterRI.set_position(Vector2(halfway*1.5 - distance - halfWidth,yPlacement))
	
	meterLO.set_position(Vector2(distance - halfWidth,yPlacement))
	meterLI.set_position(Vector2(halfway/2 + distance - halfWidth,yPlacement))
	

func GetTrackAmount():
	return musicBeat.size() - 1
	
func IsInBeat():
	return (timer.time_left < forgive
	|| (timer.wait_time - timer.time_left) < forgive)
		
		
func Beat():
	# Fire off our own signal
	emit_signal("heartbeat")
	
	#Change the beat if it's been changed
	if(changedBeat):
		if(newBeat == 0):
			return
		#Get the time left
		var timeLeft = musicPlayer.get_playback_position()
		var percentLeft = timeLeft / musicPlayer.stream.get_length()
		
		#Change the song
		var newSong = music[newBeat]
		musicPlayer.stop()
		musicPlayer.set_stream(newSong)
		
		#Find where it would be in the new song
		var newTime = newSong.get_length() * percentLeft
		
		#Reset time and music
		musicPlayer.play(newTime)
		timer.start(musicBeat[newBeat])
		
		beat.wait_time = musicBeat[newBeat] / 4
		changedBeat = false
	
	heart.frame = 1
	beat.start()
	
func OffBeat():
	heart.frame = 0
	
func ChangeBeat(newHP):
	changedBeat = true
	newBeat = newHP
	
func StopEverything(_how):
	timer.set_paused(true)
	musicPlayer.stop()
