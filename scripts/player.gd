extends CharacterBody2D

@export var speed : float = 200

func get_player_input():
	var direction := Input.get_vector("Left", "Right", "Up", "Down")
	velocity = direction * speed

func _physics_process(delta: float) -> void:
	get_player_input()
	move_and_slide()
