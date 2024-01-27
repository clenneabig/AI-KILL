extends Node2D
class_name Emitter

var bullet_scene = preload("res://BulletPattens/bullet.tscn")
@onready var shoot_timer = $ShootTime
@export var spawn_count = 6
var rotate_speed = 0.1
var wait_time = 1.0
var step
var vel = 100
var rotation_flip = false

enum Rotate_State{
	rotating_360,
	rotating_180,
	rotating_45,
	jitter,
	none
}
var Current_Rotation = Rotate_State.none

# Called when the node enters the scene tree for the first time.
func _ready():
	shoot_timer.wait_time = wait_time
	shoot_timer.start()
	step = 2 * PI /spawn_count
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	match Current_Rotation:
		Rotate_State.rotating_360:
			_rotate(rotate_speed)
		Rotate_State.rotating_180:
			if(rotation_flip):
				_rotate(-rotate_speed)
				if(rad_to_deg(rotation) <= -90):
					rotation_flip = false
			else:
				_rotate(rotate_speed)
				if(rad_to_deg(rotation) >= 90):
					rotation_flip = true
		Rotate_State.rotating_45:
			if(rotation_flip):
				_rotate(-rotate_speed)
				if(rad_to_deg(rotation) <= -45):
					rotation_flip = false
			else:
				_rotate(rotate_speed)
				if(rad_to_deg(rotation) >= 45):
					rotation_flip = true
		Rotate_State.jitter:
			if(rotation_flip):
				_rotate(-rotate_speed)
				if(rad_to_deg(rotation) <= -15):
					rotation_flip = false
			else:
				_rotate(rotate_speed)
				if(rad_to_deg(rotation) >= 15):
					rotation_flip = true
	
func _shoot(vel, i):
	var nb = bullet_scene.instantiate()
	nb.speed = Vector2(vel, 0).rotated((step*i))
	nb.position = position
	nb.rotation = rotation
	get_parent().add_child(nb)
	
func _on_shoot_time_timeout():
	for i in spawn_count:
		_shoot(vel, i)

func _rotate(r:float):
	rotate(r)
