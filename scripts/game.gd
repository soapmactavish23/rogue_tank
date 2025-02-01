extends Node

var score = 0

signal score_changed

func _ready():
	pass

func add_score(val):
	score += val
	emit_signal("score_changed")
	
func set_score(val):
	print('cant write score. use function add_score')
