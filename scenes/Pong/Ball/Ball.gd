extends Node2D

signal out_of_screen(side)

export(int) var initial_speed = 200
export(float) var speed_multiplier = 1.2
export(float) var max_speed = 300

var screen_size = OS.get_window_size()
var speed
var paddle_size
var direction

onready var paddles = get_tree().get_nodes_in_group("paddle")
onready var player_paddles = get_tree().get_nodes_in_group("player_paddle")
onready var ai_paddles = get_tree().get_nodes_in_group("ai_paddle")

enum {
	UP = -1,
	DOWN = 1,
	LEFT = -1,
	RIGHT = 1
}

func _ready():
	reset()
	connect("out_of_screen", self, "_on_out_of_screen")

func _process(delta: float) -> void:
	position += direction * speed * delta
	
	var dir_y = sign(direction.y)
	if ((position.y < 0 and dir_y == UP) or
		(position.y > screen_size.y and dir_y == DOWN)):
		direction.y = -direction.y
		# play bop sound
		SoundManager.play_and_forget("select", 0, rand_range(0.95, 1.05))
	
	var dir_x = sign(direction.x)
	for paddle in paddles:
		var paddle_rect = Rect2(paddle.position.x, paddle.position.y, paddle.size.x, paddle.size.y)
		if (
			paddle.is_in_group("player_paddle") and 
			paddle_rect.has_point(position) and 
			dir_x == sign(-paddle.position.x)
			) or (
			paddle.is_in_group("ai_paddle") and
			paddle_rect.has_point(position) and
			dir_x == sign(paddle.position.x)
			):
			direction.x = -direction.x
			speed = min(speed * speed_multiplier, max_speed)
			direction.y = randf() * 2.0 - 1
			direction = direction.normalized()
			# play bop sound
			SoundManager.play_and_forget("select", 0, rand_range(0.95, 1.05))
	
	
	if position.x < 0:
		emit_signal("out_of_screen", LEFT)
	elif position.x > screen_size.x:
		emit_signal("out_of_screen", RIGHT)

func reset():
	speed = initial_speed
	direction = Vector2(sign(randf()*2.0 - 1), 0)
	position = Vector2(256, 208)
	SoundManager.play_and_forget("bongagong", 0, rand_range(0.95, 1.05))

func _on_out_of_screen(side):
	reset()