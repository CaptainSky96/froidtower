extends CharacterBody2D


const SPEED = 360.0
const JUMP_VELOCITY = -24.0
var accelaration_0 = 0.1
var accelaration_1 = 0.075
var accelaration_2 = 0.05
var accelaration_3 = 0.025
var friction = 0.5
var air_friction = 0.02
var air_accelaration = randf_range(0.1,0.136)

func _physics_process(delta: float) -> void:
	
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		var cur_speed = abs(direction * velocity.x)
		if cur_speed < 90:
			velocity.x = lerp(velocity.x, direction * SPEED, accelaration_0)
		elif cur_speed > 90 and cur_speed < 180:
			velocity.x = lerp(velocity.x, direction * SPEED, accelaration_1)
		elif cur_speed > 180 and cur_speed < 270:
			velocity.x = lerp(velocity.x, direction * SPEED, accelaration_2)
		elif cur_speed > 270:
			velocity.x = lerp(velocity.x, direction * SPEED, accelaration_3)
			
	elif not direction and (velocity.y <= -10 or velocity.y >= 10):
		velocity.x = lerp(velocity.x, 0.0, air_friction)
	else:
		velocity.x = lerp(velocity.x, 0.0, friction)
	
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		if velocity.x > 136:
			velocity.y = lerp(velocity.y, velocity.x * JUMP_VELOCITY, air_accelaration)
		elif velocity.x < -136:
			velocity.y = lerp(velocity.y, -velocity.x * JUMP_VELOCITY, air_accelaration)
		else:
			velocity.y = -360.0
	
	if not is_on_floor():
		if Input.is_action_just_released("ui_accept") and velocity.y < 0:
			velocity.y = lerp(velocity.y, (delta * 1.36), 0.36)
		velocity += get_gravity() * ( delta * 1.36 )
	
	move_and_slide()
