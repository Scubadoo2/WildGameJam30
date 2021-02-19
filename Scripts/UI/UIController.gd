extends Control

#Quick Reference
var heartBeat
var hp
var clock
#var stress
var nightmares
onready var gameOverText = $GameOver
onready var winText = $Win
onready var itemTracker = $ItemTracker
onready var candleCount = $CandleCount

#Custom variables
var maxHP = 3
#export (int) var maxStress = 3
export (int) var maxNightmares = 100
export (float) var beatForgivness = .2

export (int) var startHour = 23
export (int) var startMinute = 00
export (int) var endHour = 7
export (int) var endMinute = 00
export (float) var hourLength = 20.0

var gameOver = false
var isWin = false

#Signals
signal Win()
signal GameOver(how)


# Called when the node enters the scene tree for the first time.
func _ready():
	hp = $HP
	#stress = $Stress
	heartBeat = $BeatHolder
	nightmares = $NMTracker
	clock = $Clock
	
	clock.StartClock(startHour, startMinute, endHour, endMinute, hourLength)
	
	maxHP = heartBeat.GetTrackAmount()
	heartBeat.forgive = beatForgivness
	
	hp.ChangeMaxHP(maxHP)
	#stress.ChangeMaxStress(maxStress)
	nightmares.SetMax(maxNightmares)
	

###################################################

#Helper functions meant to be used outside the UI

###################################################


#Health tracker
#Send in the amount hit/healed
func TakeDamage(amount):
	if gameOver: return
	hp.ChangeHP(amount * -1)
	heartBeat.ChangeBeat(hp.hp)
	
func Heal(amount):
	if gameOver: return
	hp.ChangeHP(amount)
	heartBeat.ChangeBeat(hp.hp)



#Nightmare and Candle tracker
#Send in the total amount
#NOT the amount changed
func SetNMCount(newAmount):
	if gameOver: return
	nightmares.SetCount(newAmount)

# Carto addition
func IsNMLimitReached() -> bool:
	if gameOver: return true
	return nightmares.ReachedMax()

func IncrementNMCount(amount):
	var new_count = nightmares.count + amount
	SetNMCount(new_count)

## -- ##
func SetCandleCount(newAmount):
	if gameOver: return
	candleCount.ChangeCount(newAmount)

# Carto Addition
func IncrementCandleCount(amount):
	var new_count = candleCount.count + amount
	SetCandleCount(new_count)
## -- ##

func IsInBeat() -> bool:
	if gameOver: return false
	return heartBeat.IsInBeat()
	
	
	
#Item trackers
#Send in the amount changed
#This will be your inventory
func GetItem(item, amount) -> bool:
	if gameOver: return false
	return itemTracker.GetItem(item, amount)
	
func UseItem(item, amount) -> bool:
	if gameOver: return false
	return itemTracker.UseItem(item, amount)
	
	
	
	
func GetRemainingMinutes():
	return clock.MinutesLeft()
	
	
	

func IsGameOver() -> bool:
	return gameOver
	
func IsWin() -> bool:
	return isWin
	
	
	
	
	
"""
func GiveStress(amount):
	if gameOver: return
	stress.ChangeStress(amount)
	
func CalmDown(amount):
	if gameOver: return
	stress.ChangeStress(amount * -1)
"""
	
	
###################################################

# Functions meant to just be used for the UI

###################################################

func GetWin():
	emit_signal("Win")
	emit_signal("GameOver", "win")
	isWin = true
	gameOver = true
	winText.set_visible(true)

func GetGameOver(how):
	emit_signal("GameOver", how)
	gameOver = true
	
	var descHolder
	match how:
		"hp":
			descHolder = "The nightmares overtaken you"
		"nightmares":
			descHolder = "The nightmares have swarmed the house"
			
	gameOverText.find_node("Description").text = descHolder
	gameOverText.set_visible(true)
