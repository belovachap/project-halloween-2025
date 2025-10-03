extends Node3D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("flash"):
		$FlashSound.play()
		$Flash.visible = true
		$Timer.start()

	if $Flash.visible:
		if $ShapeCast3D.is_colliding():
			for i in range($ShapeCast3D.get_collision_count()):
				var collider = $ShapeCast3D.get_collider(i)
				# Process the collision information
				#print("Collision detected:")
				#print("  Collider: ", collider.name)
				
				# if the monster is in range of the camera flash
				if collider.name == "Monster":
					collider.hit_by_flash()

func _on_timer_timeout() -> void:
	$Flash.visible = false
