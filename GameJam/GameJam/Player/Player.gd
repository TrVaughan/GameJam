extends KinematicBody2D

var velocity = Vector2.ZERO
var current_gravity : float

export var gravity : float = 660
export var move_speed = 10
export var max_move = 200
export var jump_power = 260
export var different_gravity_during_jump = false
export var jump_gravity : float = 660



var jump_vec : Vector2
var is_jumping = false
var direction = -1


var is_stunned = false
export var stun_duration = 1
export var stun_blink_speed = 20
var stun_countdown

# Called when the node enters the scene tree for the first time.
func _ready():
	jump_vec = Vector2(0, jump_power)
	current_gravity = gravity
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	

	pass

func _physics_process(delta):
	if is_on_floor(): velocity.y = 0
	if not is_stunned:
		
		var move_v = move_vector()
		velocity.x = ((move_speed) * move_v).x
		
		
		if(Input.is_action_just_pressed("jump") and is_on_floor() and not is_jumping):
			velocity.y = 0
			velocity.y -= jump_power
			is_jumping = true
			if different_gravity_during_jump:
				current_gravity = jump_gravity
			
		if(Input.is_action_just_released("jump") and is_jumping):
			if(different_gravity_during_jump):
				current_gravity = gravity
			is_jumping = false
			
	else:
		_be_stunned(delta)
	velocity.y += current_gravity * delta
	
	velocity.y = clamp(velocity.y, -max_move, max_move)
	
	if direction < 0 and not $Sprite.flip_h:
		$Sprite.flip_h = true
	if direction > 0 and $Sprite.flip_h:
		$Sprite.flip_h = false
	
	move_and_slide(velocity, Vector2.UP)
	
	
	
		
func move_vector():
	return Vector2(Input.get_action_strength("right") - Input.get_action_strength("left"), 1.0)

func _unhandled_input(event):
	if event.is_action_pressed("left"):
		direction = 1
	if event.is_action_pressed("right"):
		direction = -1

# todo, for bat hits
func _be_stunned(delta):
	if different_gravity_during_jump:
		current_gravity = gravity
	velocity.x = 0
	if stun_countdown <= 0:
		is_stunned = false
		visible = true
	else:
		if(sin(stun_countdown*stun_blink_speed) > 0.8 or sin(stun_countdown*stun_blink_speed) < -0.8):
			visible = true
		else:
			visible = false
		
		stun_countdown -= delta
	
	pass
	
func stun():
	if not is_stunned:
		is_stunned = true
		stun_countdown = stun_duration
	pass
	
