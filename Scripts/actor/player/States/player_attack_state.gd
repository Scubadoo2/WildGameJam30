extends State


var actor: KinematicBody2D
var animation: AnimatedSprite
var debug_info: Label

var attacking: bool = false

func enter():
	actor.animation_tree.set("parameters/Attack/blend_position", actor.direction)
	actor.animation_mode.travel("Attack")
	debug_info.text = "Attack"
	attacking = true
	# Play attack animation
	
func exit():
	attacking = false
	
#func handle_input(event: InputEvent):
#	if event.is_action_pressed("attack"):
#		if actor.can_attack() and cool_down_finished():
#			attack()
	
func tick(delta):
	if attacking == false:
		return "Idle"

	
func setup_state():
	actor = get_owner()
	animation = get_owner().get_node("AnimatedSprite")
	debug_info = get_owner().get_node("DebugState")

func attack():
	print_debug("Attack!!!!")
	
func cool_down_finished() -> bool:
	return !attacking

func finished_attack():
	print_debug("finished attacking")
	attacking = false
