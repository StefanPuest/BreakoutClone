extends Node

signal on_ball_left_playfield(ball: Ball)
signal on_ball_hit_block(ball: Ball, block: Block)
signal on_ball_hit_paddle(ball: Ball)
signal on_ball_hit_wall(ball: Ball)

signal on_explosion_hit_block(explosion: Explosion, block: Block)
signal on_explosion()

signal on_points_earned(points: int)

signal on_paddle_grow_item()
