extends Actor
class_name Player

onready var data_holder = $DataHolder

func _input(event):
	if Input.is_action_just_pressed("interact"):
		if data_holder.near_candle:
			data_holder.near_candle.turn_on()

func get_direction() -> Vector2:
	var direction = Vector2.ZERO
	if Input.is_action_pressed("forward"):
		direction.y -= 1
	if Input.is_action_pressed("backward"):
		direction.y += 1
	if Input.is_action_pressed("left"):
		direction.x -= 1
	if Input.is_action_pressed("right"):
		direction.x += 1

	return direction


func _on_Area2D_body_entered(body):
	if body is Candle:
		data_holder.near_candle = body


func _on_Area2D_body_exited(body):
	if body is Candle:
		data_holder.near_candle = null
