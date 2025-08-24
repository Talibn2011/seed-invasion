# Bullet.gd
extends Area2D

func _ready():
	connect("area_entered", Callable(self, "_on_area_entered"))

func _on_area_entered(area):
	if area.name == "Enemy":  # Optional: you can check for group instead
		print("Bullet hit enemy!")
		queue_free()  # Destroy bullet
		area.queue_free()  # Optional: destroy enemy
