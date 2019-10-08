extends Node2D

var speed = 450
var size = Vector2(16, 64)
var screen_size = OS.get_window_size()

func _ready():
	resize()
	center()

func _process(delta: float) -> void:
	if Input.is_action_pressed("ui_up"):
		position.y -= speed * delta
	elif Input.is_action_pressed("ui_down"):
		position.y += speed * delta
	
	position.y = clamp(position.y, 0, screen_size.y - size.y)

func resize():
	$PaddleRect.rect_size = size
	$PaddleRect/Shadow.rect_size = size

func center():
	position.y = screen_size.y / 2 - size.y / 2