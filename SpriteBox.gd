extends CollisionShape2D

var is_invincible = false

func invincible(dur):
	is_invincible = true
	self.set_deferred("disabled", true)
	await get_tree().create_timer(dur).timeout
	self.set_deferred("disabled", false)
	is_invincible = false
