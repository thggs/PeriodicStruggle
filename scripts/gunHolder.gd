extends Node2D

@export var obj_bullet: PackedScene

@onready var guns = get_children()
@onready var scene = get_tree().root.get_child(0)

# TODO: Add bullet_lifetime to customize bullet time on screen
func _on_shoot(speed : float = 100, duration : float = 5):
	for gun in guns:
		var new_bullet = obj_bullet.instantiate()
		var dir = Vector2.from_angle(gun.global_rotation)
		
		new_bullet.duration = duration
		new_bullet.velocity = dir.normalized() * speed
		new_bullet.position = gun.global_position
		new_bullet.rotation = gun.global_rotation
		
		scene.add_child(new_bullet)
