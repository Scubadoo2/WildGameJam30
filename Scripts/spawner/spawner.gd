extends Node2D

export (Array, PackedScene) var entities
export (float) var max_time: float = 5.0
export (float) var min_time: float = 1.0

onready var spawn_timer = $Timer

var spawner_data

func _ready():
	#spawn_entity(entities)
	spawn_timer.start(max_time)
	print_debug("Starting spawner")

func _physics_process(delta):
	if spawn_timer.is_stopped() && spawner_data.can_spawn_entity():
		spawn_entity(entities)
		var new_time = get_next_time(max_time, min_time, spawner_data.num_candles_off(), spawner_data.max_candles)
		spawn_timer.start(new_time)
		spawner_data.entity_spawned()
	elif spawn_timer.is_stopped():
		var new_time = get_next_time(max_time, min_time, spawner_data.num_candles_off(), spawner_data.max_candles)
		spawn_timer.start(new_time)
		
func spawn_entity(p_entities: Array) -> void:
	randomize()
	var index_entity = randi() % p_entities.size()
	var entity_packed: PackedScene = p_entities[index_entity]
	var entity = entity_packed.instance()
	entity.global_position = self.global_position
	get_owner().call_deferred("add_child", entity)
	
func get_next_time(t_max: float, t_min: float, candles_on: int, candles_max: int) -> float:
	var perc_candles = float(candles_on) / float(candles_max)
	var t_range = t_max - t_min
	
	var t_time = t_range * perc_candles
	# Away from max_value
	t_time = t_max - t_time
	
	return t_time
