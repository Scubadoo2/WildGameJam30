extends State

var actor: KinematicBody2D
var animation: AnimatedSprite
var debug_info: Label
var data_holder

func enter():
	debug_info.text = "Avoid"
	
func exit():
	print_debug("Leaving avoid")
	
func handle_input(event: InputEvent):
	pass
	
func tick(delta):
	if data_holder.avoid_entity == null:
		print_debug("going idle")
		return "Movement"
	
	var distance_from_entity = actor.global_position - data_holder.avoid_entity.global_position
	if data_holder.in_light == false:
		print_debug("Movement. No longer in light")
		return "Movement"
	actor.move_and_slide(actor.forward_direction.normalized() * actor.speed)
	
func setup_state():
	actor = get_owner()
	animation = get_owner().get_node("AnimatedSprite")
	debug_info = get_owner().get_node("DebugState")
	data_holder = get_owner().get_node("DataHolder")
