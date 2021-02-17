extends Actor
class_name Player

onready var data_holder = $DataHolder
var in_light: bool

# signals
signal player_attacked(amount)
signal player_heal(amount)

func _ready():
	._ready()
	in_light = false
	add_to_group("player")

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

func in_light() -> bool:
	return in_light()

#########################
##  World Interaction  ##
#########################


##########
# Candles
##########
func _on_Area2D_body_entered(body):
	if body.is_in_group("candle"):
		data_holder.near_candle = body


func _on_Area2D_body_exited(body):
	if body.is_in_group("candle"):
		data_holder.near_candle = null

#########
# Combat 
#########

func attacked(dmg_amount):
	print_debug("Attacked")
	emit_signal("player_attacked", dmg_amount)

func heal(hl_amount):
	emit_signal("player_heal", hl_amount)
