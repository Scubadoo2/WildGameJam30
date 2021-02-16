extends State

var actor: KinematicBody2D
var animation: AnimatedSprite
var debug_info: Label

func enter():
	animation.play("idle")
	debug_info.text = "Idle"
	
func exit():
	pass
	
func handle_input(event: InputEvent):
	pass
	
func tick(delta):
	actor.direction = actor.get_direction()
	if actor.direction != Vector2.ZERO:
		return "Movement"

	
func setup_state():
	actor = get_owner()
	animation = get_owner().get_node("AnimatedSprite")
	debug_info = get_owner().get_node("DebugState")
