extends Area2D

func _physics_process(delta):
	
	## Returns an array of all enemies in range
	var enemies_in_range = get_overlapping_bodies()
	
	if enemies_in_range.size() > 0:
		
		## Get the first enemy from the array
		## var target = enemies_in_range[0]
		var target_enemy = enemies_in_range.front()
		
		## look_at is available in most of the 2D nodes
		look_at(target_enemy.global_position)


func shoot():
	
	## To load files: 
		## Loads on demand: load()
		## Load at the start of the game: preload()
	
	## Store a reference to the bullet
	const BULLET = preload("res://bullet.tscn")
	
	## Create a new instance
	var new_bullet = BULLET.instantiate()
	
	## Place the new bullet instance at the "%Shooting Point"
	new_bullet.global_position = %ShootingPoint.global_position
	
	## Rotate the new bullet in the same angle the gun is rotated
	new_bullet.global_rotation = %ShootingPoint.global_rotation
	
	## Add the bullet to the shooting point
	%ShootingPoint.add_child(new_bullet)
 

## Timer starts automaticlc and waits 0.3 seconds after each shot 
func _on_timer_timeout():
	
	## Safe bullets: shoot only if there are some enemies to shoot at
	var enemies_in_range = get_overlapping_bodies()
	
	if enemies_in_range.size() > 0:
		shoot()
