
extends Node2D

var points: int = 0  # Tracks the player's points#
var gun_health: int = 3  # Gun can take 3 hits

# Preload your Box scene
var BoxScene = preload("res://scenes/box_2.tscn")

var spawn_positions = [
	Vector2(-986, -724),
	Vector2(-8, -724),
	Vector2(976, -724),
	Vector2(-976, -4),
	Vector2(976, -4),
	Vector2(-8, 724),
	Vector2(976, 724),
	Vector2(-976, 724)
]

func _ready():
	randomize()
	for pos in spawn_positions:
		spawn_box(pos)

func spawn_box(pos: Vector2):
	var box = BoxScene.instantiate()
	box.global_position = pos
	add_child(box)

	# Assign the target (your gun node)
	var gun = $Gun2  # Adjust this path to wherever the Gun node is relative to this script
	box.target = gun

	# Connect the destroyed signal
	var ok = box.connect("box_destroyed", Callable(self, "_on_box_destroyed"))
	if ok == OK:
		print("✅ Connected box_destroyed signal for a box at:", pos)
	else:
		print("❌ Failed to connect box_destroyed signal!")

	print("Spawned a box at:", pos)

@onready var points_label = $PointsLabel  # Path to your Label node

func _on_box_destroyed():
	if !is_inside_tree():
		return  # game.gd is gone, don't run

	points += 10
	if points_label:
		points_label.text = "Points: %d" % points  

	# safe respawn
	await get_tree().create_timer(2.0).timeout
	if is_inside_tree(): # check again before spawning
		var pos = spawn_positions[randi() % spawn_positions.size()]
		spawn_box(pos)

	var gun_health: int = 3  # This belongs to the game controller
	
@onready var health_label = $HealthLabel  # optional label to show health

func on_gun_hit():
	gun_health -= 1
	print("Gun hit! Health remaining:", gun_health)
	
	if health_label:
		health_label.text = "Health: %d" % gun_health

	if gun_health <= 0:
		print("Game Over!")
		get_tree().change_scene_to_file("res://scenes/end_screen.tscn")
		save_score(points)  # Save the player’s score
		
#	if gun_health <= 0:
#		print("Game Over!")
#		var game_over_scene = load("res://scenes/game_over.tscn").instantiate()
#		game_over_scene.final_score = points  # pass points to GameOver scene
#		get_tree().root.add_child(game_over_scene)
#		queue_free()  # remove the game scene


		
func save_score(new_score: int):
	var file_path = "user://leaderboard.json"  # saved in user's app data folder
	var data = {}

	# Load existing scores
	if FileAccess.file_exists(file_path):
		var file = FileAccess.open(file_path, FileAccess.READ)
		data = JSON.parse_string(file.get_as_text())
		file.close()
		if typeof(data) != TYPE_DICTIONARY:
			data = {}

	# Add the new score
	if !"scores" in data:
		data["scores"] = []
	data["scores"].append(new_score)

	# Sort scores (highest first), keep top 10
	data["scores"].sort_custom(func(a, b): return b < a)
	if data["scores"].size() > 10:
		data["scores"] = data["scores"].slice(0, 10)

	# Save back to file
	var file = FileAccess.open(file_path, FileAccess.WRITE)
	file.store_string(JSON.stringify(data))
	file.close()
