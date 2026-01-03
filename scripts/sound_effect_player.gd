extends AudioStreamPlayer2D

const paddle_hit_effect = preload("res://assets/audio/paddle_hit.wav")
const block_hit_effect = preload("res://assets/audio/block_hit.wav")
const paddle_growth_effect = preload("res://assets/audio/paddle_growth.wav")
const explosion_effect = preload("res://assets/audio/explosion.wav")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	EventBus.on_ball_hit_paddle.connect(_on_ball_hit_paddle)
	EventBus.on_ball_hit_block.connect(_on_ball_hit_block)
	EventBus.on_explosion.connect(_on_explosion)
	EventBus.on_ball_hit_wall.connect(_on_ball_hit_wall)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_ball_hit_paddle(ball: Area2D) -> void:
	stream = paddle_hit_effect
	play()
	
func _on_ball_hit_block(ball: Area2D, block: Node) -> void:
	stream = block_hit_effect
	play()
	
func _on_explosion() -> void:
	stream = explosion_effect
	play()	
	
func _on_ball_hit_wall(ball: Area2D) -> void:
	stream = paddle_hit_effect
	play()	
