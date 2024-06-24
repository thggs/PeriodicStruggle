extends Node
#class that is auto loaded and stores the data related to the player

@export var exp : int = 0 :
	get:
		return exp
	set(value):
		exp = value
		emit_signal("on_exp_change", exp)

@export var level : int = 0 :
	get:
		return level
	set(value):
		level = value
		emit_signal("on_level_change", level)

#Called when exp changes
signal on_exp_change(new_value)

#Called when level changes
signal on_level_change(new_value)
