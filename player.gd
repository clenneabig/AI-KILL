extends Area2D
signal hit
signal bomb
signal game_over

@export var speed = 400
var screen_size
var health = 3
var bullets = true

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
	var velocity = Vector2.ZERO # The player's movement vector.
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1


	if velocity.length() > 0:
		var realSpeed = speed/2 if Input.is_action_pressed("focus_mode") else speed
		
		velocity = velocity.normalized() * realSpeed

	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size)
	#self.position = get_viewport().get_mouse_position()

	if Input.is_action_pressed("bomb") and $HSlider.value == 100:
		bomb.emit()

	if Input.is_action_pressed("toggle_bullets"):
		bullets = not bullets


func _on_body_entered(body):
	health -= 1
	if health <= 0:
		game_over.emit()
	hide() # Player disappears after being hit.
	hit.emit()
	# Must be deferred as we can't change physics properties on a physics callback.
	$SpriteBox.set_deferred("disabled", true)
	$GrazeBox.set_deferred("disabled", true)

