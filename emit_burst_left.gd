extends Emitter


# Called when the node enters the scene tree for the first time.
func _ready():
	super()
	rotate(-0.3)
	step = 2 * PI/4 /spawn_count


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _shoot(vel, i):
	var nb = bullet_scene.instantiate()
	nb.speed = Vector2(-vel, 0).rotated((step/2*i))
	nb.position = position
	nb.rotation = rotation
	get_parent().add_child(nb)
