extends RigidBody2D

func _ready():
	pass

func _on_PachinkoBall_body_entered(body: Node) -> void:
	if body.is_in_group("peg"):
		SoundManager.play_and_forget("select", 0, rand_range(0.95, 1.15))