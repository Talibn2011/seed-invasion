extends CharacterBody2D

signal box_destroyed

@export var speed: float = 150
var target: Node2D = null  # Assigned by spawner

func _ready():
	$Area2D.connect("area_entered", Callable(self, "_on_area_entered"))

func _physics_process(_delta):
	if target == null:
		print('null')
		return  # ❌ stop if no target yet

	# Move toward target
	var direction = (target.position - position).normalized()
	velocity = direction * speed
	look_at(target.position)
	move_and_slide()

	# Check if box has reached the gun
	if position.distance_to(target.position) < 20:  # adjust radius
		var scene_root = get_tree().get_current_scene()
		if scene_root.has_method("on_gun_hit"):
			scene_root.on_gun_hit()
		destroy()

func _on_area_entered(area: Node) -> void:
	if area.is_in_group("bullets"):
		destroy()

func destroy():
	print("Box destroyed!")
	emit_signal("box_destroyed")
	queue_free()
