extends Node2D


@export var Block_scene: PackedScene = preload("res://scene/block.tscn")
@export var Ball_scene: PackedScene
@export var Block_Color_Palette: ColorPalette
@export var Block_Explosion: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	randomize()
	
	$Paddle.position = Vector2(400, 560)
	$PointsCounter.text = str(GameState.points_count)
	
	for x in 20:
		for y in 10:
			var block = Block_scene.instantiate()
			add_child(block)
			block.position.x = 5 + (50 * x)
			block.position.y = 30 + (y * 20)
			block.set_values(200 - (y * 50), 100 - (y * 10))

	EventBus.on_ball_hit_block.connect(_on_ball_hit_block)
	EventBus.on_ball_left_playfield.connect(_on_ball_left_playfield)
	EventBus.on_explosion_hit_block.connect(_on_explosion_hit_block)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_ball_hit_block(ball: Ball, block: Block) -> void:
	if block.hit(ball.damage): _remove_block(block)
		
func _remove_block(block: Block) -> void:
	#_roll_items(block)		
	remove_child(block)
	EventBus.on_points_earned.emit(block.points)
	$PointsCounter.text = str(GameState.points_count)	

func _add_ball(position: Vector2, velocity: Vector2) -> void:
	var ball = Ball_scene.instantiate()
	get_tree().current_scene.call_deferred("add_child", ball)
	ball.position = position
	ball.velocity = velocity
	GameState.balls_in_game += 1
	
func _roll_items(block: Block) -> void:
	var random_item = randi() % 10
	if random_item == 1:
		_add_ball(block.position, Vector2(0.0, -1.0))
	elif random_item == 2:
		EventBus.on_paddle_grow_item.emit()
	elif random_item == 3:
		_generate_explostion(block)
		
func _generate_explostion(block: Block) -> void:
	EventBus.on_explosion.emit()
	var explosion = Block_Explosion.instantiate()
	# magical value here, this is the center of the block
	explosion.position = block.position + Vector2(20, 4)
	get_tree().current_scene.call_deferred("add_child", explosion)
	explosion.find_child("CPUParticles2D").emitting = true
		
func _on_ball_left_playfield(ball: Ball) -> void:
	print(GameState.balls_in_game)
	GameState.balls_in_game -= 1
	remove_child(ball)
	if GameState.balls_in_game <= 0:
		print("game over")

func _on_explosion_hit_block(explosion: Explosion, block: Block) -> void:
	_remove_block(block)
