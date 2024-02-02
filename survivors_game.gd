extends Node2D

func spawn_mob():
	var new_mob = preload("res://mob.tscn").instantiate()
	
	## Set the progress ratio of the path to a random float
	%PathFollow2D.progress_ratio = randf()
	
	new_mob.global_position = %PathFollow2D.global_position
	
	## Add the new slime as a child of the game node
	add_child(new_mob)



func _on_timer_timeout():
	spawn_mob()


func _on_player_health_depleted():
	%GameOver.visible = true
	get_tree().paused = true
