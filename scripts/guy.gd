extends CharacterBody2D

const GRAVITY = 1300.0

@export var max_ground_tilt: float = 0.70 
@export var angular_acceleration: float = 35.0 
@export var pivot_offset: Vector2 = Vector2(0, 80) 

var angular_velocity: float = 0.0
var jump_charge: float = 0.0
const MAX_CHARGE_TIME: float = 0.5
const BASE_BOUNCE: float = 500.0
const MAX_BOUNCE_BONUS: float = 600.0

var ground_pivot_pos: Vector2 = Vector2.ZERO
var was_on_floor: bool = false

func _physics_process(delta: float) -> void:
	var tilt_input := Input.get_axis("ui_left", "ui_right")

	if not is_on_floor():
		if was_on_floor:
			was_on_floor = false

		velocity.y += GRAVITY * delta
		
		if tilt_input != 0:
			angular_velocity += tilt_input * angular_acceleration*1.5 * delta
			angular_velocity = clamp(angular_velocity, -10.0, 10.0)
		else:
			var return_spring = -rotation * 35.0 
			angular_velocity += return_spring * delta
			angular_velocity = move_toward(angular_velocity, 0.0, 25.0 * delta)
			
			
		angular_velocity = clamp(angular_velocity, -18.0, 18.0)
		rotation += angular_velocity * delta
		
		velocity.x = move_toward(velocity.x, tilt_input * 400.0, 300.0 * delta)
		move_and_slide()
		
	else:
		if abs(rotation) > max_ground_tilt:
			was_on_floor = false
			velocity.y += GRAVITY * delta
			velocity.x = move_toward(velocity.x, 0.0, 500.0 * delta)
			
			angular_velocity = 0.0
			rotation = lerp_angle(rotation, 0.0, 10.0 * delta)
			move_and_slide()
			
		else:
			if not was_on_floor:
				ground_pivot_pos = global_position + pivot_offset.rotated(rotation)
				was_on_floor = true
				angular_velocity = 0.0
			
			global_position = ground_pivot_pos - pivot_offset.rotated(rotation)
			velocity = Vector2.ZERO
			
			if tilt_input != 0:
				angular_velocity += tilt_input * (angular_acceleration * 1.5) * delta
			else:
				var return_spring = -rotation * 35.0 
				angular_velocity += return_spring * delta
				angular_velocity = move_toward(angular_velocity, 0.0, 25.0 * delta)
				
			rotation += angular_velocity * delta
			rotation = clamp(rotation, -max_ground_tilt, max_ground_tilt)
			
			if Input.is_action_pressed("ui_accept"):
				jump_charge = min(jump_charge + delta, MAX_CHARGE_TIME)
			elif Input.is_action_just_released("ui_accept") or (jump_charge > 0 and not Input.is_action_pressed("ui_accept")):
				var charge_ratio = jump_charge / MAX_CHARGE_TIME
				var total_bounce_power = BASE_BOUNCE + (MAX_BOUNCE_BONUS * charge_ratio)
				
				was_on_floor = false
				var bounce_direction = Vector2.UP.rotated(rotation)
				velocity = bounce_direction * total_bounce_power
				
				angular_velocity = tilt_input * 8.0
				jump_charge = 0.0
				move_and_slide()
