extends Node

# Set by game manager
var max_candles
var candles_on: int

var ui

signal increment_nightmares

func _ready():
	for spawner in get_children():
		spawner.spawner_data = self
		
func candle_turned_on():
	candles_on += 1
	
func candle_turned_off():
	candles_on -= 1

func num_candles_on() -> int:
	return candles_on
	
func num_candles_off() -> int:
	return max_candles - candles_on

func can_spawn_entity() -> bool:
	if ui != null:
		return !ui.IsNMLimitReached()
	else:
		printerr("Logic for Spawn manager not found")
		return true

func entity_spawned():
	emit_signal("increment_nightmares", 1)
