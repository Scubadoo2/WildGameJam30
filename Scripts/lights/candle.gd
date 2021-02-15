extends StaticBody2D
class_name Candle

onready var light = $Light2D
onready var light_barrier = $LightBarrier

var barrier_scale = 20

func _ready():
	light.energy = 0

func _process(delta):
	if $Timer.is_stopped() and light.energy != 0.0:
		turn_off()

func turn_on():
	$Timer.start()
	light_barrier.visible = true
	light.energy = 1.0
	
func turn_off():
	light_barrier.visible = false
	light.energy = 0


func _on_Area2D_body_entered(body):
	pass # Replace with function body.
