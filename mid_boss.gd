extends Area2D

@onready var emit_1 = $Emit
@onready var emit_2 = $Emit2
@onready var emit_3 = $Emit3
@onready var emit_4 = $Emit4

@export var health = 3000
var inPos = false
var notShooting = true

var moveUp = false
var moveDown = false

enum State{
	Healthy,
	Damaged,
	Dying
}

var CurrentState = State.Healthy

# Called when the node enters the scene tree for the first time.
func _ready():
	$SpriteBox.disabled = true
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
				emit_2.wait_time = 1
				var t =Timer.new()
				t.wait_time = 2.0
				t.one_shot = true
				add_child(t)
				t.start()
				await(t.timeout)
				t.queue_free()
				CurrentState = State.Damaged
		State.Damaged:
			if(inPos and notShooting):
				emit_3._startShootin()
				emit_2._startShootin()
				notShooting = false
				moveUp = true
			if(moveUp):
				global_position = global_position.lerp(Vector2(700, 0), 0.05)
				#print(position)
				if (global_position.y < 200): #please ignore bad math I'm at wits end
					moveUp = false
					moveDown = true
			if(moveDown):
				global_position = position.lerp(Vector2(700, 550), 0.05)
				#print(position)
				if(global_position.y > 400):
					moveUp = true
					moveDown = false
			if health <= 1000:
				notShooting = true
				emit_2._stopShootin()
				emit_3._stopShootin()
				emit_2.wait_time = 0.1
				var t =Timer.new()
				t.wait_time = 2.0
				t.one_shot = true
				add_child(t)
				t.start()
				await(t.timeout)
				t.queue_free()
				CurrentState = State.Dying
		State.Dying:
			if(inPos and notShooting):
				emit_2._startShootin()
				notShooting = false
			
				
	if(global_position.x <= 0):
		_offScreen()

func _offScreen():
	queue_free()

func move_to_centre():
	global_position = position.lerp(Vector2(1000, 327), 0.08)
	if(global_position.x-1000 < 0.1):
		$SpriteBox.disabled = false
		inPos = true

func _on_area_entered(area):
	if area.is_in_group("Player_Bullet"): #or enemy
		health -= 20
		area.queue_free()
		if(health <= 0):
			_turn_to_point()
			_offScreen()
			
func _turn_to_point():
	print("implement me!!")
