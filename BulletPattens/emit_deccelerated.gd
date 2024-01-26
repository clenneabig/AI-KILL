extends Straight_Shot


# Called when the node enters the scene tree for the first time.
func _ready():
	shoot_timer.wait_time = 1.0
	vel = 300
	super()

func _shoot(vel, _i):
	var nb = bullet_scene.instantiate()
	nb.deccel = true
	nb.speed = Vector2(-vel, 0)
	nb.position = position
	nb.rotation = rotation
	get_parent().add_child(nb)
