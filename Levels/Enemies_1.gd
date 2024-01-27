extends Node2D

@onready var group1 = $Group_1/Path2D/PathFollow2D
@onready var group2 = $Group_2/Path2D/PathFollow2D

var g_move_speed = 150.0
var paused = false
var p = false

enum Groups{
	Group1,
	Group2,
	Group3,
	Group4,
	Mid_Boss,
	Group5,
	Group6,
	Boss
}
var CurrentGroup = Groups.Group1
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	match CurrentGroup:
		Groups.Group1:
			if(group1.get_child_count() > 0 && paused == false): #if the group has enemies
				group1.progress += g_move_speed * delta
				if(group1.progress_ratio >= 0.45 && p == false):
					paused = true
					for enemy in group1.get_children():
						enemy.emit._startShootin()
					var t =Timer.new()
					t.wait_time = 3.0
					t.one_shot = true
					add_child(t)
					t.start()
					await(t.timeout)
					paused = false
					p = true
			if(group1.get_child_count() == 0):
				CurrentGroup = Groups.Group2
				paused = false
				p = false
		Groups.Group2:
			if(group2.get_child_count() > 0 && paused == false): #if the group has enemies
				group2.progress += g_move_speed * delta
				if(group2.progress_ratio >= 0.45 && p == false):
					paused = true
					for enemy in group2.get_children():
						enemy.emit._startShootin()
					var t =Timer.new()
					t.wait_time = 3.0
					t.one_shot = true
					add_child(t)
					t.start()
					await(t.timeout)
					paused = false
					p = true
			if(group2.get_child_count() == 0):
				CurrentGroup = Groups.Group3
