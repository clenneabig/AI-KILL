extends Emitter
class_name Straight_Shot


# Called when the node enters the scene tree for the first time.
func _ready():
	super()
	spawn_count = 1


# Called every frame. 'delta' is the elapsed time since the previous frame.

func _shoot(vel, _i):
	var nb = bullet_scene.instantiate()
	nb.speed = Vector2(-vel, 0)
	nb.position = position
	nb.rotation = rotation
	get_parent().add_child(nb)
