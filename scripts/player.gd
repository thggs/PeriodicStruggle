extends CharacterBody2D


const SPEED = 150.0

# I like to have these scenes start with obj_, to distinguish them from other similarly named variables
const obj_bullet = preload("res://scenes/prefabs/bulletDefault.tscn") 

@onready var gun = get_node("Sprite/Guns")

func _physics_process(delta):

	# Get the input direction for both horizontal and vertical movement.
	var direction = Vector2(Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
							Input.get_action_strength("move_down") - Input.get_action_strength("move_up"))
	
	# Normalize the direction vector to ensure consistent speed in all directions.
	if direction.length() > 1:
		direction = direction.normalized()
	
	# Rotate the sprite to face the direction it's moving.

	$Sprite.rotation_degrees = rad_to_deg(get_local_mouse_position().angle()) + 90 
			
	# Update the velocity based on the input direction and speed.
	velocity = direction * SPEED

	if Input.is_action_just_pressed("shoot"):
		shoot($Sprite.rotation_degrees - 90, 1000)

	move_and_slide()


func shoot(direction: float, speed: float):
	gun.shoot(speed)
	PlayerData.exp += 1
	
func hit(hit : Node):
	pass
