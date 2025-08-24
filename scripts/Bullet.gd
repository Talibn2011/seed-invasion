extends Area2D

var speed = 2000
var direction = Vector2.ZERO

func _physics_process(delta: float) -> void:
	position += direction * speed * delta

func _on_Bullet_body_entered(body: Node) -> void:
	position = Vector2(100000000000,100000000000000)
