extends Control

onready var tween: Tween = $Tween

func _ready():
	output("só é possível adentrar até a metade do mais estéril dos desertos;\nentão estará partindo.")
	#output(FalaManager.emotion_alignment_banter(AmigoManager.player_party[0]))
	#output(FalaManager.get_random_notification())
	pass

func output(output_text: String, frequency: float = 0.05, delay: float = 0):
	$Panel/Label.percent_visible = 0
	$Panel/Label.text = output_text
	tween.interpolate_property(
		$Panel/Label,
		"percent_visible",
		0,
		1,
		output_text.length() * frequency,
		Tween.EASE_IN,
		Tween.EASE_IN_OUT,
		3#delay
	)
	tween.start()
	SoundManager.play("voice", "vmu_error", 0, rand_range(0.9, 1.5))
	$Timer.start(0.24)

func _on_Timer_timeout() -> void:
	if $Panel/Label.visible_characters > 0:
		var random_pitch = rand_range(0.9, 1.5)
		#$Timer.wait_time = 0.24 * random_pitch + 0.01
		SoundManager.play("voice", "vmu_error", 0, random_pitch)
		print("looksie: ", $Panel/Label.visible_characters)
	else:
		print("stop")
		$Timer.stop()
