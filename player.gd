extends Area2D
signal hit
signal bomb
signal game_over

@export var speed = 400
var screen_size
var health = 3
var bullets = true
var origin = Vector2(50, 350)
var is_invincible = false

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size

func start(pos):
	position = origin
	show()
	$SpriteBox.disabled = false
	$GrazeArea.monitoring = true
	$GrazeArea.monitorable = true

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

	if Input.is_action_pressed("bomb") and $ProgressBar.value == 100:
		bomb.emit()
		$ProgressBar.value = 0

	if Input.is_action_pressed("toggle_bullets"):
		bullets = not bullets

func _on_area_entered(area):
	print(area)
	if area.is_in_group("Bullet"): #or enemy
		health -= 1
		hit.emit()
		if health <= 0:
			print("deaded")
			game_over.emit()
		hide() # Player disappears after being hit. #player needs to appear again lol
		
	# Must be deferred as we can't change physics properties on a physics callback.
		if not $SpriteBox.is_invincible:
			respawn()
	#$GrazeBox.set_deferred("disabled", true)


func _on_graze_area_area_entered(area):
	if area.is_in_group("Bullet"):
		if(self.is_visible()):
			print("add to style points")


func respawn():
	position = origin
	$GrazeArea.set_deferred("monitoring", true)
	$GrazeArea.set_deferred("monitorable", true)
	$Blinker.start_blinking(self, 3)
	$SpriteBox.invincible(3)
