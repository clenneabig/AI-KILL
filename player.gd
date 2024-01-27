extends Area2D
signal hit
signal bomb
signal game_over

@export var speed = 400
var screen_size
var health = 3
var bullets = true
var origin = Vector2(50, 350)
var bullet_scene = preload("res://playerbullet.tscn")
var step
var vel = 600
var wait_time = 0.2

var ShootTime = Timer.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	add_child(ShootTime)
	ShootTime.timeout.connect(_on_shoot_time_timeout)
	screen_size = get_viewport_rect().size
	ShootTime.wait_time = wait_time
	ShootTime.start()

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

	if Input.is_action_just_pressed("toggle_bullets"):
		bullets = not bullets

	if bullets:
		ShootTime.set_paused(false)
	elif not bullets:
		ShootTime.set_paused(true)
		


func _shoot(vel):
	var nb = bullet_scene.instantiate()
	nb.speed = Vector2(vel, 0)
	nb.position = position
	nb.rotation = rotation
	get_parent().add_child(nb)


func _on_area_entered(area):
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


func _on_shoot_time_timeout():
	ShootTime.wait_time = wait_time
	ShootTime.start()
	_shoot(vel)

func respawn():
	position = origin
	$GrazeArea.set_deferred("monitoring", true)
	$GrazeArea.set_deferred("monitorable", true)
	$Blinker.start_blinking(self, 3)
	$SpriteBox.invincible(3)
