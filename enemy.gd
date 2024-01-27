extends Area2D

@onready var emit = $Emit
@export var health = 3

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite2D.play()


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
				_turn_to_power()
				_offScreen()
			
func _turn_to_power():
	print ("Implement me!!")
