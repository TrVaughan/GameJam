extends Node2D


# Declare member variables here. Examples:
# var a = 2
var saved = false
export var male_skin : Texture
export var female_skin : Texture

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	var rand = randf()
	if rand > 0.5:
		$Sprite.texture = male_skin
	else:
		$Sprite.texture = female_skin
		
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Area2D_body_entered(body):
	if not saved and body.name == "Player":
		save()


func save():
	saved = true
	$Sprite.visible = false
	Global.lives_saved = Global.lives_saved + 1
	
