#Basic Bullet (Parent) Node (Will make class so can be used for diffrent bullets laters)
extends Node

var speed = Vector2(0, 0)
var dur = 20
var curret_acc =  Vector2(0, 0)
var acc = 1.0
var accel = false
var deccel = false
var Acc_Cap = 100.0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	self.position += (speed.rotated(self.rotation) * delta) + curret_acc
	if(accel and curret_acc.x>(-Acc_Cap)): curret_acc.x -= acc
	if(deccel and curret_acc.x < 8): curret_acc.x += acc/10
	dur -= delta
	if dur <= 0: #avoid memory eating
		queue_free()
	


func _on_body_entered(body):
	#if(isPlayer)
	#	body.takeDamage
	#queue_free()
	pass
