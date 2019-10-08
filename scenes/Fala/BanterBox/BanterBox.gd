extends Control

func _ready():
	var new_friend = AmigoManager.get_random_amigo(1)
	$Frame/Portrait/Boneco.initialize(AmigoManager.amigos[new_friend.species], new_friend)
	$Fala.output(FalaManager.emotion_alignment_banter(new_friend))
	#yield(get_tree().create_timer(1.5), "timeout")
	#get_tree().reload_current_scene()