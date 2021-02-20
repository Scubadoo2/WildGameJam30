extends State

var actor: KinematicBody2D
var animation: AnimatedSprite
var debug_info: Label
var data_holder
var debug_mode: bool

export (float) var stun_time = 1.0

# Agression Colors
var not_aggresive = Vector3(1.0,1.0,1.0)
var aggresive = Vector3(0.8,0.6,0.7)

func enter():
	if debug_mode:
		debug_info.text = "Stun"
	$Timer.start(stun_time)
	# Change shader value
	animation.material.set_shader_param("aggression_color", aggresive)
	
func exit():
	animation.material.set_shader_param("aggression_color", not_aggresive)
	
func handle_input(event: InputEvent):
	pass
	
func tick(delta):
	if $Timer.is_stopped():
		return "Idle"
	
func setup_state():
	actor = get_owner()
	animation = get_owner().get_node("AnimatedSprite")
	debug_info = get_owner().get_node("DebugState")
	data_holder = get_owner().get_node("DataHolder")
	debug_mode = get_owner().DEBUG
