extends CanvasLayer

func _ready():
	var user_file_path = "user://leaderboard.json"
	var full_path = ProjectSettings.globalize_path(user_file_path)
	print("Leaderboard will be saved to: ", full_path)

func _on_start_pressed() -> void:
	print('play')
	get_tree().change_scene_to_file("res://scenes/game.tscn")
	pass # Replace with function body.

func _on_leaderbourd_pressed() -> void:
	print('not here yet')
	get_tree().change_scene_to_file("res://scenes/leaderboard_screen.tscn")
	pass # Replace with function body.

func _on_quit_pressed() -> void:
	print('quit')
	get_tree().quit()
	pass # Replace with function body.
