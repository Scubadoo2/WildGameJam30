extends State

var actor: KinematicBody2D
var animation: AnimatedSprite
var debug_info: Label

func enter():
	actor.animation_mode.travel("Walking")
	debug_info.text = "Movement"
	
func exit():
	pass
	
func handle_input(event):
	pass
	
func tick(delta):
	actor.direction = actor.get_direction()
	actor.animation_tree.set("parameters/Walking/blend_position", actor.direction)
	if actor.direction == Vector2.ZERO:
		return "Idle"
	move(delta)
	
func setup_state():
	actor = get_owner()
	animation = get_owner().get_node("AnimatedSprite")
	debug_info = get_owner().get_node("DebugState")

func move(delta):
	actor.animation_mode.travel("Walking")
	actor.move_and_slide(actor.direction.normalized() * actor.speed)
