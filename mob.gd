extends CharacterBody2D

const SPEED = 300

## Number of hits the slime is able to compensate 
var health = 3

## Connect the mob with the player
##var player

## Forces the script to wait until every node is created
##func _ready():
##	player = get_node("/root/Game/Player")

## Short version, without _ready() funciont
@onready var player = get_node("/root/Game/Player")

func _ready():
	%Slime.play_walk()


func _physics_process(delta):
	## Calculate the direction to the player
	## -> global_position delivers the position of a node and 
	## is able to calculate the direction to another node
	var direction = global_position.direction_to(player.global_position)
	
	## Make the mob a bit slower than the player
	velocity = direction * SPEED
	
	move_and_slide()


func take_damage():
	health -= 1
	%Slime.play_hurt()
	
	if health == 0:
		queue_free()
		const SMOKE_SCENE = preload("res://smoke_explosion/smoke_explosion.tscn")
		var smoke = SMOKE_SCENE.instantiate()
		
		## We add the smoke to the parent, otherwise it would be 
		## deleted (queue_free()) with the slime
		get_parent().add_child(smoke)
		smoke.global_position = global_position



