extends Node3D

func _ready() -> void:
	# Populate the RayCasts node with the array of RayCasts
	for x in range(-40, 40):
		for y in range(-40, 40):
			var ray_cast = RayCast3D.new()
			ray_cast.target_position = Vector3(x, y, -31.0)
			ray_cast.enabled = true
			ray_cast.collide_with_bodies = true
			ray_cast.collision_mask = 1
			%RayCasts.add_child(ray_cast)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("flash"):
		$FlashSound.play()
		$Flash.visible = true
		$Timer.start()

	if $Flash.visible:
		for ray_cast in $RayCasts.get_children():
			if ray_cast.is_colliding():
				var collider = ray_cast.get_collider()
				if collider.name == "Monster":
					collider.hit_by_flash()

func _on_timer_timeout() -> void:
	$Flash.visible = false
