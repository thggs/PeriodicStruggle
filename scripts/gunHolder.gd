extends Node2D


@onready var guns = get_children()

func is_empty():
	var empty = true
	
	for g in guns:
		if !g.is_empty():
			empty = false
			break
	
	return empty


func shoot(speed : float = 100):
	for g in guns:
		g.shoot(speed)
