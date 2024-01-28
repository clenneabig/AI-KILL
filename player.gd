extends Area2D
signal hit
signal bomb
signal game_over
@export var speed = 400
var screen_size
var health = 3
var bullets = true
var origin
var bullet_scene = preload("res://playerbullet.tscn")
var step
var vel = 600
var wait_time = 0.2
var powercap = 0
var powerlevel = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	$ShootTime.wait_time = wait_time
	$ShootTime.start()
	var sprite_frames = $Player.sprite_frames
	var texture       = sprite_frames.get_frame_texture("default", 0)
	var texture_size  = texture.get_size()
	var as2d_size     = texture_size * $Player.get_scale()
	origin = Vector2(as2d_size.x/2, screen_size.y/2)
	position = origin
	show()
	$SpriteBox.disabled = false
	$GrazeArea.monitoring = true
	$GrazeArea.monitorable = true

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
		$ShootTime.set_paused(false)
	elif not bullets:
		$ShootTime.set_paused(true)
		
	if (powercap >= 5):
		powerlevel+=1
		powercap = 0
	



func _shoot(vel): #there is likely a better way to do this, but im the artist, not the programmer, teehee
	if not Input.is_action_pressed("focus_mode"):
		if(powerlevel >= 1):
			var nb = bullet_scene.instantiate()
			nb.speed = Vector2(vel, 0)
			nb.position = position
			nb.rotation = rotation
			get_parent().add_child(nb)
		if(powerlevel >= 2):
			var nb2 = bullet_scene.instantiate()
			var nb3 = bullet_scene.instantiate()
			nb2.speed = Vector2(vel-50, 50)
			nb3.speed = Vector2(vel-50,-50)
			nb2.position = Vector2(position.x-3, position.y + 10)
			nb3.position = Vector2(position.x-3, position.y - 10)
			nb2.rotation = rotation + 0.1
			nb3.rotation = rotation - 0.1
			nb2.bullettype = 2
			nb3.bullettype = 2
			get_parent().add_child(nb2)
			get_parent().add_child(nb3)
		if(powerlevel >= 3):
			var nb4 = bullet_scene.instantiate()
			var nb5 = bullet_scene.instantiate()
			nb4.speed = Vector2(vel-100, 100)
			nb5.speed = Vector2(vel-100,-100)
			nb4.position = Vector2(position.x-8, position.y + 20)
			nb5.position = Vector2(position.x-8, position.y - 20)
			nb4.rotation = rotation + 0.2
			nb5.rotation = rotation - 0.2
			nb4.bullettype = 3
			nb5.bullettype = 3
			get_parent().add_child(nb4)
			get_parent().add_child(nb5)
	else:
		if(powerlevel >= 1):
			var nb = bullet_scene.instantiate()
			nb.speed = Vector2(vel, 0)
			nb.position = position
			nb.rotation = rotation
			get_parent().add_child(nb)
		if(powerlevel >= 2):
			var nb2 = bullet_scene.instantiate()
			var nb3 = bullet_scene.instantiate()
			nb2.speed = Vector2(vel,0)
			nb3.speed = Vector2(vel,0)
			nb2.position = Vector2(position.x-3, position.y + 10)
			nb3.position = Vector2(position.x-3, position.y - 10)
			nb2.bullettype = 2
			nb3.bullettype = 2
			get_parent().add_child(nb2)
			get_parent().add_child(nb3)
		if(powerlevel >= 3):
			var nb4 = bullet_scene.instantiate()
			var nb5 = bullet_scene.instantiate()
			nb4.speed = Vector2(vel,0)
			nb5.speed = Vector2(vel,0)
			nb4.position = Vector2(position.x-8, position.y + 20)
			nb5.position = Vector2(position.x-8, position.y - 20)
			nb4.bullettype = 3
			nb5.bullettype = 3
			get_parent().add_child(nb4)
			get_parent().add_child(nb5)
		


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
	$ShootTime.wait_time = wait_time
	$ShootTime.start()
	_shoot(vel)

func respawn():
	position = origin
	$GrazeArea.set_deferred("monitoring", true)
	$GrazeArea.set_deferred("monitorable", true)
	$Blinker.start_blinking(self, 3)
	$SpriteBox.invincible(3)
