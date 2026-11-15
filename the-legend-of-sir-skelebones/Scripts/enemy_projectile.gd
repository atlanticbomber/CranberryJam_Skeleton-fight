extends Area2D
class_name EnemyProjectile

@export var speed: float = 1000.0
@export var distance: float = 100.0
@export var damage:float = 10.0

var direction: Vector2
var startPosition:Vector2
func _ready() -> void:
	startPosition = position
	
func _process(delta: float) -> void:
	position += Vector2(speed,speed) * direction * delta
	if position.distance_to(startPosition) > distance:
		self.queue_free()
	
func _on_body_entered(body: Node2D) -> void:
	if body.has_method("takeDamage"):
		body.takeDamage(damage)
