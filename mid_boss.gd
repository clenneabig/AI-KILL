extends Area2D

@onready var emit_1 = $Emit
@onready var emit_2 = $Emit2
@onready var emit_3 = $Emit3
@onready var emit_4 = $Emit4

@export var health = 3000
var inPos = false

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
	if(inPos):
		match CurrentState:
			State.Healthy:
				print("healthy")
				emit_1._startShootin()
	if(global_position.x <= 0):
		_offScreen()

func _offScreen():
	queue_free()

func move_to_centre():
	global_position = position.lerp(Vector2(800, 327), 0.08)
	if(global_position.x-800 < 0.1):
		inPos = true
