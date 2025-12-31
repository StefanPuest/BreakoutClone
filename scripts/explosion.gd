extends RigidBody2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	

func _on_body_entered(body: Node) -> void:
	#emit_signal("hit_block", body)
	#EventBus.on_explosion_hit_block.emit(body)
	EventBus.emit_signal("on_explosion_hit_block", self, body)
	print("explode HIT")
