extends Node

@onready var blink_time = $BlinkTime
@onready var duration = $Duration
var blink_object : Node2D

func start_blinking(object, dur):
    blink_object = object
    duration.wait_time = dur
    duration.start()
    blink_time.start()


func _on_duration_timeout():
    blink_time.stop()
    blink_object.visible = true

func _on_blink_time_timeout():
    blink_object.visible = not blink_object.visible
