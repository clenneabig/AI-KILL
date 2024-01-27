#Basic Bullet (Parent) Node (Will make class so can be used for diffrent bullets laters)
extends Area2D

var speed = Vector2(0, 0)
var dur = 20
var curret_acc =  Vector2(0, 0)
var acc = 1.0
var accel = false
var deccel = false
var Acc_Cap = 100.0

@onready var sprite = $Sprite2D
var red = preload("res://assets/bullets/enemybullets/redbullet.png")
var orange = preload("res://assets/bullets/enemybullets/orangebullet.png")
var yellow = preload("res://assets/bullets/enemybullets/yellowbullet.png")
var green = preload("res://assets/bullets/enemybullets/greenbullet.png")
var cyan = preload("res://assets/bullets/enemybullets/cyanbullet.png")
var blue = preload("res://assets/bullets/enemybullets/bluebullet.png")
var indigo = preload("res://assets/bullets/enemybullets/indigobullet.png")
var purple = preload("res://assets/bullets/enemybullets/purplebullet.png")
var pink = preload("res://assets/bullets/enemybullets/pinkbullet.png")

var textarr = [red, orange, yellow, green, cyan, blue, indigo, purple, pink]

func _ready():
	sprite.texture = textarr[0]

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	self.position += (speed.rotated(self.rotation) * delta) + curret_acc
	if(accel and curret_acc.x>(-Acc_Cap)): curret_acc.x -= acc/10
	if(deccel and curret_acc.x < 4): curret_acc.x += acc/20
	dur -= delta
	if dur <= 0: #avoid memory eating
		queue_free()

func _offScreen(): #explicity remove bullets when off screen so I can free enemies
	pass
	


func _on_body_entered(body):
	if(body.is_in_group("Player")):
		#body.takeDamage
		print("ouch")
		queue_free()
	pass

func _change_texture(num : int):
	sprite.texture = textarr[num]
