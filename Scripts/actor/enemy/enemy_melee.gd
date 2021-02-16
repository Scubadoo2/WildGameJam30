extends Actor

# Direction to move towards
var forward_direction: Vector2 = random_forward()

# Wander params
var wander_radius = 10
var wander_distance = 10
var wander_jitter = 1

# Constants
export (float) var MIN_DISTANCE = 2

onready var data_holder = $DataHolder



func get_direction() -> Vector2:
	forward_direction = wander_direction(forward_direction)

	return forward_direction

"""
Get a random direction to move towards
"""
func wander_direction(wander_target: Vector2) -> Vector2:
	randomize()
	var random_x = rand_range(-1.0,1.0)
	var random_y = rand_range(-1.0,1.0)
	wander_target += Vector2(random_x, random_y) * wander_jitter
	wander_target = wander_target.normalized()		# Plcae target in unit circle circumference
	wander_target *= wander_radius		# Have target be on circumference of circle with radius r
	
	var target_local = wander_target + position	# Move target infron of player
	
	var direction = target_local - position
	
	return direction

func random_forward():
	randomize()
	var rand_forward = Vector2(rand_range(-1.0,1.0), rand_range(-1.0,1.0))
	rand_forward = rand_forward.normalized()
	
	return rand_forward

func _on_AggroZone_body_entered(body):
	if body is Player:
		$DataHolder.current_target = body


func _on_AggroZone_body_exited(body):
	if body is Player:
		$DataHolder.current_target = null
