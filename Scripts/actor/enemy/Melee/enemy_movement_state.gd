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
		if data_holder.avoid_entity == null:
			return "Aggro"
		elif actor.target_in_light() == false:
			print_debug("Target not in light")
			return "Aggro"
			
	# Begin movement behaviour
	## Wall collision
	var space_state = actor.get_world_2d().direct_space_state
	# Local collision ray
	actor.collision_ray = actor.forward_direction.normalized() 
	actor.collision_ray *= 100
	
	var collision_avoidance_direction = front_collision(space_state, actor.collision_ray, actor)
	if collision_avoidance_direction != Vector2.ZERO:
		actor.forward_direction = collision_avoidance_direction
	
	var result = space_state.intersect_ray(actor.get_global_position(), 
		actor.get_global_position() + actor.collision_ray,
		[actor], actor.collision_mask)
	if result:
		print_debug(result)
		if result.collider:
			actor.forward_direction = -actor.forward_direction
	
	## Move around
	actor.direction = actor.get_direction()
	if actor.direction == Vector2.ZERO:
		return "Idle"
	actor.forward_direction = actor.direction
	move(delta)

func front_collision(space_state: Physics2DDirectSpaceState, collision_ray: Vector2, p_actor: KinematicBody2D) -> Vector2:
	var result = space_state.intersect_ray(p_actor.get_global_position(), 
	p_actor.get_global_position() + p_actor.collision_ray,
	[p_actor], p_actor.collision_mask)
	if result:
		if result.collider:
			var reflected_ray = collision_ray.bounce(result.normal)
			# Point towards bounce direction
			var new_direction = collision_ray + reflected_ray
			actor.forward_direction = -new_direction.normalized()
	
	return Vector2.ZERO

func setup_state():
	actor = get_owner()
	animation = get_owner().get_node("AnimatedSprite")
	debug_info = get_owner().get_node("DebugState")
	data_holder = get_owner().get_node("DataHolder")

func move(delta):
	actor.move_and_slide(actor.forward_direction.normalized() * actor.speed)
