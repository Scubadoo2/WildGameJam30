extends State

var actor: KinematicBody2D
var animation: AnimatedSprite
var debug_info: Label
var data_holder
var debug_mode

func enter():
	if debug_mode:
		debug_info.text = "Attack"
	attack(data_holder.current_target)
	
func exit():
	pass
	
func handle_input(event: InputEvent):
	pass
	
func tick(delta):
	if $CoolDown.is_stopped():
		return "Aggro"
	# distance between enemy and target
	var vector_target = data_holder.current_target.global_position - actor.global_position
	if vector_target.length() > actor.MIN_DISTANCE:
		return "Aggro"
	attack(data_holder.current_target)
	
func setup_state():
	actor = get_owner()
	animation = get_owner().get_node("AnimatedSprite")
	debug_info = get_owner().get_node("DebugState")
	data_holder = get_owner().get_node("DataHolder")
	debug_mode = get_owner().DEBUG

func attack(target):
	if target.has_method("attacked") && $CoolDown.is_stopped():
		target.attacked(1)
		$CoolDown.start()
