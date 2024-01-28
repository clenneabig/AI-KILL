extends Area2D

@onready var emit = $Emit
@onready var sb = $SpriteBox
@export var health = 3

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite2D.play()
	sb.disabled = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(global_position.x <= 0):
		_offScreen()

func _offScreen():
	queue_free()


func _on_area_entered(area):
	if area.is_in_group("Player_Bullet"): #or enemy
		if(global_position.x < 1152):
			health -= 1
			if(health <= 0):
				var random_chance = randi() % 100
				_turn_to_power()
				_offScreen()
			
func _turn_to_power():
	var powerup_scene = preload("res://power_up.tscn")
	var powerup = powerup_scene.instantiate()
	get_tree().root.add_child(powerup)
	var random_power = randi() % 6
	powerup._set_variables(random_power)
	powerup.global_position = global_position
