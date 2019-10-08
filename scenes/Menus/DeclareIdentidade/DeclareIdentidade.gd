extends Control

var state = states.idle

enum states {
	idle
}

func _ready():
	set_random_background()

func _process(delta: float) -> void: match state:
	states.idle:
		if Input.is_action_just_pressed("J"):
			identity_chosen("rappi")
		if Input.is_action_just_pressed("K"):
			identity_chosen("raissa")

func identity_chosen(identidade):
	var possible_congratulations: Array = [
		"uau",
		"isso-e-voce",
		"incrivel-identidade",
		"forma-revelada",
		"fantastica-expressao",
		"excelente",
		"eu-te-amo",
		"congratulacoes",
		"bom-trabalho",
		"bem-pensado",
		"belissima-escolha"
	]
	var random_congratulation = Random.choose(possible_congratulations)
	SoundManager.play_and_forget("confirm", 0, rand_range(0.8, 1.2))
	$VC1.visible = identidade == "rappi"
	$VC2.visible = identidade == "raissa"
	yield(get_tree().create_timer(0.25), "timeout")
	AmigoManager.protagonistico_type = identidade
	SoundManager.play_and_forget(random_congratulation, 0, rand_range(0.9, 1.1))

func set_random_background():
	var possible_backgrounds = [
		"res://assets/ui/identidade/declare-identidade.png",
		"res://assets/ui/identidade/declare-identidade2.png",
		"res://assets/ui/identidade/declare-identidade3.png",
		"res://assets/ui/identidade/declare-identidade4.png",
		"res://assets/ui/identidade/declare-identidade5.png",
		"res://assets/ui/identidade/declare-identidade6.png",
		"res://assets/ui/identidade/declare-identidade7.png",
		"res://assets/ui/identidade/declare-identidade8.png",
		"res://assets/ui/identidade/declare-identidade9.png",
		"res://assets/ui/identidade/declare-identidade10.png",
		"res://assets/ui/identidade/declare-identidade11.png"
	]
	var new_background = Random.choose(possible_backgrounds)
	$Background.texture = load(new_background)