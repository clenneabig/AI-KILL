extends Area2D

@onready var emit_1 = $Emit
@onready var emit_2 = $Emit2
@onready var emit_3 = $Emit3
@onready var emit_4 = $Emit4

@export var health = 3000
var inPos = false
var notShooting = true

enum State{
	Healthy,
	Damaged,
	Dying
}

var CurrentState = State.Healthy

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite2D.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	match CurrentState:
		State.Healthy:
			if(inPos and notShooting):
				emit_1._startShootin()
				emit_2._startShootin()
				notShooting = false
			if health <= 2000:
				notShooting = true
				emit_1._stopShootin()
				emit_2._stopShootin()
				emit_2.wait_time = 1.0
				CurrentState = State.Damaged
		State.Damaged:
			if(inPos and notShooting):
				emit_3._startShootin()
				emit_2._startShootin()
				notShooting = false
			if health <= 1000:
				notShooting = true
				CurrentState = State.Dying
			
				
	if(global_position.x <= 0):
		_offScreen()

func _offScreen():
	queue_free()

func move_to_centre():
	global_position = position.lerp(Vector2(1000, 327), 0.08)
	if(global_position.x-1000 < 0.1):
		inPos = true

func _on_area_entered(area):
	if area.is_in_group("Player_Bullets"): #or enemy
		health -= 1
		if(health <= 0):
			_turn_to_point()
			_offScreen()
			
func _turn_to_point():
	print("implement me!!")
