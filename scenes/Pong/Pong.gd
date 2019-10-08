extends Control

func _ready():
	pass

func _process(delta: float) -> void:
	$AIPaddle.position.y = $Ball.position.y - $AIPaddle.size.y / 2
