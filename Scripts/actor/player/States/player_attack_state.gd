extends State


var actor: KinematicBody2D
var animation: AnimatedSprite
var debug_info: Label

func enter():
	debug_info.text = "Attack"
	attack()
	# Play attack animation
	
func exit():
	pass
	
func handle_input(event: InputEvent):
	if event.is_action_pressed("attack"):
		if actor.can_attack() and cool_down_finished():
			attack()
	
func tick(delta):
	if cool_down_finished():
		return "Idle"

	
func setup_state():
	actor = get_owner()
	animation = get_owner().get_node("AnimatedSprite")
	debug_info = get_owner().get_node("DebugState")

func attack():
	print_debug("Attack!!!!")
	
func cool_down_finished() -> bool:
	return true
