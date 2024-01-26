extends Node2D
class_name Emitter

var bullet_scene = preload("res://BulletPattens/bullet.tscn")
@onready var shoot_timer = $ShootTime
@export var spawn_count = 12
var step

# Called when the node enters the scene tree for the first time.
func _ready():
	shoot_timer.start()
	#step = 2 * PI /spawn_count
	step = 2 * PI /spawn_count
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	#self.rotate(0.01)
	
	
func _shoot(vel, i):
	var nb = bullet_scene.instantiate()
	nb.speed = Vector2(vel, 0).rotated((step*i))
	nb.position = position
	nb.rotation = rotation
	get_parent().add_child(nb)
	
func _on_shoot_time_timeout():
	for i in spawn_count:
		_shoot(100, i)
