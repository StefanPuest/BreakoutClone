extends CharacterBody2D

@export var speed = 400
@export var is_big = false

func get_input():
	var input_direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = input_direction * speed

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if is_big:
		scale = Vector2(2, 1)
	else:
		scale = Vector2(1, 1)	

func _physics_process(delta: float) -> void:
	get_input()
	move_and_slide()
	
