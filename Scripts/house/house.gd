extends Node2D

onready var spawner_manager = $Spawners
onready var candle_manager = $Candles

var max_candles: int

# Called when the node enters the scene tree for the first time.
func _ready():
	max_candles = maximum_candles(candle_manager.get_children())
	spawner_manager.max_candles = max_candles
	setup_candles(candle_manager.get_children())
	spawner_manager.max_candles = max_candles
	
	
func maximum_candles(candles: Array) -> int:
	var p_max_candles = candles.size()
	return p_max_candles

func setup_candles(candles: Array):
	for c in candles:
		c.connect("candle_turned_on", self, "candle_turned_on")
		c.connect("candle_turned_off", self, "candle_turned_off")
	
func candle_turned_on():
	spawner_manager.candle_turned_on()
	
func candle_turned_off():
	spawner_manager.candle_turned_off()
