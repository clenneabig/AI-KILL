extends Straight_Shot


# Called when the node enters the scene tree for the first time.
func _ready():
	super()

func _shoot(vel, _i):
	var nb = bullet_scene.instantiate()
	nb.deccel = true
	nb.speed = Vector2(-vel, 0)
	nb.position = global_position
	nb.rotation = rotation
	Bullet_Holder.add_child(nb)
