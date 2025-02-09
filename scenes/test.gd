extends Node


func _ready():
	randomize()
	$home_missel.target = $Tank
