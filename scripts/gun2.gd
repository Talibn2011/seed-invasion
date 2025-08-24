extends Node2D

var Bullet = preload("res://scenes/Bullet.tscn")
@onready var muzzle = $Muzzle

var can_shoot := true
var shoot_cooldown := 0.2

func _input(event: InputEvent) -> void:
	if can_shoot and event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		shoot()

func shoot():
	can_shoot = false
	var bullet = Bullet.instantiate()
	get_tree().current_scene.add_child(bullet)
	bullet.global_position = muzzle.global_position
	bullet.direction = (get_global_mouse_position() - muzzle.global_position).normalized()
	await get_tree().create_timer(shoot_cooldown).timeout
	can_shoot = true
