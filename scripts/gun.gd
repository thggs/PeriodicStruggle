extends Node2D

@onready var point = get_node("Point")

@export var obj_bullet: PackedScene

@onready var bullets = []

func is_empty():	
	return bullets.is_empty()

func shoot(speed : float = 100):
	var new_bullet = obj_bullet.instantiate()
	var dir = (point.global_position - global_position)
	
	new_bullet.velocity = dir.normalized() * speed	
	new_bullet.position = point.global_position
		
		
	var rmv_array = func(): bullets.erase(new_bullet)	
	new_bullet.bullet_death.connect(rmv_array)
	bullets.append(new_bullet)
		
	add_child(new_bullet)

