extends Node2D


# Declare member variables here. Examples:
# var a = 2
var saved = false
export var fadespeed : float = 1
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

func _on_Area2D_body_entered(body):
	if not saved and body.name == "Player":
		save()


func save():
	saved = true
	$Particles2D.emitting = true
	Global.lives_saved = Global.lives_saved + 1
	
func _process(delta):
	if saved:
		_fade(delta)

func _fade(delta):
	# based on the number of sick people we have, we really don't even need to queue free at the end
	modulate.a -= delta*fadespeed
	pass
