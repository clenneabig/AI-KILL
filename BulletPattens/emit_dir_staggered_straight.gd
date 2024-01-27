extends Emitter

var stg_timer = Timer.new()
@export var stg_wait_time = 0.3
# Called when the node enters the scene tree for the first time.
func _ready():
	stg_timer.wait_time = stg_wait_time
	add_child(stg_timer)
	super()


# Called every frame. 'delta' is the elapsed time since the previous frame.

func _shoot(vel, _i):
	var nb = bullet_scene.instantiate()
	nb.speed = Vector2(-vel, 0)
	nb.position.x = global_position.x
	nb.position.y = global_position.y-20
	nb.rotation = rotation
	Bullet_Holder.add_child(nb)
	nb._change_texture(texture)
	stg_timer.start()
	await stg_timer.timeout
	var nb_2 = bullet_scene.instantiate()
	nb_2.speed = Vector2(-vel, 0)
	nb_2.position.x = global_position.x
	nb_2.position.y = global_position.y+20
	Bullet_Holder.add_child(nb_2)
	nb_2._change_texture(texture)
