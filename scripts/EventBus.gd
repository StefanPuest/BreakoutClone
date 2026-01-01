extends Node

signal on_ball_left_playfield(ball: Area2D)
signal on_ball_hit_block(block: Node)
signal on_ball_hit_paddle(ball: Area2D)

signal on_explosion_hit_block(explosion: Node, block: Node)
signal on_explosion()

signal on_points_earned(points: int)
