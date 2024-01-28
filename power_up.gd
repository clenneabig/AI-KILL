extends Area2D

var random_number = randi() % 8
var screen_size
var left_vel = Vector2.ZERO
var ended = false
var cooldown = randf_range(0.5, 1.5)

func _ready():
	screen_size = get_viewport_rect().size

func _process(delta):
	var velocity = Vector2.ZERO
	if cooldown > 0:
		match random_number:
			0: 
				velocity.x += 0.25
			1:
				velocity.x += 1
				velocity.y += 1
			2:
				velocity.y += 1
			3:
				velocity.x -= 1
				velocity.y += 1
			4:
				velocity.x -= 1
			5:
				velocity.x -= 1
				velocity.y -= 1
			6:
				velocity.y -= 1
			7:
				velocity.x += 1
				velocity.y -= 1

		velocity = velocity.normalized() * 50
		position += velocity * delta
		position = position.clamp(Vector2.ZERO, screen_size)
		cooldown -= delta
	else:
		left_vel += Vector2(-1,0).normalized() * 5
		position += left_vel * delta
	
	if position.x < 0:
		queue_free()


func _on_area_entered(area:Area2D):
	if area.name == 'Player':
		area.get_node('ProgressBar').value += 100
		queue_free()


func _on_timer_timeout():
	ended = true
