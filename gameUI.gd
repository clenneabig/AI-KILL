extends CanvasLayer

@onready var player = self.get_parent()

# Called when the node enters the scene tree for the first time.
func _ready():
	updateHealth()
	updateBomb()
	updateScore()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
func updateHealth():
	$Lives.text = str(player.health)
func updateBomb():
	pass
func updateScore():
	$Score.text = str(player.score)
