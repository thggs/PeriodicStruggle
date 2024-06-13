extends CharacterBody2D

@export var bullet_speed : float = 1000
@export var bullet_duration : float = 5
@export var speed : float = 150.0

signal shoot(bullet_speed)

@onready var gun = $Guns

var use_mouse_and_keyboard = true

func _physics_process(_delta):

	# Get the input direction for all axis of movement (this vector is already normalized)
	var move_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	var look_direction = Input.get_vector("look_left", "look_right", "look_up", "look_down")
	
	# Rotate the sprite to face the mouse or joystick.
	if(use_mouse_and_keyboard):
		look_at(get_global_mouse_position())
	else:
		look_at(look_direction + position)
	
	# Update the velocity based on the input direction and speed.
	velocity = move_direction * speed
	
	move_and_slide()

	
func _process(_delta):
	if Input.is_action_just_pressed("shoot"):
		shoot.emit(bullet_speed, bullet_duration)
		
func _input(event):
	if(event is InputEventMouse or event is InputEventKey):
		use_mouse_and_keyboard = true
	elif(event is InputEventJoypadButton or event is InputEventJoypadMotion):
		use_mouse_and_keyboard = false
