tool
extends Node2D

export(float, 10, 3000) var sensor_radius = 500
export(float, 10, 1000) var radius = 10 setget set_radius
export(Color) var color = Color(0, .6, 0, .5) setget set_color
export(NodePath) var tank

func _ready():
	if tank:
		tank = get_node(tank)
	
func _draw():
	draw_circle(Vector2(), radius, color)
	
	if !Engine.editor_hint:
		draw_circle(Vector2(), 3, Color(1, 1, 0, 1))
	
func set_radius(val):
	radius = val
	if Engine.editor_hint:
		update()
		
func set_color(val):
	color = val
	if Engine.editor_hint:
		update()
