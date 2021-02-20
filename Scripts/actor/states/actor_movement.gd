extends State

var actor: KinematicBody2D
var animation: AnimatedSprite
var debug_info: Label
var debug_mode: bool

export (bool) var enable_footstep: bool = false
export (float) var footstep_freq = 0.9
# footsteps
var left_step: bool
var right_step: bool

func enter():
	actor.animation_mode.travel("Walking")
	if debug_mode:
		debug_info.text = "Movement"
	
func exit():
	$Timer.stop()
	
func handle_input(event):
	pass
	
func tick(delta):
	actor.direction = actor.get_direction()
	actor.animation_tree.set("parameters/Walking/blend_position", actor.direction)
	actor.animation_tree.set("parameters/Idle/blend_position", actor.forward_vector)
	if actor.direction == Vector2.ZERO:
		return "Idle"
	footsteps()
	move(delta)
	
func setup_state():
	actor = get_owner()
	animation = get_owner().get_node("AnimatedSprite")
	debug_info = get_owner().get_node("DebugState")
	debug_mode = get_owner().DEBUG

func move(delta):
	actor.animation_mode.travel("Walking")
	actor.forward_vector = actor.direction.normalized()
	actor.move_and_slide(actor.direction.normalized() * actor.speed)

func footsteps():
	if enable_footstep:
		# Begin footsteps
		if left_step == false and right_step == false:
			$Timer.start(footstep_freq)
			left_step = true
		# Begin right step
		elif left_step and $Timer.is_stopped():
			left_step = false
			right_step = true
			$Timer.start(footstep_freq)
		# Begin left step
		elif right_step and $Timer.is_stopped():
			right_step = false
			left_step = true
			$Timer.start(footstep_freq)
