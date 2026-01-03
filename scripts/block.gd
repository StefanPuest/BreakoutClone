class_name Block extends StaticBody2D


@export var points = 100
@export var color = Color(1.0, 0.435, 1.0, 1.0)
@export var health = 300
@export var color_palette: ColorPalette = preload("res://assets/block_colors.tres")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func set_values(start_health: int, points_on_destuction: int) -> void:
	health = start_health
	points = points_on_destuction
	$Polygon2D.color = color_palette.colors[health / 100]

func hit(damage: int) -> bool:
	health -= damage
	print("hit")
	print(health)
	$Polygon2D.color = color_palette.colors[health / 100]
	if health <= 0:
		return true
	return false
