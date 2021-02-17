extends Node
class_name StateMachine

var states = {}		# states available
var current_state: State

func _ready():
	for x in get_children():
		states[x.name] = x

""" 
Have states get their data.
"""
func setup_states():
	for x in get_children():
		x.setup_state()

func change_state(state: String) -> void:
	if current_state != null:
		current_state.exit()
	if !states.has(state):
		printerr("State does not exist")
	else:
		current_state = states[state]
		current_state.enter()

func tick(delta):
	var next_state = current_state.tick(delta)
	if next_state != null:
		change_state(next_state)
		
func handle_input(event):
	if current_state != null:
		current_state.handle_input(event)
