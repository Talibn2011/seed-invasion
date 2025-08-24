extends CharacterBody2D

signal box_destroyed  # REQUIRED

func _ready():
	# Connect the signal from child Area2D
	$Area2D.connect("area_entered", Callable(self, "_on_Box_area_entered"))
	
	
func destroy():
	print("Box destroyed!")
	emit_signal("box_destroyed")
	queue_free()

func _on_Box_area_entered(area: Node) -> void:
	print("Box collided with:", area.name, " Groups:", area.get_groups())
	if area.is_in_group("bullets"):
		destroy()
