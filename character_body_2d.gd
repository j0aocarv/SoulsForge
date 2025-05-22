extends CharacterBody2D

var _state_machine

@export_category("Variables")
@export var _move_speed: float = 85.0
@export var _friction: float = 0.8
@export var _acceleration: float = 0.4

@export_category("Objects")
@export var _animation_tree: AnimationTree = null

func _ready() -> void:
	_state_machine = _animation_tree["parameters/playback"]

func _physics_process(_delta: float) -> void:
	_move()
	_animate()

func _move() -> void:
	var _direction: Vector2 = Vector2(
		Input.get_axis("move_left", "move_right"),
		Input.get_axis("move_up", "move_down")
	)

	if _direction != Vector2.ZERO:
		_animation_tree["parameters/idle/blend_position"] = _direction
		_animation_tree["parameters/walk/blend_position"] = _direction

		_direction = _direction.normalized()
		velocity.x = lerp(velocity.x, _direction.x * _move_speed, _acceleration)
		velocity.y = lerp(velocity.y, _direction.y * _move_speed, _acceleration)
	else:
		velocity.x = lerp(velocity.x, 0.0, _friction)
		velocity.y = lerp(velocity.y, 0.0, _friction)

	move_and_slide()

func _animate() -> void:
	if velocity.length() > 1:
		_state_machine.travel("walk")
	else:
		_state_machine.travel("idle")
