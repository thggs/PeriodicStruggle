extends Node

@onready var bar : ProgressBar = $ProgressBar

func change_value(value : int):
	bar.value = value
	$AnimationPlayer.stop()
	$AnimationPlayer.play("hit")
