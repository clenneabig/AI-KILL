#Basic Bullet (Parent) Node (Will make class so can be used for diffrent bullets laters)
extends Area2D

var speed = Vector2(0, 0)
var dur = 20
var curret_acc =  Vector2(0, 0)
var acc = 1.0
var accel = false
var deccel = false
var Acc_Cap = 100.0
var bullettype

@onready var sprite = $Sprite2D
var bt1 = preload("res://assets/bullets/playerbullets/aibullet1.png")
var bt2 = preload("res://assets/bullets/playerbullets/aibullet2.png")
var bt3 = preload("res://assets/bullets/playerbullets/aibullet3.png")

#var textarr = [bt1, bt2, bt3]

func ready():
	if(bullettype == 1):
		sprite.texture = bt1
	if(bullettype == 2):
		sprite.texture = bt2
	if(bullettype == 3):
		sprite.texture = bt3

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	textchang()
	self.position += (speed.rotated(self.rotation) * delta) + curret_acc
	if(accel and curret_acc.x>(-Acc_Cap)): curret_acc.x -= acc
	if(deccel and curret_acc.x < 4): curret_acc.x += acc/20
	dur -= delta
	if dur <= 0: #avoid memory eating
		queue_free()
	

func textchang():
	if(bullettype == 2):
		if(sprite != bt2):
			sprite.texture = bt2
	if(bullettype == 3):
		if(sprite != bt3):
			sprite.texture = bt3

func freedom():
	self.speed = Vector2(0, 0)
	$Sprite2D.hide()
	$AnimatedSprite2D.play()
	$CollisionShape2D.disabled = true
	await($AnimatedSprite2D.animation_finished)
	queue_free()
