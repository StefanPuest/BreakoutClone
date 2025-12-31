extends Node2D


@export var Block: PackedScene
@export var Ball_scene: PackedScene
@export var Block_Color_Palette: ColorPalette
@export var Block_Explosion: PackedScene


var points_count = 0
var balls_in_game = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	randomize()
	
	$paddle.position = Vector2(400, 560)
	$Points.text = str(points_count)
	
	for x in 20:
		for y in 10:
			var block = Block.instantiate()
			add_child(block)
			block.position.x = 5 + (50 * x)
			block.position.y = 30 + (y * 20)
			block.points = 100 - (y * 10)
			block.set_color(Block_Color_Palette.colors[y / 2])
		

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_ball_left_playfield(ball: Area2D) -> void:
	print(balls_in_game)
	balls_in_game -= 1
	remove_child(ball)
	if balls_in_game <= 0:
		print("game over")


func _on_ball_hit_block(block: Node) -> void:
	_remove_block(block)
	_roll_items(block)
		
func _remove_block(block: Node) -> void:
	remove_child(block)
	points_count += block.points
	$Points.text = str(points_count)			

func _add_ball(position: Vector2, velocity: Vector2) -> void:
	var ball = Ball_scene.instantiate()
	get_tree().current_scene.call_deferred("add_child", ball)
	ball.position = position
	ball.velocity = velocity
	ball.hit_block.connect(_on_ball_hit_block)
	balls_in_game += 1
	
func _roll_items(block: Node) -> void:
	var random_item = randi() % 10
	if random_item == 1:
		_add_ball(block.position, Vector2(0.0, -1.0))
	elif random_item == 2:
		$paddle.is_big = true
	elif random_item == 3:
		var explosion = Block_Explosion.instantiate()
		explosion.position = block.position
		get_tree().current_scene.call_deferred("add_child", explosion)
		explosion.find_child("CPUParticles2D").emitting = true
		explosion.hit_block.connect(_on_explosion_hit_block)
		print("EXPLODE BALL")
	elif random_item == 4:
		print("MAGNETIC PADDLE")	

func _on_explosion_hit_block(block: Node) -> void:
	print("exploded block")
	remove_child(block)
