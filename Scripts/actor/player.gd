extends Actor
class_name Player

onready var data_holder = $DataHolder
var in_light: bool

# 
var logic
var is_dead: bool = false

# animation
onready var animation_tree = $AnimationTree
onready var animation_mode = animation_tree.get("parameters/playback")
onready var animation_player = $AnimationPlayer

# signals
signal player_attacked(amount)
signal player_heal(amount)
signal player_dead(how)

# help tell direction it is facing
var forward_vector =  Vector2.ZERO

#debug
var DEBUG = 0

func _ready():
	._ready()
	in_light = false
	is_dead = false
	add_to_group("player")

func _input(event):
	if Input.is_action_just_pressed("interact"):
		if data_holder.near_candle:
			data_holder.near_candle.turn_on()
		elif data_holder.near_healing_station:
			if data_holder.near_healing_station.can_heal():
				data_holder.near_healing_station.use_heal()
				emit_signal("player_heal", 1)
	if Input.is_action_just_pressed("attack"):
		if $StateMachine.current_state != $StateMachine/Attack:
			if can_attack():
				
				$StateMachine.change_state("Attack")
		else:
			$StateMachine.current_state.handle_input(event)

func get_direction() -> Vector2:
	var direction = Vector2.ZERO
	if Input.is_action_pressed("forward"):
		direction.y -= 1
	if Input.is_action_pressed("backward"):
		direction.y += 1
	if Input.is_action_pressed("left"):
		direction.x -= 1
	if Input.is_action_pressed("right"):
		direction.x += 1

	return direction

func in_light() -> bool:
	return in_light

#########################
##  World Interaction  ##
#########################


##########
# Candles & Healing Stations
##########
func _on_Area2D_body_entered(body):
	if body.is_in_group("candle"):
		data_holder.near_candle = body
	elif body.is_in_group("healing_station"):
		data_holder.near_healing_station = body


func _on_Area2D_body_exited(body):
	if body.is_in_group("candle"):
		data_holder.near_candle = null
	elif body.is_in_group("healing_station"):
		data_holder.near_healing_station = null

#########
# Combat 
#########

func attacked(dmg_amount):
	print_debug("Attacked")
	emit_signal("player_attacked", dmg_amount)
	if logic != null:
		if logic.IsGameOver():
			die()
		else:
			SFXPlayer.play_sfx("sfx_flick_take_hit_1", SFXVolume.flick_receive_dmg_volume)
	else:
		SFXPlayer.play_sfx("sfx_flick_take_hit_1", SFXVolume.flick_receive_dmg_volume)

func heal(hl_amount):
	emit_signal("player_heal", hl_amount)

func can_attack() -> bool:
	if logic != null:
		if logic.IsInBeat():
			return true
		else:
			return false
	else:
		print_debug("No logic for attacking")
		return true

############
# Game Over
############

func die():
	emit_signal("player_dead", "hp")
	$StateMachine.change_state("Dead")

######################
## Attack Damage Zone
######################

func _on_AttackZone_body_entered(body):
	if body.is_in_group("enemy"):
		body.attacked(4)
