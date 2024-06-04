extends CharacterBody2D

@onready var player
@onready var timer =  Timer.new()

@export var speed : float
@export var detection_range : float

@export var attack_speed : float
@export var hp : int = 5
@onready var currentHp : int = hp
@onready var healthBar = $HealthBar
var is_dead = false
var target_pos
var in_range

var push_force : Vector2 = Vector2.ZERO

func _ready():
	player = get_tree().get_first_node_in_group("players")
	timer.set_wait_time(attack_speed)
	var shoot_callable = Callable(self,"shoot")
	timer.connect("timeout", shoot_callable)
	self.add_child(timer)
	timer.start()
	timer.set_autostart(true)
	timer.set_paused(false)
	healthBar.bar.value = hp

func _physics_process(delta):
	
	if push_force.length() > 0.1 :
		push_force = lerp(push_force, Vector2.ZERO, delta * 10)
		velocity = push_force
		move_and_slide()
		return
	
	rotate(0.01)
	
	if !is_dead: 
		if player != null:
			target_pos = player.position
		else:
			target_pos = get_viewport_rect().size/2
			detection_range = 10000000
		var pos = (target_pos - position).normalized()
		
		velocity = Vector2(pos * speed)
		
		in_range = position.distance_to(target_pos) > 3
		in_range = in_range && position.distance_to(target_pos) < detection_range
		
		if(in_range):
			move_and_slide()
	else:
		$CollisionShape2D.disabled = true
		if get_node("Guns").is_empty():
			queue_free()

func shoot():
	if in_range:
		var guns = get_node("Guns").get_children()
		for g in guns:
			g.shoot()
		
func hit(hit : Node):
	currentHp -= 1
	
	var hit_dir = (position - hit.position).normalized()
		
	healthBar.change_value(currentHp)
	
	$AnimationPlayer.play("hit")
	knockback(hit_dir)
	$"Hit particles".emitting = true
	
	if(currentHp <= 0):
		timer.stop()
		$PointLight2D.visible = false
		$Sprite2D.visible = false
		$Sprite2D.set_process(false)
		is_dead = true
		healthBar.visible = false
	
func knockback(dir : Vector2):
	push_force = -(dir) * 100
