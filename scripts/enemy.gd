extends RigidBody2D

signal attack

@onready var player = get_tree().get_first_node_in_group("player")

@export var speed : float = 50
@export var detection_range : float = 1000
@export var bullet_speed : float = 100
@export var bullet_duration : float = 5
@export var attack_speed : float = 1
@export var hp : int = 5
@onready var currentHp : int = hp

var is_dead = false
var target_pos
var in_range

var push_force : Vector2 = Vector2.ZERO

func _ready():
	$AttackTimer.set_wait_time(1/attack_speed)
	$Healthbar/Bar.value = hp
	$Healthbar/Bar.max_value = hp
	get_target_pos()

func _physics_process(delta):
	
	if push_force.length() > 0.1 :
		push_force = lerp(push_force, Vector2.ZERO, delta * 10)
		linear_velocity = push_force
		return
		
	if !is_dead:
		rotate(delta)
		$Healthbar.global_rotation = 0.0
		
		var pos = (target_pos - position).normalized()
		
		linear_velocity = Vector2(pos * speed)
		
		in_range = position.distance_to(target_pos) > 3
		in_range = in_range && position.distance_to(target_pos) < detection_range
		
		if(in_range):
			pass

func _process(_delta):
	
	if !is_dead:
		get_target_pos()
		if currentHp == hp:
			$Healthbar.hide()
		else:
			$Healthbar.show()

	else:
		$CollisionShape2D.set_deferred("disabled", true)
		$AttackTimer.stop()
		$Sprite2D.hide()
		$PointLight2D.hide()
		$Healthbar.hide()
		if $"Hit particles".emitting == false:
			queue_free()

func _on_body_entered(body):
	currentHp -= 1
	$"Hit particles".emitting = true
	$Healthbar/Bar.value = currentHp
	
	if(currentHp <= 0):
		death()
		return
		
	var hit_dir = (position - body.position).normalized()
	knockback(hit_dir)
	$AnimationPlayer.play("hit")
	
	if(currentHp <= 0):
		death()

#Method responsible for handling this enemy's death
func death():
	#player gets exp on enemy kill, maybe change this to a 
	#var later? Maybe difrerent evemies give diferent exp?
	PlayerData.exp += 5
	is_dead = true

func get_target_pos():
	if player != null:
		target_pos = player.position
	else:
		target_pos = get_viewport_rect().size/2
		detection_range = 1000000

func knockback(dir : Vector2):
	push_force = -(dir) * 100

func _on_shooting_timer_timeout():
	attack.emit(bullet_speed, bullet_duration)
