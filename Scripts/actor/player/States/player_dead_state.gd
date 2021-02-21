extends State


var actor: KinematicBody2D
var animation: AnimatedSprite
var debug_info: Label
var debug_mode: bool

func enter():
	if actor.is_dead == false:
		SFXPlayer.play_sfx("sfx_flick_death", SFXVolume.default)
		actor.is_dead = true
	if debug_mode:
		debug_info.text = "Dead"
	
func exit():
	pass
	
func handle_input(event: InputEvent):
	pass
	
func tick(delta):
	pass
	
func setup_state():
	actor = get_owner()
	animation = get_owner().get_node("AnimatedSprite")
	debug_info = get_owner().get_node("DebugState")
	debug_mode = get_owner().DEBUG
