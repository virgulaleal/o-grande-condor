extends Control

var dispenser_speed = 1.5
var dispenser_direction = directions.left
enum directions {
	right,
	left
}

onready var dispenser = $PachinkoDispenser
onready var tween = $PachinkoDispenser/Tween
onready var ball = load("res://scenes/Pachinko/PachinkoBall/PachinkoBall.tscn")

var boards = [
	load("res://scenes/Pachinko/Boards/BabyBoard.tscn"),
	load("res://scenes/Pachinko/Boards/BichinhoBoard.tscn"),
	load("res://scenes/Pachinko/Boards/ZigueBoard.tscn")
]

func _ready():
	SoundManager.play_and_forget("searching-for-amigos")
	$BoardBuffer.remove_child($BoardBuffer/Board)
	var new_board = Random.choose(boards)
	$BoardBuffer.add_child(new_board.instance())

func _process(delta: float) -> void:
	if dispenser.position.x >= 432:
		slide_dispenser(directions.left)
	
	elif dispenser.position.x <= 80:
		slide_dispenser(directions.right)
	
	if Input.is_action_just_pressed("J"):
		engage_dispenser()

func slide_dispenser(direction) -> void:
	match direction:
		directions.left:
			tween.interpolate_property(
				dispenser,
				"position",
				dispenser.position,
				Vector2(80, 0),
				dispenser_speed,
				Tween.TRANS_LINEAR,
				Tween.EASE_IN_OUT
			)
			tween.start()
			dispenser_direction = directions.right
		
		directions.right:
			tween.interpolate_property(
				dispenser,
				"position",
				dispenser.position,
				Vector2(432, 0),
				dispenser_speed,
				Tween.TRANS_LINEAR,
				Tween.EASE_IN_OUT
			)
			tween.start()
			dispenser_direction = directions.left

func engage_dispenser(amount = 1):
	var impulse: Vector2
	var imp_variance_x = rand_range(100, 400)
	var imp_variance_y = rand_range(50, 220)
	match dispenser_direction:
		directions.right:
			impulse = Vector2(-imp_variance_x, imp_variance_y)
		directions.left:
			impulse = Vector2(imp_variance_x, imp_variance_y)
	SoundManager.play_and_forget("bongagong", 0, rand_range(0.8, 1.2))
	spawn_balls(dispenser.position, impulse, amount)

func spawn_balls(position: Vector2, impulse: Vector2, amount: int = 1) -> void:
	for index in amount:
		var new_ball = ball.instance()
		add_child(new_ball)
		new_ball.position = position
		new_ball.apply_central_impulse(impulse)