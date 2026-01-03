class_name Ball extends Area2D

const Block = preload("res://scene/block.tscn")

@export var speed = 2.0
@export var direction_modifier_strenth = 1
@export var damage = 100
@export var penetration = 1

var _block_penetration_counter = 0

var velocity = Vector2(0.0, 0.0)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	velocity = Vector2(0.2, 1.0).normalized() * speed
	connect("body_entered", _on_body_entered)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
	
func _reflect_ball(velocity_modifier: Vector2) -> void:
	velocity.y = -velocity.y	
	velocity += velocity_modifier
	velocity = velocity.normalized() * speed
	
	
func _physics_process(delta: float) -> void:
	position = position + velocity
	if position.x <= 0 or position.x >= get_viewport_rect().size.x:
		velocity.x = -velocity.x
		EventBus.on_ball_hit_wall.emit(self)
	if position.y <= 0:
		velocity.y = -velocity.y
	if position.y >= get_viewport_rect().size.y:
		EventBus.on_ball_left_playfield.emit(self)
		

func _on_body_entered(body: Node) -> void:
	var direction_modifier = Vector2(0.0, 0.0)
	
	print("_on_body_entered")
	
	if body.get_class() == "StaticBody2D":
		if _block_penetration_counter >= penetration or not body.hit(0):
			_reflect_ball(direction_modifier)
		else:
			_block_penetration_counter += 1
		EventBus.on_ball_hit_block.emit(self, body)
	elif body.get_class() == "CharacterBody2D":
		EventBus.on_ball_hit_paddle.emit(self)
		direction_modifier = body.velocity.normalized() * direction_modifier_strenth
		_reflect_ball(direction_modifier)
		_block_penetration_counter = 0
	
	$CPUParticles2D.direction = velocity
