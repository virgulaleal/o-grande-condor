extends Node2D

export(bool) var rolling = true
export(float) var speed = 128

func _process(delta: float) -> void:
	if rolling:
		$Sprite.region_rect.position.x += speed * delta