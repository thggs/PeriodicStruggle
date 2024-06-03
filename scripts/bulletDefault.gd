extends Area2D
 
 
var velocity: Vector2 = Vector2()
var duration = 5
@export var group : String = "entities"

signal bullet_death


func _ready() -> void:
	var callable = Callable(self, "_on_body_entered")
	connect("body_entered", callable)
 
func _process(delta: float) -> void:
	position += velocity * delta
	
	duration -= delta
	
	if duration <= 0:
		bullet_death.emit()
		queue_free()
 
func _on_body_entered(body):
	# "body" here is the thing that we've hit
	# Here we check if the body is a player, so we know to deal damage to them
	# There are other ways to do this including class names and collision layers
	if body.is_in_group(group):
		visible = false
		body.hit(self)
		bullet_death.emit()
		queue_free()
 
