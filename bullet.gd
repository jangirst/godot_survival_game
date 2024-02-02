extends Area2D

var travelled_distance = 0

func _physics_process(delta):
	const SPEED = 1000.0	## Range of tht gun
	const RANGE = 1200.0	## Speed of tht bullet
	
	## Set the direction of the bullet to the direction of the gun
	## Vector2.RIGHT creates a vector pointing right - Vector2 (1,0)
	## The projectile.png is pointing to the rigth.
	var direction = Vector2.RIGHT.rotated(rotation)
	
	## The multiplication with delta makes the movement time dependent
	position += direction * SPEED * delta
	
	## Increase the travelled distance on each frame
	travelled_distance += SPEED * delta
	
	## Deletes the bullet after 1200 pixels (RANGE) on screen
	if travelled_distance > RANGE:
		queue_free()

## Add a signal (like an event) to the bullet
## The entered code gets executed if the bullet hits the mob
func _on_body_entered(body):
	## This methods waits for execution of the rest of the following code
	queue_free()
	
	## Only the enemies will take damage from the projectile
	## "Duck typing" --> call the "take_damage" methode safely 
	if body.has_method("take_damage"):
		body.take_damage()
