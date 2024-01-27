extends Area2D

var longest

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if $CollisionShape2D.disabled == false:
		$CollisionShape2D.scale.x += 0.25
		$CollisionShape2D.scale.y += 0.25
		$Bomb.scale.x += 0.25
		$Bomb.scale.y += 0.25
		if $CollisionShape2D.scale.x >= longest/15:
			$Bomb.visible = false
			$CollisionShape2D.disabled = true



func _on_player_bomb():
	longest = get_viewport_rect().size.x
	$CollisionShape2D.scale = Vector2(1, 1)
	$Bomb.scale = Vector2(1, 1)
	$Bomb.visible = true
	$CollisionShape2D.disabled = false


func _on_body_entered(body:Node2D):
	pass # Replace with function body.
