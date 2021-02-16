extends State

var actor: KinematicBody2D
var animation: AnimatedSprite
var debug_info: Label
var data_holder

func enter():
	debug_info.text = "Movement"
	
func exit():
	pass
	
func handle_input(event: InputEvent):
	pass
	
func tick(delta):
	if data_holder.current_target != null:
		return "Aggro"

	actor.direction = actor.get_direction()
	if actor.direction == Vector2.ZERO:
		return "Idle"
	move(delta)
	
	
func setup_state():
	actor = get_owner()
	animation = get_owner().get_node("AnimatedSprite")
	debug_info = get_owner().get_node("DebugState")
	data_holder = get_owner().get_node("DataHolder")

func move(delta):
	actor.move_and_slide(actor.direction.normalized() * actor.speed)
