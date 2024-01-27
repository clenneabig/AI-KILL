extends Emitter

var stg_timer = Timer.new()
var stg_wait_time = 0.3
# Called when the node enters the scene tree for the first time.
func _ready():
	shoot_timer.wait_time = 0.6
	spawn_count = 1
	stg_timer.wait_time = stg_wait_time
	add_child(stg_timer)
	vel = 300
	super()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _shoot(vel, _i):
	var nb = bullet_scene.instantiate()
	nb.speed = Vector2(-vel, 0)
	nb.position.x = position.x
	nb.position.y = position.y-20
	nb.rotation = rotation
	get_parent().add_child(nb)
	stg_timer.start()
	await stg_timer.timeout
	var nb_2 = bullet_scene.instantiate()
	nb_2.speed = Vector2(-vel, 0)
	nb_2.position.x = position.x
	nb_2.position.y = position.y+20
	get_parent().add_child(nb_2)
