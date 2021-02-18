extends Control

#Quick Reference
var heartBeat
var hp
var stress
onready var gameOverText = $GameOver
onready var musicHolder = $MusicHolder
onready var itemTracker = $ItemTracker

#Custom variables
var maxHP = 3
export (int) var maxStress = 3
export var beatForgivness = .2

var gameOver = false

signal GameOver(how)


# Called when the node enters the scene tree for the first time.
func _ready():
	hp = $HP
	stress = $Stress
	heartBeat = $BeatHolder
	
	maxHP = heartBeat.GetTrackAmount()
	heartBeat.forgive = beatForgivness
	
	hp.ChangeMaxHP(maxHP)
	stress.ChangeMaxStress(maxStress)

###################################################

#Helper functions meant to be used outside the UI

###################################################



func TakeDamage(amount):
	if gameOver: return
	hp.ChangeHP(amount * -1)
	heartBeat.ChangeBeat(hp.hp)
	
func Heal(amount):
	if gameOver: return
	hp.ChangeHP(amount)
	heartBeat.ChangeBeat(hp.hp)

func GiveStress(amount):
	if gameOver: return
	stress.ChangeStress(amount)
	
func CalmDown(amount):
	if gameOver: return
	stress.ChangeStress(amount * -1)
	
func IsInBeat() -> bool:
	if gameOver: return false
	return heartBeat.IsInBeat()
	
func GetItem(item, amount) -> bool:
	if gameOver: return false
	return itemTracker.GetItem(item, amount)
	
func UseItem(item, amount) -> bool:
	if gameOver: return false
	return itemTracker.UseItem(item, amount)
	
func IsGameOver() -> bool:
	return gameOver
	
	
###################################################

# Functions meant to just be used for the UI

###################################################

func GetGameOver(how):
	emit_signal("GameOver", how)
	gameOver = true
	
	var descHolder
	match how:
		"hp":
			descHolder = "The nightmares overtaken you"
		"stress":
			descHolder = "The nightmares got to the kid"
			
	gameOverText.find_node("Description").text = descHolder
	gameOverText.set_visible(true)
