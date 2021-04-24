extends Node

var HUD
var lives_saved = 0
var total_lives : int = 10
export var time_limit : float = 120 # in seconds
var timer
var game_over : bool

func _ready():
	game_over = false
	HUD = get_tree().current_scene.get_node_or_null("UI/HUD")
	total_lives = get_tree().current_scene.get_node("Sick_Person Container").get_child_count()
	timer = get_tree().create_timer(time_limit)
	

func _process(delta):
	if timer != null:
		update_UI()
		if not game_over and timer.get_time_left() <= 0:
			print("GAME OVER TRIGGERED")
			game_over = true
			gameover()


func gameover():
	get_tree().change_scene("res://Game Over.tscn")
	pass
	
func restart():
	game_over = false
	HUD = get_tree().current_scene.get_node_or_null("UI/HUD")
	timer = get_tree().create_timer(time_limit)

func update_UI():
	if(HUD != null):
		HUD.find_node("Timer").text = "Time: " +  str(int((timer.get_time_left())))
		HUD.find_node("Score").text = "Lives Saved: " + str(lives_saved) + "/" + str(total_lives)
	else:
		HUD = get_tree().current_scene.get_node_or_null("UI/HUD")

