extends StaticBody2D

func _ready():
	$area_obastacle.connect("hitted", self, "on_area_hitted")
	$area_obastacle.connect("destroid", self, "on_area_destroid")
	pass
	
func on_area_hitted(damage, health, node):
	pass

func on_area_destroid():
	queue_free()