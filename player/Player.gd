extends KinematicBody2D

var speed = 200 # Speed of character in pixels per second
var velocity = Vector2.ZERO 
const FRICTION = 400

onready var animationPlayer = $Animation
onready var sprite = $Sprite

var last_input = Vector2.ZERO

func _physics_process(_delta):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized() # Ensure the length of vector is 1
	
	if input_vector != Vector2.ZERO:
		last_input = input_vector  # Store the last input direction
		velocity = input_vector * speed
		# Check the direction and change animation accordingly
		if input_vector.x > 0:
			sprite.flip_h = false  # No need to flip for right movement
			animationPlayer.play("RunRight")
		elif input_vector.x < 0:
			sprite.flip_h = true  # Flip the sprite for left movement
			animationPlayer.play("RunRight")
		if input_vector.y > 0:
			sprite.flip_h = false  # No need to flip for downward movement
			animationPlayer.play("RunDown")
		elif input_vector.y < 0:
			sprite.flip_h = false  # No need to flip for upward movement
			animationPlayer.play("RunUp")
	else: 
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION)
		# Choose the idle animation based on the last input direction
		if last_input.x > 0:
			sprite.flip_h = false  
			animationPlayer.play("IdleRight")
		elif last_input.x < 0:
			sprite.flip_h = true  
			animationPlayer.play("IdleRight")
		if last_input.y > 0:
			sprite.flip_h = false  
			animationPlayer.play("IdleDown")
		elif last_input.y < 0:
			sprite.flip_h = false  
			animationPlayer.play("IdleUp")

	velocity = move_and_slide(velocity)
