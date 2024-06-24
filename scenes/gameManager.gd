extends Node2D

@export var enemy_scene: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	$MobSpawnPath.position = $Player/Camera.global_position
	


func _on_spawn_timer_timeout():
	var enemy = enemy_scene.instantiate()
	var enemy_spawn_location = $MobSpawnPath/MobSpawnLocation
	enemy_spawn_location.progress_ratio = randf()
	
	enemy.position = enemy_spawn_location.position
	
	add_child(enemy)
