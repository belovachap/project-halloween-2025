extends CharacterBody3D

const SPEED = 5.0
var angered : bool = false
@export var player : CharacterBody3D

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	if angered:
		# needs to persue the player
		pass
	else:
		var direction := (transform.basis * Vector3(randf_range(-0.1, 0.1), 0, randf_range(-0.1, 0.1))).normalized()
		if direction:
			velocity.x = direction.x * SPEED
			velocity.z = direction.z * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
			velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()

func hit_by_flash() -> void:
	$AudioStreamPlayer3D.play()
	angered = true
	$AngerCooldownTimer.start()

func _on_anger_cooldown_timer_timeout() -> void:
	angered = false
