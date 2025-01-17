extends StaticBody2D

const PRE_FRAGMENTS = preload("res://scenes/fragments/crate_box_fragments.tscn")

func _ready():
	$area_obastacle.connect("hitted", self, "on_area_hitted")
	$area_obastacle.connect("destroid", self, "on_area_destroid")
	pass
	
func on_area_hitted(damage, health, node):
	if damage > 5:
		$anim.play("big_hit")
	else:
		$anim.play("small_hit")

func on_area_destroid():
	var fragments = PRE_FRAGMENTS.instance()
	fragments.global_position = global_position
	get_parent().add_child(fragments)
	queue_free()
