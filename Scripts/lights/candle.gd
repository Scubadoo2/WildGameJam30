extends StaticBody2D
class_name Candle

signal candle_turned_on
signal candle_turned_off

onready var light = $Light2D
onready var light_barrier = $LightBarrier

var barrier_scale = 20
var radius_barrier

var candle_on: bool = false

func _ready():
	add_to_group("candle")
	radius_barrier = light_barrier.get_node("CollisionShape2D").shape.radius
	turn_off()

func _process(delta):
	if $Timer.is_stopped() and light.energy != 0.0:
		turn_off()

func turn_on():
	$Timer.start()
	light_barrier.visible = true
	light_barrier.get_node("CollisionShape2D").disabled = false
	light.energy = 1.0
	candle_on = true
	emit_signal("candle_turned_on")
	SFXPlayer.play_sfx("sfx_light_lamp_4",SFXVolume.candle_lit_volume)
	
func turn_off():
	light_barrier.visible = false
	light_barrier.get_node("CollisionShape2D").disabled = true
	light.energy = 0
	candle_on = false
	emit_signal("candle_turned_off")


#################
##  Conditions
#################
func is_candle_on() -> bool:
	return candle_on

func _on_Area2D_body_entered(body):
	pass # Replace with function body.


func _on_LightBarrier_body_entered(body):
	if body.is_in_group("enemy"):
		print_debug("enemy near light")
		var enemy = body
		var push_towards = enemy.global_position - self.global_position
		push_towards = push_towards.normalized()
		enemy.avoid(push_towards, self,radius_barrier)
	elif body.is_in_group("player"):
		body.in_light = true


func _on_LightBarrier_body_exited(body):
	if body.is_in_group("enemy"):
		body.outside_of_light()
	elif body.is_in_group("player"):
		body.in_light = false
