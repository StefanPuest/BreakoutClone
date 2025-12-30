extends StaticBody2D


@export var points = 100
@export var color = Color(1.0, 0.435, 1.0, 1.0)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func set_color(color: Color) -> void:
	$Polygon2D.color = color
