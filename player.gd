extends CharacterBody2D

signal health_depleted

var health = 100.0

func _physics_process(delta):
	
	## The arguments for the ge_vector can be customized in the 
	## input map, in the preferences
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	
	## Multiply the direction with 600 pixel per second
	velocity = direction * 600
	move_and_slide()
	
	if velocity.length() > 0.0:
		%HappyBoo.play_walk_animation()
	else:
		%HappyBoo.play_idle_animation()
	
	## Factor of damage the decreases the health of the player
	const DAMAGE_RATE = 5.0
	
	var overlapping_mob = %HurtBox.get_overlapping_bodies()
	
	if overlapping_mob.size() > 0:
		health -= DAMAGE_RATE * overlapping_mob.size() * delta
		%ProgressBar.value = health
		
		if health <= 0.0:
			## Init a signal for the UI to quit the game
			health_depleted.emit()

