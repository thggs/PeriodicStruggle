extends RigidBody2D
 
signal bullet_death

var velocity: Vector2 = Vector2()
var is_dead = false
@export var duration : float
@export var damage : float

func _ready() -> void:
	$Lifetime.set_wait_time(duration) 

func _process(_delta):
	if is_dead:
		$CollisionShape2D.set_deferred("disabled", true)
		if !$AnimationPlayer.is_playing():
			hide()
			queue_free()

func _physics_process(delta: float) -> void:
	move_and_collide(velocity * delta)
 
func _on_body_entered(body):
	is_dead = true
 
func _on_lifetime_timeout():
	$AnimationPlayer.play("fade")
	is_dead = true
