extends CharacterBody2D

const SPEED : float = 100

func _physics_process(_delta: float) -> void:
	get_player_input()

func get_player_input():
	var direction := Input.get_vector("Left", "Right", "Up", "Down")
	velocity = direction * SPEED
			
	move_and_slide()
