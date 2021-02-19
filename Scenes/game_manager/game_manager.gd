extends Node2D

export (NodePath) var player_path
export (NodePath) var ui_path
export (NodePath) var spawner_path

onready var spawner_manager = $SpawnManager
onready var candle_manager = $Candles

var player
var ui
var spawner

var max_candles = 0

func _ready():
	if player_path != "" and ui_path != "" and spawner_path != "":
		player = get_node(player_path)
		ui = get_node(ui_path)
	
		player.connect("player_attacked", ui, "TakeDamage")
		player.connect("player_heal", ui, "Heal")
		player.connect("player_dead", ui, "GetGameOver")
		player.logic = ui
		
		spawner = get_node(spawner_path)
		spawner.ui = ui
	else:
		printerr("Paths not give")
	setup_candles()

######################
## Candle Management
######################

func setup_candles():
	var candles = candle_manager.get_children()
	max_candles = maximum_candles(candles)
	spawner_manager.max_candles = max_candles
	spawner_manager.connect("increment_nightmares", ui, "IncrementNMCount")
	for c in candles:
		c.connect("candle_turned_on", self, "candle_turned_on")
		c.connect("candle_turned_off", self, "candle_turned_off")

func maximum_candles(candles: Array) -> int:
	var p_max_candles = candles.size()
	return p_max_candles

func candle_turned_on():
	spawner_manager.candle_turned_on()
	ui.IncrementCandleCount(1)
	
func candle_turned_off():
	spawner_manager.candle_turned_off()
	ui.IncrementCandleCount(-1)
