extends StaticBody2D
class_name HealingStation

#### TODO:
## Refactor the entering of light's effect zone
## Candles as well

signal healed(amount)

export (int) var uses = 2

onready var fire_effect_timer = $FireEffectTimer

# Condition
var fireplace_on = false

var fire_effect: bool = false
var fire_effect_energy = 1.31

func _ready():
	add_to_group("healing_station")
	update_status(uses)
	fire_effect_timer.connect("timeout", self, "turn_off_effect")
	turn_off_effect()

##############
##   Healing
##############

func use_heal() -> void:
	if fireplace_on == false:
		emit_signal("healed", 1)
		SFXPlayer.play_sfx("sfx_fire_place_1", SFXVolume.fireplace_volume)
		if uses > 0:
			turn_on_effect()
		decrement_uses(1)
	#update_status(uses)
		
	
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
	
func update_status(p_uses: int):
	if p_uses <= 0:
		$AnimatedSprite.play("off")
		$Light2D.energy = 0.0
	else:
		$AnimatedSprite.play("on")
		

#######################
##  General functions
#######################
func update_uses(amount):
	uses += amount

#####################
## Fireplace Effect
#####################

func turn_on_effect():
	$EffectZone/CollisionShape2D.disabled = false
	$FireEffectLight.energy = fire_effect_energy
	$FireEffectTimer.start()
	fireplace_on = true

func turn_off_effect():
	print_debug("Turnoff")
	$EffectZone/CollisionShape2D.disabled = true
	$FireEffectLight.energy = 0
	if uses <= 0:
		$AnimatedSprite.play("off")
		$Light2D.energy = 0
	fireplace_on = false


func _on_EffectZone_body_entered(body):
	if body.is_in_group("enemy"):
		var enemy = body
		# Push towards opposite direction
		var push_towards = enemy.global_position - self.global_position
		push_towards = push_towards.normalized()
		var barrier_zone = $EffectZone/CollisionShape2D.shape.height
		enemy.avoid(push_towards, self,barrier_zone)
	elif body.is_in_group("player"):
		body.in_light = true



func _on_EffectZone_body_exited(body):
	if body.is_in_group("enemy"):
		body.outside_of_light()
	elif body.is_in_group("player"):
		body.in_light = false
