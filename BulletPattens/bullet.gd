#Basic Bullet (Parent) Node (Will make class so can be used for diffrent bullets laters)
extends Node

var speed = Vector2(0, 0)
var dur = 20

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	self.position += speed.rotated(self.rotation) * delta
	dur -= delta
	if dur <= 0:
		queue_free()
	


func _on_body_entered(body):
	#if(isPlayer)
	#	body.takeDamage
	#queue_free()
	pass
