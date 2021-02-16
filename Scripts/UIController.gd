extends Control

#Quick Reference
var heartBeat
var hp
var stress
onready var gameOverText = $GameOver

#Custom variables
export (int) var maxHP = 3
export (int) var maxStress = 3

export (PoolRealArray) var musicSpeed = [.01, .05, .75, 1.0]

signal GameOver(how)


# Called when the node enters the scene tree for the first time.
func _ready():
	hp = $HP
	stress = $Stress
	heartBeat = $BeatHolder
	
	hp.ChangeMaxHP(maxHP)
	stress.ChangeMaxStress(maxStress)
	heartBeat.ChangeBeat(musicSpeed[hp.hp])

###################################################

#Helper functions meant to be used outside the UI

###################################################

func TakeDamage(amount):
	hp.ChangeHP(amount * -1)
	heartBeat.ChangeBeat(musicSpeed[hp.hp])
	
func Heal(amount):
	hp.ChangeHP(amount)
	heartBeat.ChangeBeat(musicSpeed[hp.hp])

func GiveStress(amount):
	stress.ChangeStress(amount)
	
func CalmDown(amount):
	stress.ChangeStress(amount * -1)
	
func IsInBeat() -> bool:
	return heartBeat.IsInBeat()
	
###################################################

# Functions meant to just be used for the UI

###################################################

func GetGameOver(how):
	emit_signal("GameOver", how)
	
	var descHolder
	match how:
		"hp":
			descHolder = "The nightmares overtaken you"
		"stress":
			descHolder = "The nightmares got to the kid"
			
	gameOverText.find_node("Description").text = descHolder
	gameOverText.set_visible(true)
