extends Node2D
class_name Emitter

var bullet_scene = preload("res://BulletPattens/bullet.tscn")

@onready var shoot_timer = $ShootTime 
@onready var Bullet_Holder = get_tree().get_nodes_in_group("Bullet_Node")[0]

@export var spawn_count = 6
@export var constant_shot = false
@export var rotate_speed = 0.1
@export var shoot_timer_one_shot = true
@export var wait_time = 1.0
@export var vel = 100

var step
var rotation_flip = false

enum Rotate_State{
	rotating_360,
	rotating_180,
	rotating_45,
	jitter,
	none
}
@export var Current_Rotation = Rotate_State.none

# Called when the node enters the scene tree for the first time.
func _ready():
	if(constant_shot): _startShootin()
	shoot_timer.one_shot = shoot_timer_one_shot
	shoot_timer.wait_time = wait_time
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
	
func _shoot(_vel, i):
	var nb = bullet_scene.instantiate()
	nb.speed = Vector2(_vel, 0).rotated((step*i))
	nb.position = global_position
	nb.rotation = rotation
	Bullet_Holder.add_child(nb)
	
func _on_shoot_time_timeout():
	for i in spawn_count:
		_shoot(vel, i)


func _rotate(r:float):
	rotate(r)
	
func _startShootin():
	shoot_timer.start()
