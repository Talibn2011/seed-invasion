extends Node2D

var Bullet = preload("res://scenes/Bullet.tscn")
@onready var muzzle = $Muzzle

var can_shoot := true
var shoot_cooldown := 0.2

# --- Health system ---
var gun_health: int = 3
@onready var health_label: Label = $"../HealthLabel"  # optional, adjust path

func _process(_delta: float) -> void:
	look_at(get_global_mouse_position())

func _input(event: InputEvent) -> void:
	if can_shoot and event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		var bullet = Bullet.instantiate()
		get_tree().current_scene.add_child(bullet)
		bullet.global_position = muzzle.global_position
		bullet.direction = (get_global_mouse_position() - muzzle.global_position).normalized()
		can_shoot = false
		await get_tree().create_timer(shoot_cooldown).timeout
		can_shoot = true

func on_gun_hit():
	gun_health -= 1
	print("Gun hit! Health remaining:", gun_health)

	# Update label if it exists
	if health_label:
		health_label.text = "Health: %d" % gun_health

	# If health is gone, change to game over scene
	if gun_health <= 0:
		print("Game Over!")
		get_tree().change_scene("res://scenes/game_over.tscn")
