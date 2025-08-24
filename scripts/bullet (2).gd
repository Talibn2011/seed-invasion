extends Area2D

var speed = 2000
var direction = Vector2.ZERO
var shoot = true
var cooldown := 0.2

func _ready():
	connect("area_entered", Callable(self, "_on_area_entered"))
	add_to_group("bullets")
	
func _on_area_entered(_area):
	print("Bullet hit something!")
	# Only free the bullet itself, not the other area
	queue_free()

func _physics_process(delta: float) -> void:
	position += direction * speed * delta
