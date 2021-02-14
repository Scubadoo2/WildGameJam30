extends State

var actor: KinematicBody2D
var animation: AnimatedSprite
var debug_info: Label

func enter():
	animation.play("move")
	debug_info.text = "Movement"
	
func exit():
	pass
	
func handle_input(event):
	pass
	
func tick(delta):
	if actor.direction == Vector2.ZERO:
		return "Idle"
	move(delta)
	
func setup_state():
	actor = get_owner()
	animation = get_owner().get_node("AnimatedSprite")
	debug_info = get_owner().get_node("DebugState")

func move(delta):
	actor.move_and_slide(actor.direction.normalized() * actor.speed)
