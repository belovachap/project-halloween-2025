extends CharacterBody3D

const SPEED = 10.0
var angered : bool = false
@export var player : CharacterBody3D

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	if angered:
		var direction = (player.global_position - global_position)
		velocity = direction.normalized() * SPEED
	else:
		velocity = Vector3.ZERO

	move_and_slide()

# When monster is hit by the player's camera flash
func hit_by_flash() -> void:
	if not $AudioStreamPlayer3D.playing:
		$AudioStreamPlayer3D.play()

	%MeshInstance3D.mesh.material.emission_enabled = true
	angered = true
	$AngerCooldownTimer.start()

func _on_anger_cooldown_timer_timeout() -> void:
	%MeshInstance3D.mesh.material.emission_enabled = false
	angered = false
