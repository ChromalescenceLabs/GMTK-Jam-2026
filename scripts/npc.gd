extends CharacterBody2D

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var nav: NavigationAgent2D = $NavigationAgent2D

var speed : float = 100
enum STATE { IDLE, PATH, DISTRACTED }
var current_state : STATE = STATE.PATH
var current_pos : Vector2

@export var points : Array[Marker2D]

func _physics_process(_delta: float) -> void:
	_state_set()
	_navigate()
	
func _pick_point():
	var randpoint = points.pick_random().global_position
	if randpoint != current_pos:
		nav.target_position = randpoint
		current_pos = randpoint
	
func _state_set() -> void:
	if nav.is_navigation_finished() and current_state != STATE.IDLE:
		_pick_point()
		current_state = STATE.PATH
		
func _navigate():
	match current_state:
		STATE.PATH:
			speed = 100
			var next_path_position: Vector2 = nav.get_next_path_position()
			velocity = (
				global_position.direction_to(next_path_position) * speed
			)
			sprite_2d.rotation = velocity.angle() - (TAU / 4)
			move_and_slide()
		STATE.IDLE:
			speed = 0

func _on_navigation_agent_2d_target_reached() -> void:
	set_physics_process(false)
	current_state = STATE.IDLE
	await get_tree().create_timer(randi_range(4, 5)).timeout
	current_state = STATE.PATH
	set_physics_process(true)
