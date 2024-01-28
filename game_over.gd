extends CanvasLayer

@onready var Player = get_tree().get_nodes_in_group("Player")[0]

func _on_return_pressed():
	self.hide()
	get_tree().paused = false
	get_tree().change_scene_to_file("res://main_menu.tscn")



func _on_restart_pressed():
	get_tree().paused = false
	self.hide()
	get_tree().change_scene_to_file("res://Cutscene.tscn")

func _ready():
	$TextureRect3.hide()
	$TextureRect.hide()
	$TextureRect3/Label.text = str(Player.score)

func gameover(winner):
	if(winner):
		$TextureRect.hide()
		$TextureRect3.show()
		$TextureRect3/Label.text = str(Player.score)
		self.show()
	else:
		$TextureRect.show()
		$TextureRect3.hide()
		self.show()
