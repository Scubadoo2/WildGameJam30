extends StaticBody2D
class_name HealingStation

signal healed(amount)

export (int) var uses = 1

func _ready():
	add_to_group("healing_station")
	update_animation(uses)

##############
##   Healing
##############

func use_heal() -> void:
	emit_signal("healed", 1)
	SFXPlayer.play_sfx("sfx_fire_place_1", SFXVolume.fireplace_volume)
	increment_uses(1)
	update_animation(uses)
	
func can_heal() -> bool:
	if uses > 0:
		return true
	else:
		return false

#######################
##  Private functions
#######################
	
func increment_uses(amount):
	uses += abs(amount)
	
func decrement_uses(amount):
	uses += abs(amount) * -1
	if uses < 0:
		uses = 0
	
func update_animation(p_uses: int):
	if p_uses <= 0:
		$AnimatedSprite.play("off")
	else:
		$AnimatedSprite.play("on")

#######################
##  General functions
#######################
func update_uses(amount):
	uses += amount
