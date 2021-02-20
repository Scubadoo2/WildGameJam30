extends State

var actor: KinematicBody2D
var animation: AnimatedSprite
var debug_info: Label
var data_holder
var debug_mode: bool

func enter():
	if debug_mode:
		debug_info.text = "Dead"
	actor.queue_free()
	
func exit():
	print_debug("Goodbye, world!")
	
func handle_input(event: InputEvent):
	pass
	
func tick(delta):
	pass
	
func setup_state():
	actor = get_owner()
	animation = get_owner().get_node("AnimatedSprite")
	debug_info = get_owner().get_node("DebugState")
	data_holder = get_owner().get_node("DataHolder")
	debug_mode = get_owner().DEBUG
