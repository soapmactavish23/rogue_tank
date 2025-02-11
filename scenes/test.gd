extends Node

func _ready():
	$HUD/over.hide()
	randomize()

func _process(delta):
	if !$Tank/damage_area:
		$HUD/over.show()
