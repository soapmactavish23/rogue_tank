extends Area2D


func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass


func _on_coin_body_entered( body ):
	$fx.play()
	$sprite.visible = false;
	collision_mask = 0
	$queue_timer.start()
	$particles.emitting = true
	pass # replace with function body


func _on_timer_timeout():
	queue_free()
