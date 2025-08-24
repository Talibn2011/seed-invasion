extends AnimatedSprite2D   # Or AnimatedSprite2D if that’s what you use

@export var bullet_scene: PackedScene
@onready var muzzle = $Muzzle

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		shoot()

func shoot() -> void:
	var bullet = bullet_scene.instantiate()
	get_tree().current_scene.add_child(bullet) # add to main scene
	bullet.global_position = muzzle.global_position
	bullet.direction = (get_global_mouse_position() - global_position).normalized()
