extends State

var actor: KinematicBody2D
var animation: AnimatedSprite
var debug_info: Label
var data_holder

func enter():
	debug_info.text = "Aggro"
	
func exit():
	pass
	
func handle_input(event: InputEvent):
	pass
	
func tick(delta):
	if data_holder.current_target == null:
		return "Idle"
	
	# Vector to target
	var target: KinematicBody2D = data_holder.current_target
	var vector_target = target.global_position - actor.global_position
	var distance_to_target = vector_target.length()
	# Too close, attack
	if distance_to_target < actor.MIN_DISTANCE:
		return "Attack"
	
	# Move towards target
	actor.forward_direction = vector_target.normalized()
	actor.move_and_slide(actor.forward_direction * actor.speed)
	
	
func setup_state():
	actor = get_owner()
	animation = get_owner().get_node("AnimatedSprite")
	debug_info = get_owner().get_node("DebugState")
	data_holder = get_owner().get_node("DataHolder")
