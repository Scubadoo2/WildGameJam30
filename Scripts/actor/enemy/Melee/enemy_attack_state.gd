extends State

var actor: KinematicBody2D
var animation: AnimatedSprite
var debug_info: Label
var data_holder

func enter():
	debug_info.text = "Attack"
	
func exit():
	pass
	
func handle_input(event: InputEvent):
	pass
	
func tick(delta):
	# distance between enemy and target
	var vector_target = data_holder.current_target.global_position - actor.global_position
	if vector_target.length() > actor.MIN_DISTANCE:
		return "Aggro"
	attack()
	
func setup_state():
	actor = get_owner()
	animation = get_owner().get_node("AnimatedSprite")
	debug_info = get_owner().get_node("DebugState")
	data_holder = get_owner().get_node("DataHolder")

func attack():
	print_debug("Attacking")
	pass
