extends Area2D
signal hit
signal bomb

@export var speed = 400
var screen_size
var health = 3

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size

func start(pos):
	position = pos
	show()
	$SpriteBox.disabled = false
	$GrazeBox.disabled = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Player.play()
	self.position = get_viewport().get_mouse_position()

	if Input.is_action_pressed("bomb"):
		bomb.emit()


func _on_body_entered(body):
	health -= 1
	if health <= 0:
		var i = 0
	hide() # Player disappears after being hit.
	hit.emit()
	# Must be deferred as we can't change physics properties on a physics callback.
	$SpriteBox.set_deferred("disabled", true)
	$GrazeBox.set_deferred("disabled", true)

