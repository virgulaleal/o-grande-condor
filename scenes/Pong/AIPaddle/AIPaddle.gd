extends Node2D

var speed = 450
var size = Vector2(16, 64)
var screen_size = OS.get_window_size()

func _ready():
	resize()
	center()

func resize():
	$PaddleRect.rect_size = size
	$PaddleRect/Shadow.rect_size = size

func center():
	position.y = screen_size.y / 2 - size.y / 2