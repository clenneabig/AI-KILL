extends Emitter

var stg_timer = Timer.new()
@export var stg_wait_time = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	stg_timer.wait_time = stg_wait_time
	add_child(stg_timer)
	super()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	rotate(0.1)

func _shoot(vel, i):
	var nb = bullet_scene.instantiate()
	nb.speed = Vector2(vel, 0).rotated((step*i))
	nb.position = global_position
	nb.rotation = rotation
	Bullet_Holder.add_child(nb)
	nb._change_texture(texture)
	stg_timer.start()
	await stg_timer.timeout
	for j in spawn_count:
		var nb_2 = bullet_scene.instantiate()
		nb_2.speed = Vector2(vel, 0).rotated((step*j))
		nb_2.position = nb.position
		nb_2.rotation = rotation
		Bullet_Holder.add_child(nb_2)
		nb_2._change_texture(texture)
