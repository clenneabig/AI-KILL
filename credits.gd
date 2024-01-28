extends Control

@onready var credits = $TextureRect
@onready var ai = $TextureRect2
var chide = false

# Called when the node enters the scene tree for the first time.
func _ready():
	ai.hide()
	credits.show()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_pressed():
	get_tree().change_scene_to_file("res://main_menu.tscn")


func _on_button_2_pressed():
	if(chide == true):
		credits.show()
		ai.hide()
		chide = false
	else:
		credits.hide()
		ai.show()
		chide = true
