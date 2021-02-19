extends Node

var current_target: KinematicBody2D = null
# Candle
var avoid_entity: Node2D
var current_avoid_entity_radius = 0.0
# params
var in_light: bool = false

# Health
var max_health = 10
var current_health = max_health
