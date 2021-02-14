extends KinematicBody2D
class_name Actor

export (float) var speed

"""
Base class for all moving actors in game.
DO NOT use this node alone. Best to inherit it.
"""


# params
onready var state_machine: StateMachine = $StateMachine

# movement
var direction: Vector2 = Vector2.ZERO

func _ready():
	state_machine.setup_states()
	state_machine.change_state("Idle")

func _input(event):
	state_machine.handle_input(event)

func _physics_process(delta):
	state_machine.tick(delta)
	direction = get_direction()

"""
Each actor will fill the method to decied which direction to go towards.
"""
func get_direction() -> Vector2:
	return Vector2.ZERO
