extends Node

var score = 0

func _ready():
	pass

func add_score(val):
	score += val
	print(score)
	
func set_score(val):
	print('cant write score. use function add_score')
