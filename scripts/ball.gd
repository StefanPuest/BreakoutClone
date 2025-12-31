extends Area2D

const Block = preload("res://scene/block.tscn")

@export var speed = 2
@export var direction_modifier_strenth = 1

signal left_playfield(ball: Area2D)
signal hit_block(block: Node)

var velocity = Vector2(0.0, 0.0)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	velocity = Vector2(0.2, 1.0).normalized() * speed


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
	if position.y <= 0:
		velocity.y = -velocity.y
	if position.y >= get_viewport_rect().size.y:
		emit_signal("left_playfield", self)
		

func _on_body_entered(body: Node) -> void:
	var direction_modifier = Vector2(0.0, 0.0)
	
	if body.get_class() == "StaticBody2D":
		print("block hit")
		emit_signal("hit_block", body)
	elif body.get_class() == "CharacterBody2D":
		direction_modifier = body.velocity.normalized() * direction_modifier_strenth
	_reflect_ball(direction_modifier)
