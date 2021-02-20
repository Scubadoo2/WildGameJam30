extends Actor
class_name Enemy

# Direction to move towards
var forward_direction: Vector2 = random_forward()
var wander_target: Vector2 = Vector2.ZERO

# Wander params
"""
Given a circle in fron of the entity.
Move to a point on the circumference.

Change values to experiment with movement
"""
var wander_radius = 4		# Radius of circle
var wander_distance = 40	# distance away from entity
var wander_jitter = 10		# How random the position becomes

# Constants
export (float) var MIN_DISTANCE = 70
export (float) var MIN_AWAY_FROM_AVOID_DISTANCE = 2

onready var data_holder = $DataHolder

# Debug Colors
var green_color = Color(0.0, 1.0, 0.0)
var white_color = Color(1.0, 1.0, 1.0)
var red_color = Color(1.0, 0.0, 0.0)



# Debug values
var collision_ray: Vector2

# Colors
var stunned = Vector3(0.8,0.6,0.7)
var healthy = Vector3(1.0,1.0,1.0)

func _ready():
	._ready()
	add_to_group("enemy")
	# Avoid sharing material among all instances
	$AnimatedSprite.set_material($AnimatedSprite.get_material().duplicate())

func _process(delta):
	update()

func _physics_process(delta):
	if data_holder.in_light:
		lose_health(2)
	elif data_holder.in_light == false:
		healthy_eye()

func healthy_eye():
	if $AnimatedSprite.material.get_shader_param("aggression_color") != healthy:
		$AnimatedSprite.material.set_shader_param("aggression_color", healthy)

func lose_health(amount: int):
	if $LoseHealthTimer.is_stopped():
		data_holder.current_health -= amount
		if data_holder.current_health <= 0:
			self.queue_free()
		$LoseHealthTimer.start()
	if $AnimatedSprite.material.get_shader_param("aggression_color") != stunned:
		$AnimatedSprite.material.set_shader_param("aggression_color", stunned)

######################
#     Draw
######################

func _draw() -> void:
	draw_line(Vector2(0,0), (Vector2(0,0) + forward_direction.normalized()) * 60, green_color)
	#var position_infront = (wander_distance) * forward_direction.normalized()
	#draw_circle(forward_direction * wander_distance, wander_radius, white_color)
	draw_circle(to_local(wander_target(wander_target)), 10, white_color)
	draw_line(to_local(get_global_position()), to_local(get_global_position()) + collision_ray, red_color)

func get_direction() -> Vector2:
	# global target to move towards
	var new_wander_position = wander_target(wander_target)
	# direction vector
	var new_direction = to_local(new_wander_position) - to_local(get_global_position())

	return new_direction

"""
Get a random target to move towards
"""

func wander_target(p_wander_target: Vector2) -> Vector2:
	randomize()
	var random_x = rand_range(-1.0,1.0)
	var random_y = rand_range(-1.0,1.0)
	# Create a vector from previous target towards the position in a unit circle
	p_wander_target += Vector2(random_x, random_y) * wander_jitter
	# Place target in unit circle circumference
	p_wander_target = p_wander_target.normalized()
	# Have target be on circumference of circle with radius r
	p_wander_target *= wander_radius
	
	# Move target infront of player
	var target_local = p_wander_target + (forward_direction.normalized() * wander_distance)
	var target_global = to_global(target_local)
	
	return target_global
	
	#var direction = target_local - position
	
	#return direction

"""
Acquire a random vector between [-1.0,1.0]
"""
func random_forward():
	randomize()
	var rand_forward = Vector2(rand_range(-1.0,1.0), rand_range(-1.0,1.0))
	rand_forward = rand_forward.normalized()
	
	return rand_forward
	
# Called by the entities that should be avoided
func avoid(direction: Vector2, avoid_entity: Candle, radius: float):
	if $StateMachine.current_state == $StateMachine/Avoid:
		forward_direction += direction
	else:
		forward_direction = direction
		$StateMachine.change_state("Avoid")
		data_holder.in_light = true
		data_holder.avoid_entity = avoid_entity
		data_holder.current_avoid_entity_radius = radius
		print_debug("Avoiding")

#####################
##     Conditions
#####################

func outside_of_light():
	data_holder.in_light = false
	#data_holder.avoid_entity = null

func target_in_light():
	if data_holder.current_target != null:
		return data_holder.current_target.in_light()

###################
##    Aggro Zone
###################

func _on_AggroZone_body_entered(body):
	if body is Player:
		$DataHolder.current_target = body


func _on_AggroZone_body_exited(body):
	if body is Player:
		$DataHolder.current_target = null

#############
##  combat
#############
func attacked(amount: int):
	data_holder.current_health -= amount
	if data_holder.current_health <= 0:
		$StateMachine.change_state("Dead")
	else:
		$StateMachine.change_state("Stun")
