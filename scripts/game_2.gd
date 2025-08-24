extends Node2D

@onready var BoxScene = preload("res://scenes/Box.tscn")
var number_of_boxes = 8  # spawn 8 boxes

func _ready():
	spawn_boxes(number_of_boxes)

func spawn_boxes(count: int):
	for i in range(count):
		var box = BoxScene.instantiate()
		# Random positions around the edges of the screen
		box.position = Vector2(randi() % 800, randi() % 600)
		add_child(box)
		# Optional: connect destroyed signal
		box.connect("box_destroyed", Callable(self, "_on_box_destroyed"))

func _on_box_destroyed():
	print("A box was destroyed!")
