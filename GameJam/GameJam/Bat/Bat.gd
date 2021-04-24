extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var roam_distance : float = 10
export var roam_speed : float = 100
var direction = 1  # 1 goes right, -1 goes left.
var start_pos : Vector2
# Called when the node enters the scene tree for the first time.
func _ready():
	start_pos = position
	pass # Replace with function body.

func _process(delta):
	
	if direction < 0 and not $Sprite.flip_h:
		$Sprite.flip_h = true
	if direction > 0 and $Sprite.flip_h:
		$Sprite.flip_h = false
	
	
	
	if direction == 1:
		if position.x >= start_pos.x + roam_distance:
			direction = -1
		else:
			position.x += roam_speed*delta
	else:
		if position.x <= start_pos.x - roam_distance:
			direction = 1
		else:
			position.x -= roam_speed*delta
		

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Area2D_body_entered(body):
	if body.name == "Player":
		body.stun()
	pass # Replace with function body.
