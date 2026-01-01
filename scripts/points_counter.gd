extends Label


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	EventBus.on_points_earned.connect(_on_points_earned)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_points_earned(points: int) -> void:
	GameState.points_count += points
