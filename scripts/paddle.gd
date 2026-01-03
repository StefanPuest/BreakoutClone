extends CharacterBody2D

@export var speed = 400
@export var is_big = false

func get_input():
	var input_direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = input_direction * speed

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	EventBus.connect("on_paddle_grow_item", _on_paddle_grow)
	$PaddleGrowTimerIndicator.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if is_big:
		var timer_progress = 1.0 - (($PaddleGrowTimer.wait_time - $PaddleGrowTimer.time_left) / $PaddleGrowTimer.wait_time)
		$PaddleGrowTimerIndicator.scale = Vector2(timer_progress, 1.0)

func _physics_process(delta: float) -> void:
	get_input()
	move_and_slide()
	
func _on_paddle_grow() -> void:
	$PaddleGrowTimer.start()
	$PaddleGrowTimerIndicator.visible = true
	is_big = true
	scale = Vector2(2, 1)

func _on_paddle_grow_timer_timeout() -> void:
	is_big = false
	scale = Vector2(1, 1)
	$PaddleGrowTimerIndicator.visible = true
