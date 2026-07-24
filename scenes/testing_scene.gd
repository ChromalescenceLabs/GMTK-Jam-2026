extends Node2D
@onready var npc: CharacterBody2D = $NPC

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Interact"):
		var STATE = npc.STATE
		npc.current_state = STATE.DISTRACTED
		npc.stay = true
