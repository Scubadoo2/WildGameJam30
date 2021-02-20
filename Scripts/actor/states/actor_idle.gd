extends State

var actor: KinematicBody2D
var animation: AnimatedSprite
var debug_info: Label
var animation_mode
var debug_mode: bool

func enter():
	#animation.play("idle")
	animation_mode.travel("Idle")
	if debug_mode:
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
	animation_mode = get_owner().get_node("AnimationTree").get("parameters/playback")
	debug_mode = get_owner().DEBUG
