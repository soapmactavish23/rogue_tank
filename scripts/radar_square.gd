extends ColorRect

export var area_size = Vector2()

var rate

func _ready():
	rate = get_rect().size / area_size


func _draw():
	for re in get_tree().get_nodes_in_group("radar_entity"):
		print(re)

func _on_timer_update_timeout():
	update()
