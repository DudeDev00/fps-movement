extends Camera3D

var look_input : Vector2 = Vector2()
@export var turn_rate : float = 200

var mouse_input : Vector2 = Vector2()
@export var mouse_sensitivity : float = 0.3


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	look_input = Input.get_vector("view_left", "view_right", "view_down", "view_up")
	look_input *= turn_rate * delta
	look_input += mouse_input
	mouse_input = Vector2()

	rotation_degrees.x += look_input.y
	rotation_degrees.y += look_input.x

	rotation_degrees.x = clampf(rotation_degrees.x, -60, 80)

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		mouse_input = event.relative * -mouse_sensitivity
	elif event is InputEventKey and event.keycode == KEY_ESCAPE and event.pressed:
		if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		elif Input.mouse_mode == Input.MOUSE_MODE_VISIBLE:
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

