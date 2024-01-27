extends Area2D

func _on_area_entered(area:Area2D):
	if area.name == 'Player':
		area.get_node('ProgressBar').value += 100
		queue_free()
