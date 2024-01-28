extends Area2D

var longest

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if $CollisionShape2D.disabled == false:
		$CollisionShape2D.scale.x += 1
		$CollisionShape2D.scale.y += 1
		$Bomb.scale.x += 1
		$Bomb.scale.y += 1
		if $CollisionShape2D.scale.x >= longest/15:
			$Bomb.visible = false
			$CollisionShape2D.disabled = true



func _on_player_bomb():
	longest = get_viewport_rect().size.x
	var bullets = get_tree().get_nodes_in_group("Bullet")
	
	for bullet in bullets:
		make_powerup(bullet)

	get_tree().call_group("Bullet", "queue_free")
	$CollisionShape2D.scale = Vector2(1, 1)
	$Bomb.scale = Vector2(1, 1)
	$Bomb.visible = true
	$CollisionShape2D.disabled = false

func make_powerup(bullet):
	var powerup_scene = preload("res://power_up.tscn")
	var powerup = powerup_scene.instantiate()
	get_tree().root.add_child(powerup)
	powerup.position = bullet.position

func _on_area_entered(area:Area2D):
	if area.is_in_group("Enemy"):
		area.queue_free()

	# elif area.is_in_group("Bullet"):
	# 	var powerup_scene = preload("res://power_up.tscn")
	# 	var powerup = powerup_scene.instantiate()
	# 	get_tree().root.add_child(powerup)
	# 	powerup.position = area.position
	# 	area.queue_free()

	elif area.is_in_group("Boss"):
		area.health -= 100
