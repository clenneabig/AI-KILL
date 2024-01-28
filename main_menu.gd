extends Control


func _on_play_pressed():
	get_tree().change_scene_to_file("res://Cutscene.tscn")


func _on_credits_pressed():
	get_tree().change_scene_to_file("res://credits.tscn")
